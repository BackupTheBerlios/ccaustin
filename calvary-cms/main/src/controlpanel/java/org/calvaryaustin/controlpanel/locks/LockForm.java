package org.calvaryaustin.controlpanel.locks;

import org.calvaryaustin.web.BaseValidatorForm;

/**
 * @author jhigginbotham
 */
public class LockForm extends BaseValidatorForm
{
    /**
     * Returns the path that is currently being browsed
     * @return the path that is currently being browsed
     */
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

    /**
     * Returns the site that is currently being browsed
     * @return the site that is currently being browsed
     */
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
	
    /**
     * Returns the filename to view
     * @return the filename to view
     */
    public String getFile()
    {
        return file;
    }
	
    /**
     * Sets the filename to view
     * @param file the filename to view
     */
    public void setFile(String file)
    {
        this.file = file;
    }
	
    /**
     * Returns the computed URI that is computed by the action
     * @return the computed URI that is computed by the action
     */
    public String getComputedUri()
    {
        return computedUri;
    }
	
    /**
     * Sets the computed URI that is computed by the action
     * @param computedUri the computed URI that is computed by the action
     */
    public void setComputedUri(String computedUri)
    {
        this.computedUri = computedUri;
    }

    private String site;
    private String path;
    private String file;
    private String computedUri;
}