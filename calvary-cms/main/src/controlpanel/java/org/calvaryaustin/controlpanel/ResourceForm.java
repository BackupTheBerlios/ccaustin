package org.calvaryaustin.controlpanel;

/**
 * A base interface that can be used by common taglibs, etc. to reference a resource within the system, 
 * without binding the caller to any particular module's form bean
 * @author jhigginbotham
 */
public interface ResourceForm
{
    /**
     * Returns the path to the resource
     * @return the path to the resource
     */
    public String getPath();
    /**
     * Sets the path.
     * @param path The path to set
     */
    public void setPath(String path);
    /**
     * Returns the site to the resource
     * @return the site to the resource
     */
    public String getSite();
    /**
     * Returns the filename to the resource
     * @return the filename to the resource
     */
    public String getFile();
}
