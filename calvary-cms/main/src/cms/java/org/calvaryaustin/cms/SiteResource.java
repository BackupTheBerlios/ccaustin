package org.calvaryaustin.cms;

import java.util.List;

/**
 * A Site Resource is anything that a site may contain - pages, folders, links, etc. 
 * @author jhigginbotham
 */
public interface SiteResource
{
	/**
	 * @return
	 */
	public String getName();
	/**
	 * @return
	 */
	public String getPath();
	
	public boolean isLocked();
	
	public boolean isFolder();
	
	public List getLocks();
	
	/**
	 * @throws RepositoryException
	 */
	public void delete() throws RepositoryException;	
	
	
}
