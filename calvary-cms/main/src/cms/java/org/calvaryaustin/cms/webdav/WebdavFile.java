package org.calvaryaustin.cms.webdav;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.webdav.lib.WebdavResource;
import org.calvaryaustin.cms.File;
import org.calvaryaustin.cms.FileLockedException;
import org.calvaryaustin.cms.FileNotLockedException;
import org.calvaryaustin.cms.FileVersion;
import org.calvaryaustin.cms.RepositoryException;

/**
 * 
 * @author jhigginbotham
 */
public class WebdavFile implements File
{
	/**
	 * 
	 */
	public WebdavFile(WebdavConnection connection, String site, String path, String name, Date creationDate)
	{
		super();
		this.connection = connection;
		this.site = site;
		this.path = path;
		this.name = name;
		this.creationDate = creationDate;
	}
	
	public Date getCreationDate()
	{
		return creationDate;
	}

	public FileVersion getLatestVersion() throws RepositoryException
	{
		String davPath = WebdavConnection.normalize(WebdavConstants.PATH_SITES+site+"/"+path);
		WebdavResource resource = connection.findResource(davPath);
		HashMap properties = connection.getProperties( resource.getPath() );
		String description = (String)properties.get(WebdavConstants.CALVARY_PROP_PREFIX+WebdavConstants.PROP_DESCRIPTION);
		
		try 
		{
			WebdavFileVersion version = new WebdavFileVersion(connection, site, resource.getPath(), description, null, 
															  null, new Date(resource.getGetLastModified()), null, 
															  resource.getGetContentType(), resource.getMethodDataAsString());
			return version;
		} catch(java.io.IOException e)
		{
			throw new RepositoryException("I/O error while fetching content for the latest version",e);
		}
	}

	public boolean isCheckedOut() throws RepositoryException
	{
		// TODO Auto-generated method stub
		return false;
	}

	public List getLocks() throws RepositoryException
	{
		// TODO Auto-generated method stub
		return null;
	}

	public void killLocks() throws RepositoryException
	{
		// TODO Auto-generated method stub

	}

	public FileVersion checkout()
		throws RepositoryException, FileLockedException
	{
		// TODO Auto-generated method stub
		return null;
	}

	public void checkin(FileVersion updatedVersion)
		throws RepositoryException, FileNotLockedException
	{
		// TODO Auto-generated method stub

	}

	public void delete() throws RepositoryException, FileLockedException
	{
		connection.deleteResource( WebdavConstants.PATH_SITES+site, path );
	}

	public String getName()
	{
		return name;
	}

	public String getPath()
	{
		return path;
	}

	private String site;
	private String name;
	private String path;
	private Date creationDate;
	private WebdavConnection connection;
	private static final Log log = LogFactory.getLog( WebdavFile.class );
}
