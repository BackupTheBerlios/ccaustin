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
	 * Returns the description of the site
	 * @return the description of the site
	 */
	public String getDescription();
	/**
	 * Returns the root folder for the site
	 * @return the root folder for the site
	 */
	public Folder getRootFolder() throws RepositoryException;
	/**
	 * Returns the folder for the given handle (path)
	 * @param handle the handle to the folder
	 * @return the folder for the path
	 * @throws RepositoryException if an error occurs
	 * @throws FolderNotFoundException if the folder was not found at the given path
	 */
	public Folder getFolder(FolderHandle handle) throws RepositoryException, FolderNotFoundException;

	/**
	 * Deletes this site from the repository
	 * @throws RepositoryException if an error occurs
	 */
	public void delete() throws RepositoryException;
}
