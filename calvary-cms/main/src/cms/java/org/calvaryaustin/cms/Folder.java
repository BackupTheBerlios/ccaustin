package org.calvaryaustin.cms;

import java.util.List;

/**
 * A folder can contain folders and/or files
 * @author jhigginbotham 
 */
public interface Folder extends SiteResource
{
	/**
	 * @return
	 */
	public String getDescription();	
	/**
	 * Creates a new folder as a child of this folder
	 * @param name the name of the folder
	 * @return a handle to the new folder created
	 * @throws RepositoryException is an error occurs
	 * @throws FolderAlreadyExistsException if the folder name already exists as a child of this folder
	 */
	public FolderHandle createFolder(String name, String description) throws RepositoryException, FolderAlreadyExistsException;
	
	/**
	 * Creates a new file as a child of this folder
	 * @param name the name of the file
	 * @param description the description for the file
	 * @param contentType the content type of the file, such as text/xml
	 * @param content the content of the file
	 * @return a handle to the new file created
	 * @throws RepositoryException is an error occurs
	 * @throws FileAlreadyExistsException if the file name already exists as a child of this folder
	 */
	public FileHandle createFile(String name, String description, String contentType, String content) 
		throws RepositoryException, FileAlreadyExistsException;
	
	/**
	 * Deletes this folder and all child resources
	 */
	public void delete() throws RepositoryException;
	
	/**
	 * Returns a list of Folder and File instances in the root of the site
	 * @return a list of Folder and File instances in the root of the site
	 * @throws RepositoryException if an error occurs during browsing
	 */
	public List browse() throws RepositoryException;
	
	/**
	 * Returns a file from the site for viewing, editing, etc. 
	 * @param handle a handle to the file to retrieve
	 * @return a file from the site for viewing, editing, etc.
	 * @throws RepositoryException if an error occurs during retrieval
	 */
	public File getFile(FileHandle handle) throws RepositoryException, FileNotFoundException;
}
