package org.calvaryaustin.cms;

import java.io.File;
import java.io.FileWriter;
import java.util.Iterator;
import java.util.List;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;
import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *  Unit Test for class Repository
 *
 *
 * Created: Fri Jan 17 20:30:31 2003
 *
 * @author <a href="mailto:jhigginbotham@betweenmarkets.com">James Higginbotham</a>
 * @version $Revision: 1.6 $
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
	suite.addTest(new RepositoryTest("testInitRepository"));
	suite.addTest(new RepositoryTest("testCreateSite"));
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
  	log.info(">>>>>>>>>>>>> testInitRepository(): begin");
    // let's make sure our root dir exists and that the repository inits properly
	repository = RepositoryFactory.getRepository( HOST, PORT, PATH, USERNAME, PASSWORD );
	List results = repository.getSiteList();
	Iterator iterator = results.iterator();
	while(iterator.hasNext())
	{
		Site site = (Site)iterator.next();
		site.delete();
	}
	log.info("<<<<<<<<<<<<< testInitRepository(): end");
  }

  public void testCreateSite() throws Exception
  {
	log.info(">>>>>>>>>>>>> testCreateSite(): begin");
	assertNotNull(repository);
	repository.createSite( TEST_SITE, TEST_SITE_DESCRIPTION );
	Site site = repository.getSite( new SiteHandle(TEST_SITE) );
	assertNotNull( site );
	assertEquals( TEST_SITE, site.getName() );
	assertEquals( TEST_SITE_DESCRIPTION, site.getDescription() );
	log.info("<<<<<<<<<<<<< testCreateSite(): end");
  }

  public void testListSites() throws Exception
  {
	log.info(">>>>>>>>>>>>> testListSites(): begin");
  	assertNotNull(repository);
    repository.createSite( TEST_SITE2, TEST_SITE2_DESCRIPTION );
    List results = repository.getSiteList();
    assertNotNull( results );
    assertEquals( 2, results.size() );
	log.info("<<<<<<<<<<<<< testListSites(): end");
  }

  public void testDeleteSites() throws Exception
  {
	log.info(">>>>>>>>>>>>> testDeleteSites(): begin");
	assertNotNull(repository);
	List results = repository.getSiteList();
	assertNotNull( results );
	Iterator iterator = results.iterator();
	while(iterator.hasNext())
	{
		Site site = (Site)iterator.next();
		site.delete();
	}
	results = repository.getSiteList();
	assertNotNull( results );
	assertEquals(0, results.size());
	log.info("<<<<<<<<<<<<< testDeleteSites(): end");
  }
  
  public void testFolderLifecycle() throws Exception
  {
	log.info(">>>>>>>>>>>>> testCreateFolder(): begin");
	assertNotNull(repository);
	repository.createSite( TEST_SITE, TEST_SITE_DESCRIPTION );
	Site site = repository.getSite( new SiteHandle(TEST_SITE) );
	Folder rootFolder = site.getRootFolder();
	assertNotNull( rootFolder  );
	assertEquals( "/", rootFolder.getName() );
	assertEquals( "/", rootFolder.getPath() );
	FolderHandle handle = rootFolder.createFolder(TEST_FOLDER, TEST_FOLDER_DESCRIPTION);
	assertNotNull( handle );
	assertEquals("/"+TEST_FOLDER, handle.getPath());
	Folder foundFolder = site.getFolder( handle );
	assertNotNull(foundFolder);
	assertEquals( TEST_FOLDER, foundFolder.getName() );
	assertEquals( "/"+TEST_FOLDER, foundFolder.getPath() );
	assertEquals( TEST_FOLDER_DESCRIPTION, foundFolder.getDescription() );
	foundFolder.delete();
	try 
	{
		site.getFolder( handle );
		fail("Folder was deleted but was returned by a query.");
	} catch( FolderNotFoundException e)
	{
		// expected
	}
	site.delete();
	log.info("<<<<<<<<<<<<< testCreateFolder(): end");
  }
  
  public void testFileLifecycle() throws Exception
  {
	log.info(">>>>>>>>>>>>> testCreateFile(): begin");
	assertNotNull(repository);
	repository.createSite( TEST_SITE, TEST_SITE_DESCRIPTION );
	Site site = repository.getSite( new SiteHandle(TEST_SITE) );
	Folder rootFolder = site.getRootFolder();
	FolderHandle handle = rootFolder.createFolder(TEST_FOLDER, TEST_FOLDER_DESCRIPTION);
	Folder foundFolder = site.getFolder( handle );
	FileHandle fileHandle = foundFolder.createFile(TEST_FILE, TEST_FILE_DESCRIPTION, TEST_FILE_TYPE, TEST_FILE_CONTENT);
	org.calvaryaustin.cms.File foundFile = foundFolder.getFile(fileHandle);
	assertNotNull(foundFile);
	assertEquals(TEST_FILE, foundFile.getName());
	assertEquals("/"+TEST_FOLDER+"/"+TEST_FILE, foundFile.getPath());
	FileVersion latestVersion = foundFile.getLatestVersion();
	assertNotNull(latestVersion);
	assertEquals(TEST_FILE_DESCRIPTION, latestVersion.getDescription());
	assertEquals(TEST_FILE_TYPE, latestVersion.getContentType());
	assertEquals(TEST_FILE_CONTENT, latestVersion.getContent());
	foundFile.delete();		
	try 
	{
		foundFolder.getFile(fileHandle);
		fail("File was deleted but was returned by a query.");
	} catch( FileNotFoundException e)
	{
		// expected
	}
	site.delete();
	log.info("<<<<<<<<<<<<< testCreateFile(): end");
  }
  
  public void testFolderBrowsing() throws Exception
  {
	log.info(">>>>>>>>>>>>> testFolderBrowsing(): begin");
	assertNotNull(repository);
	repository.createSite( TEST_SITE, TEST_SITE_DESCRIPTION );
	Site site = repository.getSite( new SiteHandle(TEST_SITE) );
	Folder rootFolder = site.getRootFolder();
	FolderHandle handle = rootFolder.createFolder(TEST_FOLDER, TEST_FOLDER_DESCRIPTION);
	Folder foundFolder = site.getFolder( handle );
	FolderHandle handle2 = foundFolder.createFolder(TEST_FOLDER2, TEST_FOLDER2_DESCRIPTION);
	FileHandle fileHandle = foundFolder.createFile(TEST_FILE, TEST_FILE_DESCRIPTION, TEST_FILE_TYPE, TEST_FILE_CONTENT);
	org.calvaryaustin.cms.File foundFile = foundFolder.getFile(fileHandle);
	List results = rootFolder.browse();
	assertNotNull(results);
	assertEquals(1,results.size());
	assertTrue( results.get(0) instanceof Folder);
	results = foundFolder.browse();
	assertNotNull(results);
	assertEquals(2,results.size());
	boolean folderFound = false;
	boolean fileFound = false;
	for(int i=0;i<results.size();i++)
	{
		Object current = results.get(i);
		if(current instanceof Folder)
		{
			Folder theFolder = (Folder)current;
			assertEquals(TEST_FOLDER2, theFolder.getName());
			assertEquals( "/"+TEST_FOLDER+"/"+TEST_FOLDER2, theFolder.getPath() );
			assertEquals( TEST_FOLDER2_DESCRIPTION, theFolder.getDescription() );
			folderFound = true;
		}
		else 
		{
			org.calvaryaustin.cms.File theFile = (org.calvaryaustin.cms.File)current;
			assertEquals(TEST_FILE, theFile.getName());
			assertEquals("/"+TEST_FOLDER+"/"+TEST_FILE, theFile.getPath());
			FileVersion latestVersion = theFile.getLatestVersion();
			assertNotNull(latestVersion);
			assertEquals(TEST_FILE_DESCRIPTION, latestVersion.getDescription());
			assertEquals(TEST_FILE_TYPE, latestVersion.getContentType());
			assertEquals(TEST_FILE_CONTENT, latestVersion.getContent());
			fileFound = true;
		}
	}
	assertTrue(folderFound);
	assertTrue(fileFound);
	site.delete();
	log.info("<<<<<<<<<<<<< testFolderBrowsing(): end");
  }
  
  public void testLocking() throws Exception
  {
	log.info(">>>>>>>>>>>>> testLocking(): begin");
	assertNotNull(repository);
	repository.createSite( TEST_SITE, TEST_SITE_DESCRIPTION );
	Site site = repository.getSite( new SiteHandle(TEST_SITE) );
	Folder rootFolder = site.getRootFolder();
	FolderHandle handle = rootFolder.createFolder(TEST_FOLDER, TEST_FOLDER_DESCRIPTION);
	Folder foundFolder = site.getFolder( handle );
	FileHandle fileHandle = foundFolder.createFile(TEST_FILE, TEST_FILE_DESCRIPTION, TEST_FILE_TYPE, TEST_FILE_CONTENT);
	org.calvaryaustin.cms.File foundFile = foundFolder.getFile(fileHandle);
	assertTrue(!foundFile.isCheckedOut());
	FileVersion checkedOut = foundFile.checkout();
	assertTrue(foundFile.isCheckedOut());
	List locks = foundFile.getLocks();
	assertNotNull(locks);
	assertEquals(1,locks.size());
	foundFile.killLocks();
	assertTrue(!foundFile.isCheckedOut());
	locks = foundFile.getLocks();
	assertNotNull(locks);
	assertEquals(0,locks.size());
	site.delete();
	log.info("<<<<<<<<<<<<< testLocking(): end");
  }
  
  public void testVersioning() throws Exception
  {
	log.info(">>>>>>>>>>>>> testVersioning(): begin");
	assertNotNull(repository);
	repository.createSite( TEST_SITE, TEST_SITE_DESCRIPTION );
	Site site = repository.getSite( new SiteHandle(TEST_SITE) );
	Folder rootFolder = site.getRootFolder();
	FolderHandle handle = rootFolder.createFolder(TEST_FOLDER, TEST_FOLDER_DESCRIPTION);
	Folder foundFolder = site.getFolder( handle );
	FileHandle fileHandle = foundFolder.createFile(TEST_FILE, TEST_FILE_DESCRIPTION, TEST_FILE_TYPE, TEST_FILE_CONTENT);
	org.calvaryaustin.cms.File foundFile = foundFolder.getFile(fileHandle);
	FileVersion originalVersion = foundFile.getLatestVersion();
	assertTrue(!foundFile.isCheckedOut());
	FileVersion checkedOut = foundFile.checkout();
	assertTrue(foundFile.isCheckedOut());
	checkedOut.setContent("changed".getBytes());
	foundFile.checkin(checkedOut);
	assertTrue(!foundFile.isCheckedOut());
	FileVersion updatedVersion = foundFile.getLatestVersion();
	assertEquals("changed",new String(updatedVersion.getContent()));
	assertEquals(originalVersion.getContentType(),updatedVersion.getContentType());
	assertEquals(originalVersion.getDescription(),updatedVersion.getDescription());
	assertEquals(originalVersion.getBranchName(),updatedVersion.getBranchName());
	assertEquals(originalVersion.getLastModifiedBy(),updatedVersion.getLastModifiedBy());
	assertNotNull(updatedVersion.getLastModifiedDate());
	site.delete();
	log.info("<<<<<<<<<<<<< testVersioning(): end");
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

  private static Repository repository;
  private static final String HOST = "localhost";
  private static final int PORT = 8080;
  private static final String PATH = "/slide";
  private static final String USERNAME = "root";
  private static final String PASSWORD = "root";
  private static final String TEST_SITE = "testsite";
  private static final String TEST_SITE_DESCRIPTION = "A test site";
  private static final String TEST_SITE2 = "testsite-2";
  private static final String TEST_SITE2_DESCRIPTION = "Another test site";
  private static final String TEST_FOLDER = "testfolder";
  private static final String TEST_FOLDER_DESCRIPTION = "A test folder";
  private static final String TEST_FOLDER2 = "testfolder-2";
  private static final String TEST_FOLDER2_DESCRIPTION = "Another test folder";
  private static final String TEST_FILE = "testfile";
  private static final String TEST_FILE_DESCRIPTION = "A test file";
  private static final String TEST_FILE_TYPE = "text/plain";
  private static final byte[] TEST_FILE_CONTENT = "This is an example of a test file that is plain text.".getBytes();
  private static final Log log = LogFactory.getLog( RepositoryTest.class );
}// RepositoryTest
