package org.calvaryaustin.cms;

import org.calvaryaustin.cms.webdav.WebdavRepository;

/**
 * The singleton factory from which a repository is obtained. Manages the creation of the proper underlying transport given the arguments provided. 
 * @author jhigginbotham
 */
public class RepositoryFactory
{

	public static Repository getRepository(String host, int port, String path, String username, String password) throws RepositoryException
	{
		return new WebdavRepository( host, port, path, username, password );
	} 

	/**
	 * We never create this class
	 */
	private RepositoryFactory() { }

}
