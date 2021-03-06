package org.calvaryaustin.controlpanel.editor;

import org.calvaryaustin.web.BaseValidatorForm;

/**
 * Represents a document, its current or edited contents, and other view-related information
 * @author jhigginbotham
 */
public class EditorForm extends BaseValidatorForm
{
	// TODO: Add requirement for layout, renderer, and template to be selected

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

    /**
     * Returns the form bean's current contents, initialized from the server if editing
     * an existing resource
     * @return String the form bean's current contents
     */
    public String getContent()
    {
        return content;
    }

    /**
     * Sets the content from the server or the user
     * @param content The content to set
     */
    public void setContent(String content)
    {
        this.content = content;
    }

    /**
     * Returns the form bean's current content type, initialized from the server if editing
     * an existing resource
     * @return String the form bean's current content type
     */
    public String getContentType()
    {
        return contentType;
    }

    /**
     * Sets the contentType.
     * @param contentType The contentType to set
     */
    public void setContentType(String contentType)
    {
        this.contentType = contentType;
    }

	/**
	 * Returns the reason for changing the content 
	 * @return the reason for changing the content
	 */
	public String getReasonForChange()
	{
		return reasonForChange;
	}

	/**
	 * Sets the reason for changing the content
	 * @param string containing the reason for changing the content
	 */
	public void setReasonForChange(String string)
	{
		reasonForChange = string;
	}

    private String site;
    private String path;
    private String file;
    private String computedUri;
    private String contentType;
    private String content;
	private String reasonForChange;    
}
