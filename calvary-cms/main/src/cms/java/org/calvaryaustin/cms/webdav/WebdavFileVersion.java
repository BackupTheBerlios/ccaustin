package org.calvaryaustin.cms.webdav;

import java.util.Date;
import java.util.List;

import org.calvaryaustin.cms.FileVersion;

/**
 * 
 * @author jhigginbotham
 */
public class WebdavFileVersion implements FileVersion
{
	public WebdavFileVersion(WebdavConnection connection, String site, String path,
							 String description, String versionNumber, 
							 String lastModifiedBy, Date lastModifiedDate, 
							 String branchName, String contentType, String content)
    {
		this.connection = connection;
		this.site = site;
		this.path = path;

		this.description = description;
		this.versionNumber = versionNumber; 
	    this.lastModifiedBy = lastModifiedBy;
	    this.lastModifiedDate = lastModifiedDate; 
		this.branchName = branchName;
		this.contentType = contentType;
		this.content = content;
    }
    
	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;

	}

	public String getVersionNumber()
	{
		return versionNumber;
	}

	public String getLastModifiedBy()
	{
		return lastModifiedBy;
	}

	public Date getLastModifiedDate()
	{
		return lastModifiedDate;
	}

	public String getBranchName()
	{
		return branchName;
	}

	public List getAllProperties()
	{
		// TODO Auto-generated method stub
		return null;
	}

	public String getContentType()
	{
		return contentType;
	}

	public void setContentType(String contentType)
	{
		this.contentType = contentType;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;

	}

	private String site;
	private String path;
	private WebdavConnection connection;
	private String description;
	private String versionNumber;
	private String lastModifiedBy;
	private Date lastModifiedDate;
	private String branchName;
	private String contentType;
	private String content;
}
