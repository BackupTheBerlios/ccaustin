package org.calvaryaustin.cms;

/**
 * A folder can contain folders or pages
 * @author jhigginbotham 
 */
public interface Folder extends SiteResource
{
	public Folder createFolder(String name) throws RepositoryException;
}
