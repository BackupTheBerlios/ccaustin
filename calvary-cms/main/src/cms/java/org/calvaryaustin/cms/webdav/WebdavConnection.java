package org.calvaryaustin.cms.webdav;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.util.HttpURL;
import org.apache.webdav.lib.Property;
import org.apache.webdav.lib.PropertyName;
import org.apache.webdav.lib.ResponseEntity;
import org.apache.webdav.lib.WebdavResource;
import org.apache.webdav.lib.methods.DepthSupport;
import org.calvaryaustin.cms.RepositoryException;

/**
 * RepositoryUtil.java
 *
 *
 * Created: Tue Jan 28 20:14:37 2003
 *
 * @author <a href="mailto:jhigginbotham@betweenmarkets.com">James Higginbotham</a>
 * @version $Revision: 1.3 $
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

	public boolean deleteResource(String path, String collectionName  ) throws RepositoryException
	{
	  try 
	  {
		log.trace("deleteResource(): Deleting resource with name "+collectionName);
		String fullPath = path + "/" + collectionName;
		WebdavResource webdavResource = findResource( fullPath );
		if ( webdavResource == null || !webdavResource.exists() )
		{
		  throw new RepositoryException("Resource not found "+fullPath);
		} // end of if ()

		if (webdavResource.deleteMethod() )
		{
		  log.trace("deleteResource(): Resource deleted");
		  return true;
		}
		else
		{
		  log.trace("deleteResource(): Resource deletion failed: "+webdavResource.getStatusMessage());
		  throw new RepositoryException("Resource deletion failed: "+webdavResource.getStatusMessage());
		} // end of else
	  }
	  catch (HttpException e)
	  {
		throw new RepositoryException("HTTP Exception during resource deletion",e);
	  } // end of try-catch
	  catch (IOException e)
	  {
		throw new RepositoryException("I/O Exception during resource deletion",e);
	  } // end of try-catch
    
	}
	
	public HashMap getProperties(String path) throws RepositoryException
	{
		HashMap map = new HashMap();
		try 
		{
			WebdavResource webdavResource = findResource( path );
			Enumeration responses = webdavResource.propfindMethod(webdavResource.getPath(), DepthSupport.DEPTH_0); 
			while(responses.hasMoreElements())
			{
				ResponseEntity response = (ResponseEntity) responses.nextElement(); 
				Enumeration properties = response.getProperties(); 
				while (properties.hasMoreElements()) {
					org.apache.webdav.lib.Property property = (Property)properties.nextElement();
					log.trace("getProperties(): found property "+property.getName()+" with value "+property.getPropertyAsString());
					map.put(property.getName(), property.getPropertyAsString());
				}//while
			}
		}
		catch (HttpException e)
		{	
  			throw new RepositoryException("HTTP Exception during directory creation",e);
		} // end of try-catch
		catch (IOException e)
		{	
		  throw new RepositoryException("I/O Exception during directory creation",e);
		} // end of try-catch
		return map;
	}
	
	
	public boolean setProperty(String path, String prefix, String name, String value) throws RepositoryException
	{
		try 
		{
	 	    log.trace("setProperty(): Setting propery name "+prefix+name+" with value "+value+" for "+path);
		    WebdavResource webdavResource = findResource( path );
		    if ( webdavResource == null || !webdavResource.exists() )
		    {
			  log.trace("setProperty(): path not found "+path);
			  return false;
		    } // end of if ()

		
		    if(webdavResource.proppatchMethod(webdavResource.getPath(), new PropertyName(prefix,name), value) )
		    {
			  log.debug("setProperty(): PROPPATCH Succeeded");
			  return true;
		    }
		    else 
		    {
			  throw new RepositoryException("PROPPATCH failed. Reason: "+webdavResource.getStatusMessage());
		    }
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
	
	public boolean put(String path, String name, String contentType, String content) throws RepositoryException
	{
		try 
		{
			WebdavResource webdavResource = findResource( "/" );
			if(contentType != null) 
			{
				webdavResource.setContentType(contentType);
			}
			String fullPath = ( path.startsWith( PATH_PREFIX ) ? path+"/"+name : PATH_PREFIX + "/" + path+"/"+name );
			String normalizedPath = normalize( fullPath );
			log.trace("findResource():   normalized path "+normalizedPath);
			if (webdavResource.putMethod(normalizedPath, content))
			{
			  log.debug("put(): PUT Succeeded");
			  return true;
			} 
			else
			{
			  throw new RepositoryException("PUT failed. Reason: "+webdavResource.getStatusMessage());
			}
		}
		catch (HttpException e)
		{
		  throw new RepositoryException("HTTP Exception during file creation",e);
		} // end of try-catch
		catch (IOException e)
		{
		  throw new RepositoryException("I/O Exception during file creation",e);
		} // end of try-catch

	}
	
	public void killLocks(String path) throws RepositoryException
	{
		try
		{
			WebdavResource resource = findResource(path);
			resource.unlockMethod();
		}
		catch (HttpException e)
		{
		  throw new RepositoryException("HTTP Exception during file creation",e);
		} // end of try-catch
		catch (IOException e)
		{
		  throw new RepositoryException("I/O Exception during file creation",e);
		} // end of try-catch
	}

	public WebdavResource checkout(String path) throws RepositoryException
	{
		try
		{
			WebdavResource resource = findResource(path);
			boolean result = resource.lockMethod();
			if(result)
			{
				return resource;
			}
			else
			{
				throw new RepositoryException("Error trying to checkout "+path+". Reason: "+resource.getStatusMessage());
			}
		}
		catch (HttpException e)
		{
		  throw new RepositoryException("HTTP Exception during file creation",e);
		} // end of try-catch
		catch (IOException e)
		{
		  throw new RepositoryException("I/O Exception during file creation",e);
		} // end of try-catch
	}

	public void checkin(String path) throws RepositoryException
	{
		try
		{
			WebdavResource resource = findResource(path);
			boolean result = resource.checkinMethod();
			if(!result)
			{
				throw new RepositoryException("Error trying to checkin "+path+". Reason: "+resource.getStatusMessage());
			}
		}
		catch (HttpException e)
		{
		  throw new RepositoryException("HTTP Exception during file creation",e);
		} // end of try-catch
		catch (IOException e)
		{
		  throw new RepositoryException("I/O Exception during file creation",e);
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
