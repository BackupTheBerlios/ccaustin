package org.calvaryaustin.cms;

import java.util.List;
import java.util.Date;

/**
 * A specific version of a File managed by the Repository
 * @author jhigginbotham
 */
public interface FileVersion
{
	/**
	 * Returns the description for the file
	 * @return the description for the file
	 */
	public String getDescription();	
	/**
	 * Sets the new description
	 * @param description the new description
	 */
	public void setDescription(String description);	
	/**
	 * Returns the version number for this version
	 * @return the version number for this version
	 */
	public String getVersionNumber();
	
	/**
	 * Returns a String representation of the last modified date
	 * @return a String representation of the last modified date
	 */
	public String getLastModifiedBy();
	
	/**
	 * Returns a Date representation of the last modified date
	 * @return a Date representation of the last modified date
	 */
	public Date getLastModifiedDate();
	
	/**
	 * Returns the branch name for this version
	 * @return the branch name for this version
	 */
	public String getBranchName();
	
	/**
	 * Returns all associated name/value properties for this version
	 * @return all associated name/value properties for this version 
	 */
	// ?? replace with specific fields?
	public List getAllProperties();

	/**
	 * Returns the content type for this file
	 * @return
	 */
	public String getContentType();
	
	/**
	 * Sets the content type for this file (for checkins)
	 * @param contentType the content type for this file
	 */
	public void setContentType(String contentType);

	/**
	 * Returns the content for this file - may be a binary format
	 * @return the content for this file - may be a binary format
	 */
	public byte[] getContent();
	
	/**
	 * Sets the content for this file (for checkins) 
	 * @param content the content for this file 
	 */
	public void setContent(byte[] content);
}
