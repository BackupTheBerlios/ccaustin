package org.calvaryaustin.cms.webdav;

import java.io.IOException;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.util.HttpURL;
import org.apache.webdav.lib.WebdavResource;
import org.calvaryaustin.cms.RepositoryException;

/**
 * RepositoryUtil.java
 *
 *
 * Created: Tue Jan 28 20:14:37 2003
 *
 * @author <a href="mailto:jhigginbotham@betweenmarkets.com">James Higginbotham</a>
 * @version $Revision: 1.1 $
 */

public class WebdavConnection 
{
	public WebdavConnection(String host, int port, String path, String username, String password)
	{
    	this.host = host;
    	this.port = port;
    	this.path = path;
    	this.username = username;
    	this.password = password;
	}
	
	public WebdavResource findResource(String path) throws RepositoryException
	{
	  WebdavResource webdavResource = null;	
	  try 
	  {
		log.trace("findResource(): Finding resource "+path);
		String fullPath = ( path.startsWith( PATH_PREFIX ) ? path : PATH_PREFIX + "/" + path );
		String normalizedPath = normalize( fullPath );
		log.trace("findResource():   normalized path "+normalizedPath);
		webdavResource = new WebdavResource( getConnection() );
		webdavResource.setDebug( DEBUG_LEVEL );
		webdavResource.setPath( normalizedPath );
		return webdavResource;
	  }
	  catch (HttpException e)
	  {
	  	if(e.getReasonCode() == 404)
	  	{ 
	  		log.trace("findResource():   Got 404 - resource not found");
	  		return webdavResource;
	  	}
		throw new RepositoryException("Error while locating path "+path,e);
	  } // end of try-catch
	  catch (IOException e)
	  {
		throw new RepositoryException("Error while performing I/O during path location for "+path,e);
	  } // end of try-catch
	}

	public WebdavResource[] listResources(String path) throws RepositoryException
	{
		try
		{
			return findResource( path ).getChildResources().listResources();
		} catch (HttpException e)
		{
		  if(e.getReasonCode() == 404)
		  { 
			  log.trace("listResources():   resource not found: "+path);
			  return new WebdavResource[0];
		  }
		  throw new RepositoryException("Error while locating path or children of path "+path,e);
		} // end of try-catch
		catch (IOException e)
		{
		  throw new RepositoryException("Error while performing I/O during path or children location for "+path,e);
		} // end of try-catch

	}

	public boolean makeCollection(String path, String collectionName  ) throws RepositoryException
	{
	  try 
	  {
		log.trace("makeCollection(): Making collection with name "+collectionName);
		WebdavResource webdavResource = findResource( path + "/" + collectionName);
		if ( webdavResource != null && webdavResource.exists() )
		{
		  log.trace("makeCollection(): resource exists already");
		  return false;
		} // end of if ()

		if (webdavResource.mkcolMethod() )
		{
		  log.trace("makeCollection(): Directory created");
		  return true;
		}
		else
		{
		  log.trace("makeCollection(): Directory creation failed: "+webdavResource.getStatusMessage());
		  throw new RepositoryException("Directory creation failed: "+webdavResource.getStatusMessage());
		} // end of else
	  }
	  catch (HttpException e)
	  {
		throw new RepositoryException("HTTP Exception during directory creation",e);
	  } // end of try-catch
	  catch (IOException e)
	  {
		throw new RepositoryException("I/O Exception during directory creation",e);
	  } // end of try-catch
    
	}

	public boolean deleteCollection(String path, String collectionName  ) throws RepositoryException
	{
	  try 
	  {
		log.trace("deleteCollection(): Deleting collection with name "+collectionName);
		WebdavResource webdavResource = findResource( path + "/" + collectionName);
		if ( webdavResource == null || !webdavResource.exists() )
		{
		  log.trace("deleteCollection(): site not found");
		  return false;
		} // end of if ()

		if (webdavResource.deleteMethod() )
		{
		  log.trace("deleteCollection(): Directory deleted");
		  return true;
		}
		else
		{
		  log.trace("makeCollection(): Directory deletion failed: "+webdavResource.getStatusMessage());
		  throw new RepositoryException("Directory deletion failed: "+webdavResource.getStatusMessage());
		} // end of else
	  }
	  catch (HttpException e)
	  {
		throw new RepositoryException("HTTP Exception during directory creation",e);
	  } // end of try-catch
	  catch (IOException e)
	  {
		throw new RepositoryException("I/O Exception during directory creation",e);
	  } // end of try-catch
    
	}


    /**
     * Return a context-relative path, beginning with a "/", that represents
     * the canonical version of the specified path after ".." and "." elements
     * are resolved out.  If the specified path attempts to go outside the
     * boundaries of the current context (i.e. too many ".." path elements
     * are present), return <code>null</code> instead.
     *
     * @param path the path to be normalized.
     * @return the normalized path.
     */
    public static String normalize(String path) 
    {
        if (path == null)
            return null;

        String normalized = path;

        // Normalize the slashes and add leading slash if necessary
        if (normalized.indexOf('\\') >= 0)
            normalized = normalized.replace('\\', '/');
        if (!normalized.startsWith("/"))
            normalized = "/" + normalized;

        // Resolve occurrences of "/./" in the normalized path
        while (true) {
            int index = normalized.indexOf("/./");
            if (index < 0)
            break;
            normalized = normalized.substring(0, index) +
            normalized.substring(index + 2);
        }

        // Resolve occurrences of "/../" in the normalized path
        while (true) {
            int index = normalized.indexOf("/../");
            if (index < 0)
            break;
            if (index == 0)
            return ("/");  // The only left path is the root.
            int index2 = normalized.lastIndexOf('/', index - 1);
            normalized = normalized.substring(0, index2) +
            normalized.substring(index + 3);
        }

        // Resolve occurrences of "//" in the normalized path
        while (true) {
            int index = normalized.indexOf("//");
            if (index < 0)
            break;
            normalized = normalized.substring(0, index) +
            normalized.substring(index + 1);
        }

        // Return the normalized path that we have completed
        return (normalized);
    }

	private HttpURL getConnection()
	{
		return new HttpURL(username, password, host, port, path );	
	}

	private String host;
	private int port;
	private String path;
	private String username;
	private String password; 

    private static final int DEBUG_LEVEL = 0;
    private static final String FILES_PREFIX = "/files/"; // move to config?
    private static final String PATH_PREFIX = "/slide"+FILES_PREFIX; // move to config?
    private static final Log log = LogFactory.getLog( WebdavConnection.class );
}// RepositoryUtil
