package org.calvaryaustin.controlpanel.viewer;

import java.util.HashMap;
import java.util.Map;

import org.calvaryaustin.controlpanel.ResourceContentForm;
import org.calvaryaustin.controlpanel.ResourceForm;
import org.calvaryaustin.web.BaseValidatorForm;

/**
 * A FormBean used by the ViewerAction to store the user parameters passed in. The 
 * ViewerAction
 * @author jhigginbotham
 */
public class ViewerForm extends BaseValidatorForm implements ResourceContentForm
{
    public boolean isCollection()
    {
        return false;
    }
    
    public String getName()
    {
        return getFile();
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

    /**
     * Return a map of the parameters that represent the path to the file without revision info
     * @return a map of the parameters that represent the path to the file without revision info
     */
    public Map getParameterMapToFile()
    {
        Map map = new HashMap();
        map.put("site",site);
        map.put("path",path);
        map.put("file",file);
        return map;
    }

    /**
     * Return a map of the parameters that represent the path to the file with revision info
     * @return a map of the parameters that represent the path to the file with revision info
     */
    public Map getParameterMapToRev()
    {
        Map map = new HashMap();
        map.put("site",site);
        map.put("path",path);
        map.put("file",file);
        map.put("rev",rev);
        map.put("branch",branch);
        return map;
    }

	private String site;
	private String path;
	private String file;
	private String rev;
	private String branch;
	private String computedUri;
}
