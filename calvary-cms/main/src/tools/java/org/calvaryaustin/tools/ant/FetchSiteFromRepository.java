package org.calvaryaustin.tools.ant;

import java.io.File;
import java.io.IOException;
import org.apache.commons.io.FileUtils;
import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Task;
import org.calvaryaustin.cms.Repository;
import org.calvaryaustin.cms.RepositoryException;

public class FetchSiteFromRepository extends Task
{
  public FetchSiteFromRepository() throws Exception
  {
  }

  public void setWebdavURL(String newWebdavURL)
  {
    this.webdavURL = newWebdavURL;
  }

  public void setSiteName(String newSiteName)
  {
    this.siteName = newSiteName;
  }

  public void setToDir(String newToDir)
  {
    this.toDir = newToDir;
  }
  
  /**
   * The <code>execute</code> method is called by ant to execute the task.
   *
   * @exception BuildException if an error occurs
   */
  public void execute() throws BuildException
  {
    log("Inside FetchSiteFromRepository execute()");
    try 
    {
      Repository repository = new Repository( webdavURL );
      File toDirFile = new File( toDir );
      toDirFile.mkdirs();
      FileUtils.cleanDirectory( toDirFile );
      repository.findSite( siteName ).exportSite( toDirFile );
    }
    catch (RepositoryException e)
    {
      throw new BuildException("Error during repository calls",e);
    } // end of try-catch
    catch (IOException e)
    {
      throw new BuildException("Error during local I/O",e);
    } // end of try-catch
    
    log("Completed FetchSiteFromRepository execute()");
  }

  private String webdavURL;
  private String siteName;
  private String toDir;
}// 
