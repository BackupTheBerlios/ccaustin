package org.calvaryaustin.cms.webdav; // Generated package name

import java.io.File;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.calvaryaustin.cms.RepositoryException;

/**
 * Repository.java
 *
 *
 * Created: Mon Jan 13 21:16:30 2003
 *
 * @author <a href="mailto:jhigginbotham@betweenmarkets.com">James Higginbotham</a>
 * @version $Revision: 1.1 $
 */
public class Repository 
{
  public Repository(String serverUrl) throws RepositoryException
  {
    dao = new WebdavRepositoryDAO(serverUrl);
    this.serverUrl = serverUrl;
    init();
  }

  public Site createSite( String siteName ) throws RepositoryException
  {
    return dao.createSite( siteName );
  }

  public Site findSite( String siteName ) throws RepositoryException
  {
    return dao.findSite( siteName );
  }

  
  /**
   * Get the ServerUrl value.
   * @return the ServerUrl value.
   */
  public String getServerUrl()
  {
    return serverUrl;
  }

  protected WebdavRepositoryDAO getDAO()
  {
    return dao;
  }

  private void init() throws RepositoryException
  {
    // make sure that the root level for all sites exists.. if not, we will create it to init the
    // repository
    dao.initRepository();
  }
  
  private WebdavRepositoryDAO dao;
  private String serverUrl;
  private static final Log log = LogFactory.getLog( Repository.class );
}// Repository

