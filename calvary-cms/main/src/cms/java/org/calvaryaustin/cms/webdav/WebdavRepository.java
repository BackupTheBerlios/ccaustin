package org.calvaryaustin.cms.webdav;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.util.HttpURL;
import org.apache.webdav.lib.WebdavResource;
import org.calvaryaustin.cms.Repository;
import org.calvaryaustin.cms.RepositoryException;
import org.calvaryaustin.cms.Site;
import org.calvaryaustin.cms.SiteAlreadyExistsException;
import org.calvaryaustin.cms.SiteHandle;
import org.calvaryaustin.cms.SiteNotFoundException;

/**
 * Implementation of the Repository API that manages sites in the repository
 * using a WebdavConnection
 * @author jhigginbotham
 */
public class WebdavRepository implements Repository
{

	/**
	 * Initialize the WebDAV connection with the given url, username, and password
	 */
	public WebdavRepository(String host, int port, String path, String username, String password) throws RepositoryException
	{
		super();
		connection = new WebdavConnection( host, port, path, username, password );
		initRepository();
	}

	public List getSiteList() throws RepositoryException
	{
		LinkedList list = new LinkedList();
		WebdavResource[] sites = connection.listResources( WebdavConstants.PATH_SITES );
		for(int i=0;i<sites.length;i++)
		{
			WebdavResource site = sites[i]; 
			HashMap properties = connection.getProperties( site.getPath() );
			String description = (String)properties.get(WebdavConstants.CALVARY_PROP_PREFIX+WebdavConstants.PROP_DESCRIPTION);
			list.add( new WebdavSite(connection, site.getDisplayName(), site.getDisplayName(), description) );
		}
		return list;
	}

	public Site getSite(SiteHandle handle)
		throws RepositoryException, SiteNotFoundException
	{
		WebdavResource site = connection.findResource( WebdavConstants.PATH_SITES + handle.getId() );
		if(site != null && site.exists())
		{
			HashMap properties = connection.getProperties( site.getPath() );
			String description = (String)properties.get(WebdavConstants.CALVARY_PROP_PREFIX+WebdavConstants.PROP_DESCRIPTION);
			WebdavSite foundSite = new WebdavSite(connection, site.getDisplayName(), site.getDisplayName(), description);
			return foundSite;			
		}
		throw new SiteNotFoundException("Site not found: "+handle.getId());
	}

	public SiteHandle createSite(String sitename, String description)
		throws RepositoryException, SiteAlreadyExistsException
	{
		boolean result = connection.makeCollection( WebdavConstants.PATH_SITES, sitename );
		if( !result ) 
		{
			throw new SiteAlreadyExistsException("Site already exists: "+sitename);
		}
		// Set description property
		boolean propResult = connection.setProperty(WebdavConstants.PATH_SITES+sitename, WebdavConstants.CALVARY_PROP_PREFIX, WebdavConstants.PROP_DESCRIPTION, description);
		if( !propResult ) 
		{
			log.warn("createSite(): Could not set the property for the newly created site - not rolling back tx");
		}
		return new SiteHandle(sitename, sitename);
	}

	private void initRepository() throws RepositoryException
	{
		// make the sites collection so we can create sites - will check if it exists first
		connection.makeCollection( ROOT, WebdavConstants.SITES_COLLECTION_NAME );
	}

	private WebdavConnection connection;
	private static final String ROOT = "";
	private static final Log log = LogFactory.getLog( WebdavRepository.class );
}
