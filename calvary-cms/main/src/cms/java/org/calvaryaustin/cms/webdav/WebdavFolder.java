package org.calvaryaustin.cms.webdav;

import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.webdav.lib.WebdavResource;
import org.calvaryaustin.cms.File;
import org.calvaryaustin.cms.FileAlreadyExistsException;
import org.calvaryaustin.cms.FileHandle;
import org.calvaryaustin.cms.FileNotFoundException;
import org.calvaryaustin.cms.Folder;
import org.calvaryaustin.cms.FolderAlreadyExistsException;
import org.calvaryaustin.cms.FolderHandle;
import org.calvaryaustin.cms.RepositoryException;

/**
 * 
 * @author jhigginbotham
 */
public class WebdavFolder implements Folder
{

	/**
	 * 
	 */
	public WebdavFolder(WebdavConnection connection, String site, String path, String name, String description)
	{
		super();
		this.connection = connection;
		this.site = site;
		this.path = path;
		this.name = name;
		this.description = description;
	}

	public FolderHandle createFolder(String name, String description)
		throws RepositoryException, FolderAlreadyExistsException
	{
		String thePath = WebdavConnection.normalize(path + "/" + name);
		String davPath = WebdavConstants.PATH_SITES+site+"/"+path;
		boolean result = connection.makeCollection( davPath, name );
		if( !result ) 
		{
			throw new FolderAlreadyExistsException("Folder already exists: "+thePath);
		}
		// Set description property
		boolean propResult = connection.setProperty(davPath+"/"+name, WebdavConstants.CALVARY_PROP_PREFIX, WebdavConstants.PROP_DESCRIPTION, description);
		if( !propResult ) 
		{
			log.warn("createFolder(): Could not set the property for the newly created folder  - not rolling back tx");
		}
		return new FolderHandle(thePath);
	}
	
	public FileHandle createFile(String name, String description, String contentType, String content) 
		throws RepositoryException, FileAlreadyExistsException
	{
		String thePath = WebdavConnection.normalize(path + "/" + name);
		String davPath = WebdavConstants.PATH_SITES+site+"/"+path;
		boolean result = connection.put(davPath, name, contentType, content);
		// Set description property
		boolean propResult = connection.setProperty(davPath+"/"+name, WebdavConstants.CALVARY_PROP_PREFIX, WebdavConstants.PROP_DESCRIPTION, description);
		if( !propResult ) 
		{
			log.warn("createFile(): Could not set the property for the newly created file  - not rolling back tx");
		}
		return new FileHandle(thePath);
	}
	

	public void delete() throws RepositoryException
	{
		connection.deleteResource( WebdavConstants.PATH_SITES+site, path );
	}

	public List browse() throws RepositoryException
	{
		// TODO Auto-generated method stub
		return null;
	}

	public File getFile(FileHandle handle)
		throws RepositoryException, FileNotFoundException
	{
		String davPath = WebdavConnection.normalize(WebdavConstants.PATH_SITES+site+"/"+handle.getPath());
		WebdavResource resource = connection.findResource(davPath);
		if( resource == null || !resource.exists())
		{
			throw new FileNotFoundException("File not found in site "+site+": "+handle.getPath());
		}
		WebdavFile file = new WebdavFile(connection, site, handle.getPath(), resource.getDisplayName(), new Date(resource.getCreationDate())); 
		return file;
	}

	public String getName()
	{
		return name;
	}

	public String getPath()
	{
		return path;
	}

	public String getDescription()
	{
		return description;
	}

	private String site;
	private String name;
	private String path;
	private String description;
	private WebdavConnection connection;
	private static final Log log = LogFactory.getLog( WebdavFolder.class );
}