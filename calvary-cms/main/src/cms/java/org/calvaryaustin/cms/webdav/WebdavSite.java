package org.calvaryaustin.cms.webdav;

import java.util.HashMap;
import java.util.List;

import org.apache.webdav.lib.WebdavResource;
import org.calvaryaustin.cms.Folder;
import org.calvaryaustin.cms.FolderHandle;
import org.calvaryaustin.cms.FolderNotFoundException;
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
	public WebdavSite(WebdavConnection connection, String id, String name, String description)
	{
		super();
		
		this.connection = connection;
		this.id = id;
		this.name = name;
		this.description = description;
	}

	public String getId()
	{
		return id;
	}

	public String getName()
	{
		return name;
	}

	public String getDescription()
	{
		return description;
	}

	public Folder getRootFolder() throws RepositoryException
	{
		WebdavResource folderResource = connection.findResource( WebdavConstants.PATH_SITES + getName() );
		if(folderResource != null && folderResource.exists())
		{
			HashMap properties = connection.getProperties( folderResource.getPath() );
			String description = (String)properties.get(WebdavConstants.CALVARY_PROP_PREFIX+WebdavConstants.PROP_DESCRIPTION);
			WebdavFolder folder = new WebdavFolder(connection, name, "/", "/", description);
			return folder;			
		}
		throw new FolderNotFoundException("Root folder not found for site "+getName());
	}
	
	public Folder getFolder(FolderHandle handle) throws RepositoryException, FolderNotFoundException
	{
		WebdavResource folderResource = connection.findResource( WebdavConstants.PATH_SITES + getName() +"/" + handle.getPath() );
		if(folderResource != null && folderResource.exists())
		{
			HashMap properties = connection.getProperties( folderResource.getPath() );
			String description = (String)properties.get(WebdavConstants.CALVARY_PROP_PREFIX+WebdavConstants.PROP_DESCRIPTION);
			WebdavFolder folder = new WebdavFolder(connection, name, handle.getPath(), folderResource.getDisplayName(), description);
			return folder;			
		}
		throw new FolderNotFoundException("Folder not found "+handle.getPath());
	}

	public void delete() throws RepositoryException
	{
		connection.deleteResource( WebdavConstants.PATH_SITES, getId() );
	}

	private WebdavConnection connection;
	private String id;
	private String name;
	private String description;
}
