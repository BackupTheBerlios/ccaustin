package org.calvaryaustin.cms.webdav;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.io.IOUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.webdav.lib.Lock;
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
		return toFileVersion(resource);
	}

	public boolean isCheckedOut() throws RepositoryException
	{
		WebdavResource resource = connection.findResource(WebdavConstants.PATH_SITES+site+"/"+path);
		return resource.isLocked();
	}

	public List getLocks() throws RepositoryException
	{
		LinkedList locks = new LinkedList();
		WebdavResource resource = connection.findResource(WebdavConstants.PATH_SITES+site+"/"+path);
		Lock[] lockResources = resource.getLockDiscovery().getActiveLocks();
		if(lockResources != null)
		{
			for(int i=0;i<lockResources.length;i++)
			{
				WebdavLock lock = new WebdavLock(lockResources[i].getLockToken(), lockResources[i].getOwner());
				locks.add(lock);
			}
		}
		return locks;
	}

	public void killLocks() throws RepositoryException
	{
		connection.killLocks(WebdavConstants.PATH_SITES+site+"/"+path);
	}

	public FileVersion checkout()
		throws RepositoryException, FileLockedException
	{
		WebdavResource resource = connection.checkout(WebdavConstants.PATH_SITES+site+"/"+path);
		return toFileVersion(resource);
	}

	public void checkin(FileVersion updatedVersion)
		throws RepositoryException, FileNotLockedException
	{
		// set name="" as the path has the name included
		// ?Should the content type be allowed to change? If its null, it won't anyway...
		connection.put(WebdavConstants.PATH_SITES+site+"/"+path,"",updatedVersion.getContentType(),updatedVersion.getContent());
		connection.checkin(WebdavConstants.PATH_SITES+site+"/"+path);
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

	//
	// -- Helpers
	//
	
	private FileVersion toFileVersion(WebdavResource resource)
		throws RepositoryException
	{
		HashMap properties = connection.getProperties( resource.getPath() );
		String description = (String)properties.get(WebdavConstants.CALVARY_PROP_PREFIX+WebdavConstants.PROP_DESCRIPTION);
		
		try 
		{
			WebdavFileVersion version = new WebdavFileVersion(connection, site, resource.getPath(), description, null, 
															  null, new Date(resource.getGetLastModified()), null, 
															  resource.getGetContentType(), getContentAsByteArray(resource));
			return version;
		} catch(IOException e)
		{
			throw new RepositoryException("I/O error while fetching content for the latest version",e);
		}
	}

	private byte[] getContentAsByteArray(WebdavResource resource) throws IOException
	{
		InputStream in = resource.getMethodData();
		return IOUtil.toByteArray(in);
	}

	private String site;
	private String name;
	private String path;
	private Date creationDate;
	private WebdavConnection connection;
	private static final Log log = LogFactory.getLog( WebdavFile.class );
}
