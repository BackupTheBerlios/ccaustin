package org.calvaryaustin.cms.slide;

import java.util.Date;

import org.apache.slide.common.NamespaceAccessToken;
import org.apache.slide.common.NamespaceConfig;
import org.apache.slide.common.SlideException;
import org.apache.slide.common.SlideToken;
import org.apache.slide.content.NodeProperty;
import org.apache.slide.content.NodeRevisionDescriptor;
import org.apache.slide.content.NodeRevisionDescriptors;
import org.apache.slide.structure.ObjectNode;

/**
 * Creates a user within the slide framework, such that future role checks for obtaining locks, 
 * editing content, etc. are properly authorized
 * @author jhigginbotham
 */
public class CreateUserCommand extends AbstractSlideCommand 
{

	/**
	 * Initialize the command
	 * @param slideToken The slidetoken to use when performing the work
	 * @param namespace the namespace access token to use when performing the work
	 * @param username the username to create
	 * @param password the password to set for the user
	 * @param rootAccess true if the user is to have root access
	 */
	public CreateUserCommand(SlideToken slideToken,	NamespaceAccessToken namespace, String username, String password, boolean rootAccess) 
	{
		super(slideToken, namespace);
		
		this.username = username;
		this.password = password;
		this.rootAccess = rootAccess;
	}

	public void execute() throws SlideException 
	{
		NamespaceConfig nc = namespace.getNamespaceConfig();
		String strUri = nc.getUsersPath() + "/" + username;
		// create the node in the structure
		ObjectNode object;
		if ( rootAccess ) {
			object = new slideroles.basic.RootRoleImpl();
		} else {
			object = new slideroles.basic.UserRoleImpl();
		}
		structure.create(slideToken, object, strUri);
                    
		// create a revision with the appropriate properties set
		NodeRevisionDescriptor revision = 
			new NodeRevisionDescriptor(0);
		revision.setProperty(
			new NodeProperty("resourcetype", "<collection/>",
							 true));
		revision.setCreationDate(new Date());
		revision.setLastModified(new Date());
		revision.setProperty(
			new NodeProperty("getcontentlength", "0", true));
		revision.setProperty(
			new NodeProperty("source", "", true));
		revision.setProperty(
			new NodeProperty("password", password,
							 NodeProperty.SLIDE_NAMESPACE));
		content.create(slideToken, strUri, revision, null);
	}

	private String username; 
	private String password; 
	private boolean rootAccess;
}
