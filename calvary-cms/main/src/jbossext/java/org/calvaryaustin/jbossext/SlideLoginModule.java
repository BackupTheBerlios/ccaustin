package org.calvaryaustin.jbossext;

import java.security.Principal;
import java.security.acl.Group;
import java.util.Enumeration;
import java.util.Map;

import javax.security.auth.Subject;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.login.LoginException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.slide.authenticate.CredentialsToken;
import org.apache.slide.authenticate.SecurityToken;
import org.apache.slide.common.Domain;
import org.apache.slide.common.NamespaceAccessToken;
import org.apache.slide.common.SlideException;
import org.apache.slide.common.SlideToken;
import org.apache.slide.common.SlideTokenImpl;
import org.apache.slide.content.Content;
import org.apache.slide.content.NodeProperty;
import org.apache.slide.content.NodeRevisionDescriptor;
import org.apache.slide.content.NodeRevisionDescriptors;
import org.apache.slide.security.Security;
import org.apache.slide.structure.ObjectNode;
import org.jboss.security.SimpleGroup;
import org.jboss.security.SimplePrincipal;
import org.jboss.security.auth.spi.UsernamePasswordLoginModule;

/**
 * A custom JBoss 3.x login module that talks directly to the Slide kernel to authenticate
 * a user. The module adheres to the internal JBoss mechanism for establishing an authenicated
 * user's credentials. Thus, calls to hasRole() from the servlet API are honored and checks for
 * 'user', 'guest', and 'root' can be made from the web tier. 
 * <p>
 * To setup this login module:
 *   <ol>
 *     <li>Edit the JBoss login-config.xml and add the following entry (substituting the namespace 
 *       based on the context you are deploying the war under):
 *        <pre>
 *&lt;application-policy name = "SlideRealm"&gt;
 *  &lt;authentication&gt;
 *   &lt;login-module code = "org.calvaryaustin.jbossext.SlideLoginModule" flag = "required"&gt;
 *       &lt;module-option name = "namespace"&gt;slide&lt;/module-option&gt;
 *   &lt;/login-module&gt;
 *  &lt;/authentication&gt;
 *&lt;/application-policy&gt;
 *        </pre>
 *     </li>
 *     <li>Uncomment the security section in the web.xml for the slide WAR</li>
 *     <li>Change the realm entry to read:
 *        <pre>
 *&lt;realm-name&gt;SlideRealm&lt;/realm-name&gt;
 *        </pre>
 *     </li>
 *     <li>Compile this class, jar it up and place it under $JBOSS_HOME/server/default/lib
 *     (change default to all if you are using the clustering configuration)</li>
 *     <li>Deploy the slide war with the updated web.xml descriptor and sign in as root/root 
 *      (assuming a default installation of Slide)</li>
 *   </ol>
 * </p>  
 * @author <a href="mailto:jwhigginbotham@users.sourceforge.net">James Higginbotham</a>
 */
public class SlideLoginModule extends UsernamePasswordLoginModule
{

   /**
    * Initializes the login module with the references to its environment
    * @see javax.security.auth.spi.LoginModule#initialize(Subject, CallbackHandler, Map, Map)
    */
    public void initialize(Subject subject, CallbackHandler callbackHandler, 
    						Map sharedState, Map options)
    {
        super.initialize(subject, callbackHandler, sharedState, options);
        
        // init the namespace using the module's config 
        String namespace = (String) options.get("namespace");
        log.debug("SlideLoginModule initializing...");

		// create an access token
        if (accessToken == null)
            accessToken = Domain.accessNamespace
                (new SecurityToken(this), namespace);

        if (accessToken == null)
            throw new IllegalStateException
                ("Invalid Slide Realm configuration : "
                 + "Couldn't access namespace " + namespace);

 		// initialize other Slide helpers
        contentHelper = accessToken.getContentHelper();
        securityHelper = accessToken.getSecurityHelper();

        usersPath = accessToken.getNamespaceConfig().getUsersPath();
        log.debug("SlideLoginModule initialized...");
    }

	/**
	 * Return the password for the current username that is being authenticated
	 * @see org.jboss.security.auth.spi.UsernamePasswordLoginModule#getUsersPassword()
	 */
    protected String getUsersPassword() throws LoginException
    {
        String username = getUsername();
        log.debug("SlideLoginModule getUsersPassword() for "+username);
        if( username == null )
        {
            // no sense in looking up /users/null...
            return null;
        }
        Principal userPrincipal = getPrincipal(username);
        CredentialsToken credToken = new CredentialsToken(userPrincipal);
        SlideToken slideToken = new SlideTokenImpl(credToken);
        
        // Fetch the Slide object representing the user.
        try {
            
            ObjectNode user = securityHelper.getPrincipal(slideToken);
            
        } catch (SlideException e) {
            e.printStackTrace();
            return null;
        }
        
        String passwordValue = null;
        
        try {
            
            NodeRevisionDescriptors revisionDescriptors =
                contentHelper.retrieve(slideToken, usersPath + "/" + username);
            NodeRevisionDescriptor revisionDescriptor =
                contentHelper.retrieve(slideToken, revisionDescriptors);
            NodeProperty password =
                revisionDescriptor.getProperty
                ("password", NodeProperty.SLIDE_NAMESPACE);
            if (password != null) {
                passwordValue = (String) password.getValue();
            }
            
        } catch (SlideException e) {
            // Whatever happens doesn't really matter
            // The stack trace is displayed for now for debug purposes
            log.debug("Caught during password fetch",e);
        }
        
        if (passwordValue == null) {
            log.warn("User " + username
                + " doesn't have his password property set : "
                + "can't authenticate");
        }
        
        return passwordValue;
    }

	/**
	 * Return an array of Groups that will be attached to the user's Principal. JBoss
	 * has a default 'Roles' group that is created with all of the roles found for the 
	 * user (usually the default Slide set of nobody and guest, user, or root)
	 * @see org.jboss.security.auth.spi.AbstractServerLoginModule#getRoleSets()
	 */
    protected Group[] getRoleSets() throws LoginException
    {
        SimpleGroup rolesGroup = new SimpleGroup("Roles");
        Group[] groups = new Group[1];
        groups[0] = rolesGroup;

        String username = getUsername();
        Principal userPrincipal = getPrincipal(username);
        CredentialsToken credToken = new CredentialsToken(userPrincipal);
        SlideToken slideToken = new SlideTokenImpl(credToken);
        try {
			Enumeration e = securityHelper.getRoles(slideToken);
			while(e.hasMoreElements())
			{
                // convert to an array
                String role = (String)e.nextElement();
                log.debug("Adding new SimplePrincipal with role="+role);
                rolesGroup.addMember( new SimplePrincipal( role ) );
			}
        } catch (SlideException e) {
            // The stack trace is displayed for now for debug purposes
            e.printStackTrace();
            log.debug("Caught during roles fetch",e);
        }
	    return groups;            
    }
    
    /**
     * Returns an internal slide principal for the given username
     * @param username
     * @return Principal
     */
    private Principal getPrincipal(String username) 
    {
    	return new SlideRealmPrincipal(username);
    }
    
    /**
     * Set of access tokens.
     */
    private NamespaceAccessToken accessToken;
    /**
     * Content helper.
     */
    private Content contentHelper;
    /**
     * Security halper.
     */
    private Security securityHelper;
    /**
     * Users path.
     */
    private String usersPath;
    /**
     * Root credentials token.
     */
    private CredentialsToken rootCredentials;
    /**
     * Namepsace to which this realm will connect.
     */
    private String namespace;
	/**
	 * Static logger
	 */
    private static final Log log = LogFactory.getLog( SlideLoginModule.class );;

}


/**
 * Private class representing an individual user's Principal object.
 */

final class SlideRealmPrincipal implements Principal 
{
    /**
     * The username for this Principal.
     */
    private String username = null;

    /**
     * Construct a new MemoryRealmPrincipal instance.
     *
     * @param username The username for this Principal
     */
    public SlideRealmPrincipal(String username) {

    this.username = username;

    }

    /**
     * Return the name of this Principal.
     */
    public String getName() {

    return (username);

    }
}

