package org.calvaryaustin.cms;

import java.util.List;
import java.util.Date;

/**
 * A page 
 * @author jhigginbotham
 */
public interface PageVersion
{
	public String getVersionNumber();
	
	public String getLastModifiedBy();
	
	public Date getLastModifiedDate();
	
	public String getBranchName();
	
	
	/**
	 * @return
	 */
	// ?? replace with specific fields?
	public List getAllProperties();

	public String getContentType();
	public void setContentType(String contentType);

	public String getContent();
	public void setContent(String content);
	
}
