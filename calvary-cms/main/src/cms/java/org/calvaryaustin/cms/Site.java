package org.calvaryaustin.cms;

import java.util.List;

/**
 * A Site belongs to a repository and has one or more Pages.
 * @author jhigginbotham
 */
public interface Site
{
	/**
	 * Returns the unique id of the site
	 * @return the unique id of the site
	 */
	public String getId();
	/**
	 * Returns the unique name of the site
	 * @return the unique name of the site
	 */
	public String getName();
	/**
	 * Returns the root folder for the site
	 * @return the root folder for the site
	 */
	public Folder getRootFolder();
	/**
	 * Returns a list of handles to resources in the root of the site
	 * @return a list of handles to resources in the root of the site
	 * @throws RepositoryException if an error occurs during browsing
	 */
	public List browse() throws RepositoryException;
	/**
	 * Returns a list of handles to resources of the site relative to the starting path
	 * @param startingPath the starting path to browse 
	 * @return a list of handles to resources in the startingPath
	 * @throws RepositoryException if an error occurs during browsing
	 */
	public List browse(SiteResourceHandle startingPath) throws RepositoryException;
	/**
	 * Returns a list of handles to resources of the site relative to the starting path
	 * @param startingPath the starting path to browse 
	 * @return a list of handles to resources in the startingPath
	 * @throws RepositoryException if an error occurs during browsing
	 */
	public List browse(String startingPath) throws RepositoryException;
	/**
	 * Returns a resource from the site for viewing, editing, etc. 
	 * @param handle a handle to the resource to retrieve
	 * @return a resource from the site for viewing, editing, etc.
	 * @throws RepositoryException if an error occurs during retrieval
	 */
	public SiteResource getResource(SiteResourceHandle handle) throws RepositoryException;
	/**
	 * Returns a resource from the site for viewing, editing, etc. 
	 * @param uri uri to the resource to retrieve
	 * @return a resource from the site for viewing, editing, etc.
	 * @throws RepositoryException if an error occurs during retrieval
	 */
	public SiteResource getResource(String uri) throws RepositoryException;
}
