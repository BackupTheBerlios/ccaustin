package org.calvaryaustin.cms.slide;

import org.apache.slide.common.NamespaceAccessToken;
import org.apache.slide.common.NamespaceConfig;
import org.apache.slide.common.SlideException;
import org.apache.slide.common.SlideToken;
import org.apache.slide.security.Security;
import org.apache.slide.structure.ObjectNode;
import org.apache.slide.structure.Structure;

/**
 * Retrieves a user from the slide framework to allow for modifications - does not perform 
 * any locking, and does not return the password
 * @author jhigginbotham
 */
public class GetUserCommand extends AbstractSlideCommand
{

	/**
	 * Initialize the command
	 * @param slideToken The slidetoken to use when performing the work
	 * @param namespace the namespace access token to use when performing the work
	 * @param username the username of the user to fetch
	 */
	public GetUserCommand(SlideToken slideToken, NamespaceAccessToken namespace, String username)
	{
		super(slideToken, namespace);
		this.username = username;
	}

	public void execute() throws SlideException
	{
		// get the helpers
		Structure structure = namespace.getStructureHelper();
		Security security = namespace.getSecurityHelper();
		NamespaceConfig nc = namespace.getNamespaceConfig();
            
		// find the user
		String userUri = nc.getUsersPath() + "/" + username;
		ObjectNode userNode = structure.retrieve(slideToken, userUri);
            
		if (security.hasRole(userNode, "root")) {
			rootAccess = true;
		}
	}

	/**
	 * @return
	 */
	public boolean getRootAccess()
	{
		return rootAccess;
	}

	/**
	 * @return
	 */
	public String getUsername()
	{
		return username;
	}

	private String username; 
	private boolean rootAccess;
}
