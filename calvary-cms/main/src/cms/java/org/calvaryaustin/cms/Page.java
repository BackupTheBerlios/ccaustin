package org.calvaryaustin.cms;

import java.util.List;

/**
 * 
 * @author jhigginbotham
 */
public interface Page extends SiteResource
{
	public PageVersion getLatestVersion();
	
	public List getVersions();
	
	/**
	 * @throws RepositoryException
	 */
	public PageVersion checkout() throws RepositoryException;	
	/**
	 * @throws RepositoryException
	 */
	public void checkin(PageVersion updatedVersion, boolean forkOnCheckin) throws RepositoryException;	
}
