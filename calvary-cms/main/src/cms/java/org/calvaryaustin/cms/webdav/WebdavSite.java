package org.calvaryaustin.cms.webdav;

import java.util.List;

import org.calvaryaustin.cms.Folder;
import org.calvaryaustin.cms.RepositoryException;
import org.calvaryaustin.cms.Site;
import org.calvaryaustin.cms.SiteResource;
import org.calvaryaustin.cms.SiteResourceHandle;

/**
 * Site implementation that uses a WebdavConnection to do its work
 * @author jhigginbotham
 */
public class WebdavSite implements Site
{

	/**
	 * 
	 */
	public WebdavSite(WebdavConnection connection, String id, String name)
	{
		super();
		
		this.connection = connection;
		this.id = id;
		this.name = name;
	}

	/* (non-Javadoc)
	 * @see org.calvaryaustin.cms.Site#getId()
	 */
	public String getId()
	{
		return id;
	}

	/* (non-Javadoc)
	 * @see org.calvaryaustin.cms.Site#getName()
	 */
	public String getName()
	{
		return name;
	}

	/* (non-Javadoc)
	 * @see org.calvaryaustin.cms.Site#getRootFolder()
	 */
	public Folder getRootFolder()
	{
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see org.calvaryaustin.cms.Site#browse()
	 */
	public List browse() throws RepositoryException
	{
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see org.calvaryaustin.cms.Site#browse(org.calvaryaustin.cms.SiteResourceHandle)
	 */
	public List browse(SiteResourceHandle startingPath)
		throws RepositoryException
	{
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see org.calvaryaustin.cms.Site#browse(java.lang.String)
	 */
	public List browse(String startingPath) throws RepositoryException
	{
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see org.calvaryaustin.cms.Site#getResource(org.calvaryaustin.cms.SiteResourceHandle)
	 */
	public SiteResource getResource(SiteResourceHandle handle)
		throws RepositoryException
	{
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see org.calvaryaustin.cms.Site#getResource(java.lang.String)
	 */
	public SiteResource getResource(String uri) throws RepositoryException
	{
		// TODO Auto-generated method stub
		return null;
	}

	private WebdavConnection connection;
	private String id;
	private String name;
}
