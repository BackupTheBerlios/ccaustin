package org.calvaryaustin.cms;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.io.IOUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.util.HttpURL;
import org.apache.webdav.lib.WebdavResource;

/**
 * WebdavRepositoryDAO.java
 *
 *
 * Created: Mon Jan 13 21:16:30 2003
 *
 * @author <a href="mailto:jhigginbotham@betweenmarkets.com">James Higginbotham</a>
 * @version $Revision: 1.1 $
 */
public class WebdavRepositoryDAO
{
  public WebdavRepositoryDAO(String url)
  {
    httpURL = new HttpURL(url);
    log.debug("Initialized for url "+url);
  }

  
  /**
   * Describe <code>getDebugLevel</code> method here.
   *
   * @return an <code>int</code> value
   */
  public int getDebugLevel()
  {
    return debugLevel;
  }

  /**
   * Describe <code>setDebugLevel</code> method here.
   *
   * @param newDebugLevel an <code>int</code> value
   */
  public void setDebugLevel(int newDebugLevel)
  {
    this.debugLevel = newDebugLevel;
  }

  
  public void initRepository() throws RepositoryException
  {
    WebdavResource resource = findResource( PATH_SITES ); 
    if ( !resource.exists() )
    {
      // make the sites collection so we can create sites
      makeCollection( ROOT, SITES_COLLECTION_NAME );
    } // end of if ()
    
  }

  public Site createSite( String siteName ) throws RepositoryException
  {
    WebdavResource resource = findResource( PATH_SITES +"/"+ siteName );
    if ( resource.exists() )
    {
      throw new SiteAlreadyExistsException("Site "+siteName+" already exists");
    } // end of if ()
      
    resource = makeCollection( PATH_SITES, siteName );
    Site site = new Site( siteName, this );
    return site; 
  }

  public Site findSite( String siteName ) throws RepositoryException
  {
    WebdavResource webdavResource = findResource( PATH_SITES + "/" + siteName ); 
    if ( webdavResource.exists() )
    {
      log.trace("findSite(): Site found: "+siteName);
      Site site = new Site( siteName, this );
      return site;
    } // end of if ()
    else
    {
      throw new SiteNotFoundException("Site "+siteName+" does not exist");
    } // end of else
      
  }
  
  
  /**
   * Describe <code>exportSite</code> method here.
   *
   * @param siteName a <code>String</code> value
   * @param baseDir a <code>File</code> value
   * @exception RepositoryException if an error occurs
   */
  public void exportSite( String siteName, File baseDir ) throws RepositoryException
  {
    try 
    {
      WebdavResource webdavResource = new WebdavResource(httpURL);
      webdavResource.setDebug( debugLevel );
      webdavResource.setPath(PATH_PREFIX+siteName+"/");
      if ( webdavResource.exists() )
      {
        crawlAndSave( webdavResource, baseDir );
      } // end of if ()
      else
      {
        throw new RepositoryException("Site not found: "+siteName);
      } // end of else
      
    }
    catch (HttpException e)
    {
      throw new RepositoryException("Error while crawling site",e);
    } // end of try-catch
    catch (IOException e)
    {
      throw new RepositoryException("Error while performing I/O for export",e);
    } // end of try-catch
  }

  /**
   * Describe <code>importFile</code> method here.
   *
   * @param siteName a <code>String</code> value
   * @param destPath a <code>String</code> value
   * @param fileToImport a <code>File</code> value
   * @exception RepositoryException if an error occurs
   */
  public void importFile( String siteName, String destPath, File fileToImport )
      throws RepositoryException
  {
    try 
    {
      WebdavResource webdavResource = new WebdavResource(httpURL);
      webdavResource.setDebug( debugLevel );
      // TODO: Fix this to ensure prefix is not duplicated, /'s are not duplicated or missing, etc
      webdavResource.setPath(PATH_PREFIX+siteName+"/");
      String fullDestPath = PATH_PREFIX+siteName+"/"+destPath+fileToImport.getName();
//       log.trace("importFile():   siteName="+siteName);
//       log.trace("importFile():   destPath="+destPath);
//       log.trace("importFile():   fileToImport="+fileToImport);
//       log.trace("importFile():   fullDestPath="+fullDestPath);
      if (webdavResource.putMethod(fullDestPath, fileToImport))
      {
        log.trace("importFile(): Succeeded");
      } 
      else
      {
        //log.debug("importFile(): Failed. Reason: "+webdavResource.getStatusMessage());
        throw new RepositoryException("Import failed. Reason: "+webdavResource.getStatusMessage());
      }
    }
    catch (HttpException e)
    {
      throw new RepositoryException("Error while importing",e);
    } // end of try-catch
    catch (IOException e)
    {
      throw new RepositoryException("Error while performing I/O for import",e);
    } // end of try-catch
  }


  /**
   * Describe <code>importDirectory</code> method here.
   *
   * @param siteName a <code>String</code> value
   * @param destPath a <code>String</code> value
   * @param dirToImport a <code>File</code> value
   * @param recurse a <code>boolean</code> value
   * @exception RepositoryException if an error occurs
   */
  public void importDirectory( String siteName, String destPath, File dirToImport, boolean recurse )
      throws RepositoryException
  {
    log.trace("importDirectory(): Entering "+dirToImport);
    File[] files = dirToImport.listFiles();
    if ( files.length > 0 )
    {
      String path = PATH_PREFIX+siteName;
      log.trace("importDirectory():   path="+path);
      makeCollection( path, destPath );
      path += destPath + "/";
      log.trace("importDirectory():   path="+path);
      makeCollection( path, dirToImport.getName() );
    } // end of if ()
    
    for (int i=0;i<files.length;i++)
    {
      if ( files[i].isDirectory() )
      {
        log.trace("importDirectory():   found directory "+files[i]);
        if ( recurse )
        {
          String newPath = destPath + "/" + files[i].getName();
          log.trace("importDirectory():   new path="+newPath);
          importDirectory( siteName, newPath, files[i], recurse );
        } // end of if ()
        else
        {
          log.trace("importDirectory():   skipping - recursing off");
        } // end of else
        
      } // end of if ()
      else
      {
        log.trace("importDirectory():   found file "+files[i]);
        importFile( siteName, destPath, files[i] );
      } // end of else
      
    } // end of for ()
    log.trace("importDirectory(): Exiting "+dirToImport);
  }

  //
  // -- Helper methods
  //
  
  private void crawlAndSave( WebdavResource webdavResource, File baseDir )
      throws HttpException, IOException
  {
    log.trace("crawlAndSave(): Entering "+webdavResource.getHttpURL());
    //log.trace("crawlAndSave():   name= "+webdavResource.getDisplayName());
    File targetDir = new File( baseDir, webdavResource.getPath().substring(PATH_PREFIX.length()) );
    targetDir.mkdirs();
    WebdavResource resources[] = webdavResource.getChildResources().listResources();
    for (int i=0;i<resources.length;i++)
    {
      if ( resources[i].getChildResources() == null ||
           resources[i].getChildResources().isEmpty() )
      {
        save( resources[i], baseDir );
      } // end of if ()
      else
      {
        log.trace("crawlAndSave():   collection found");
        crawlAndSave( resources[i], baseDir );
      } // end of else
      
      
    } // end of for ()
    log.trace("crawlAndSave(): Exiting "+webdavResource.getPath());
  }

  private void save( WebdavResource webdavResource, File baseDir ) throws HttpException, IOException
  {
    log.trace("save():  saving document "+webdavResource.getDisplayName());
    File targetFile = new File( baseDir, webdavResource.getPath().substring(PATH_PREFIX.length()) );
    log.trace("save(): can write? "+targetFile.canWrite());
    targetFile.createNewFile();
    // save contents from the stream
    // NOTE: We use streams rather than writers, as Writers are UTF-8 and sometimes add extra bytes
    // to an image, thereby invalidating it. Streams are as-is
    IOUtil.copy( webdavResource.getMethodData(), new FileOutputStream(targetFile) );
    log.trace("save():  document saved");
  }

  private WebdavResource makeCollection( String path, String collectionName  ) throws RepositoryException
  {
    try 
    {
      log.trace("makeCollection(): Making collection with name "+collectionName);
      WebdavResource webdavResource = findResource( path + "/" + collectionName);
      if ( webdavResource.exists() )
      {
        log.trace("makeCollection(): resource exists already");
        return webdavResource;
      } // end of if ()

      if (webdavResource.mkcolMethod() )
      {
        log.trace("makeCollection(): Directory created");
        return webdavResource;
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

  private WebdavResource findResource( String path ) throws RepositoryException
  {
    try 
    {
      log.trace("findResource(): Finding resource "+path);
      String fullPath = ( path.startsWith( PATH_PREFIX ) ? path : PATH_PREFIX + "/" + path );
      String normalizedPath = RepositoryUtil.normalize( fullPath );
      log.trace("findResource():   normalized path "+normalizedPath);
      WebdavResource webdavResource = new WebdavResource(httpURL);
      webdavResource.setDebug( debugLevel );
      webdavResource.setPath( normalizedPath );
      return webdavResource;
    }
    catch (HttpException e)
    {
      throw new RepositoryException("Error while locating path "+path,e);
    } // end of try-catch
    catch (IOException e)
    {
      throw new RepositoryException("Error while performing I/O during path location for "+path,e);
    } // end of try-catch
  }
  
  private HttpURL httpURL;
  private int debugLevel = 0;
  private static final String ROOT = "";
  private static final String PATH_PREFIX = "/slide/files/"; // move to config?
  private static final String SITES_COLLECTION_NAME = "sites";
  private static final String PATH_SITES = "/"+SITES_COLLECTION_NAME+"/";
  private static final Log log = LogFactory.getLog( WebdavRepositoryDAO.class );
}// WebdavRepositoryDAO
