package org.calvaryaustin.controlpanel.browser;

import org.calvaryaustin.controlpanel.ResourceCollectionForm;
import org.calvaryaustin.controlpanel.ResourceForm;
import org.calvaryaustin.web.BaseValidatorForm;

/**
 * Represents the fields necessary to browse a site
 * @author jhigginbotham
 */
public class BrowserForm extends BaseValidatorForm implements ResourceCollectionForm
{
    public boolean isCollection()
    {
        return true;
    } 
    
    public String getName()
    {
        if( path == null )
        {
            return null;
        }
        
        return path.substring(0,path.lastIndexOf("/"));
    }

	public String getPath()
	{
		return path;
	}

	/**
	 * Sets the path.
	 * @param path The path to set
	 */
	public void setPath(String path)
	{
		this.path = path;
	}

	public String getSite()
	{
		return site;
	}

	/**
	 * Sets the site.
	 * @param site The site to set
	 */
	public void setSite(String site)
	{
		this.site = site;
	}

	public String getComputedUri()
	{
		return computedUri;
	}
	
	public void setComputedUri(String computedUri)
	{
		this.computedUri = computedUri;
	}

	private String site;
	private String path;
	private String computedUri;
}
