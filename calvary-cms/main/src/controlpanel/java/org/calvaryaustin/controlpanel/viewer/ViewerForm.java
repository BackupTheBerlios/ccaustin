package org.calvaryaustin.controlpanel.viewer;

import org.calvaryaustin.web.BaseValidatorForm;

/**
 * A FormBean used by the ViewerAction to store the user parameters passed in. The 
 * ViewerAction
 * @author jhigginbotham
 */
public class ViewerForm extends BaseValidatorForm
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
     * Returns the revision to view, if the user wishes to view a specific 
     * branch and revision
     * @return the revision to view, if the user wishes to view a specific 
     * branch and revision
     */
    public String getRev()
    {
        return rev;
    }

    /**
     * Sets the rev.
     * @param rev The rev to set
     */
    public void setRev(String rev)
    {
        this.rev = rev;
    }

    /**
     * Returns the branch to view, if the user wishes to view a specific 
     * branch and revision
     * @return the branch to view, if the user wishes to view a specific 
     * branch and revision
     */
    public String getBranch()
    {
        return branch;
    }

    /**
     * Sets the branch.
     * @param branch The branch to set
     */
    public void setBranch(String branch)
    {
        this.branch = branch;
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
	private String rev;
	private String branch;
	private String computedUri;
}
