package org.calvaryaustin.cms;

import java.io.File;
import java.io.FileWriter;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import org.apache.commons.io.FileUtils;

/**
 *  Unit Test for class Repository
 *
 *
 * Created: Fri Jan 17 20:30:31 2003
 *
 * @author <a href="mailto:jhigginbotham@betweenmarkets.com">James Higginbotham</a>
 * @version $Revision: 1.1 $
 */
public class RepositoryTest extends TestCase 
{

  /** 
   * Creates a new <code>RepositoryTest</code> instance.
   *
   * @param name test name
   */
  public RepositoryTest (String name)
  {
    super(name);
  }

/**
 * @return a <code>TestSuite</code>
  public static TestSuite suite()
  {
    TestSuite suite = new TestSuite ();
    
    return suite;
  }
 */

/** 
 * Entry point 
  public static void main(String[] args) 
  {
    junit.textui.TestRunner.run(suite());
  }
 */

  public void testInitRepository() throws Exception
  {
    // let's make sure our root dir exists and that the repository inits properly
    Repository repository = new Repository( REPOSITORY_URL );
    // init it again and make sure we don't fail on the reinit
    repository = new Repository( REPOSITORY_URL );
  }

  public void testCreateSite() throws Exception
  {
    Repository repository = new Repository( REPOSITORY_URL );
    repository.createSite( TEST_SITE );
    Site site = repository.findSite( TEST_SITE );
    assertNotNull( site );
    assertEquals( TEST_SITE, site.getName() );
  }

/*  
  public void DISABLEDtestImportDirectory() throws Exception
  {
    Repository repository = new Repository(REPOSITORY_URL);
    File tempDir = new File("build/_siteimporttemp");
    tempDir.mkdirs();
    FileUtils.cleanDirectory( tempDir );
    writeFile( tempDir, "unittest1.txt", "This is a test of the import method" );
    File subDir = new File( tempDir, "_a_sub_dir" );
    subDir.mkdir();
    writeFile( subDir, "unittest2.txt", "This is another test of the import method" );
    repository.importDirectory( "testsite", "recursive", tempDir, true );
    repository.importDirectory( "testsite", "nonrecursive", tempDir, true );
  }
*/
/*  
  public void DISABLEDtestImportFile() throws Exception
  {
    Repository repository = new Repository(REPOSITORY_URL);
    File tempDir = new File("build/_siteimporttemp");
    tempDir.mkdirs();
    FileUtils.cleanDirectory( tempDir );
    writeFile( tempDir, "unittest1.txt", "This is a test of the import method" );
    repository.importFile( "testsite", "", new File(tempDir,"unittest1.txt") );
  }
*/  

/*
  public void DISABLEDtestExportSite() throws Exception
  {
    Repository repository = new Repository(REPOSITORY_URL);
    File tempDir = new File("build/_siteexporttemp");
    FileUtils.cleanDirectory( tempDir );
    repository.exportSite( "testsite", tempDir );
  }
*/
  
  private void writeFile( File baseDir, String filename, String contents ) throws Exception
  {
    File file = new File( baseDir.getCanonicalPath()+"/"+filename );
    System.out.println("writing to: "+file.getAbsolutePath());
    FileWriter writer = new FileWriter( file );
    writer.write( contents );
    writer.flush();
    writer.close();
  }

  private static final String REPOSITORY_URL = "http://localhost:8080/slide";
  private static final String TEST_SITE = "testsite";
}// RepositoryTest
