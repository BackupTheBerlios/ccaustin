package org.calvaryaustin.cms.webdav;

import java.io.File;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.calvaryaustin.cms.RepositoryException;

/**
 * Site.java
 *
 *
 * Created: Tue Jan 28 17:04:06 2003
 *
 * @author <a href="mailto:jhigginbotham@betweenmarkets.com">James Higginbotham</a>
 * @version $Revision: 1.1 $
 */
public class Site 
{
  public String getName()
  {
    return siteName;
  }
  
  public void exportSite( File baseDir ) throws RepositoryException
  {
    log.debug("Exporting site with name "+siteName+" to "+baseDir);
    dao.exportSite( siteName, baseDir );
    log.debug("Export complete for site "+siteName);
  }

  public void importFile( String destPath, File fileToImport )
      throws RepositoryException
  {
    log.debug("Importing file "+fileToImport+" into site "+siteName);
    dao.importFile( siteName, destPath, fileToImport );
    log.debug("Import complete for file "+fileToImport);
  }

  public void importDirectory( String destPath, File dirToImport, boolean recurse )
      throws RepositoryException
  {
    log.debug("Importing directory "+dirToImport+" into site "+siteName);
    dao.importDirectory( siteName, destPath, dirToImport, recurse );
    log.debug("Import complete for directory "+dirToImport);
  }

  protected Site( String siteName, WebdavRepositoryDAO dao )
  {
    this.dao = dao;
    this.siteName = siteName;
  }
  
  private String siteName;
  private Repository repository;
  private WebdavRepositoryDAO dao;
  private static final Log log = LogFactory.getLog( Site.class );
}// Site
