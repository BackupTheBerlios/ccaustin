package org.calvaryaustin.cms;

import java.util.List;

/**
 * A Repository manages sites
 * 
 * Independent of the transport used to connect to it.  
 * @author jhigginbotham
 */
public interface Repository
{
	/**
	 * Returns a list of SiteHandles managed by the repository
	 * @return a list of SiteHandles managed by the repository
	 * @throws RepositoryException if an error occurs 
	 */
	public List getSiteList() throws RepositoryException;
	/**
	 * Obtains a Site reference which can be used to perform further work, such as browsing a site
	 * or creating/editing pages
	 * @param handle a handle to the site to obtain
	 * @return the site reference
	 * @throws RepositoryException if an error occurs
	 * @throws SiteNotFoundException if the site was not found given a handle
	 */
	public Site getSite(SiteHandle handle) throws RepositoryException, SiteNotFoundException;
	/**
	 * Creates a new site in the repository
	 * @param sitename a sitename that is unique to the repository
	 * @param description a description of the site
	 * @return a handle to the newly created site
	 * @throws RepositoryException if an error occurs
	 * @throws SiteAlreadyExistsException if the site already exists in the repository
	 */
	public SiteHandle createSite(String sitename, String description) throws RepositoryException, SiteAlreadyExistsException;
}
