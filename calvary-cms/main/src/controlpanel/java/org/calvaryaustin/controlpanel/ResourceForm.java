package org.calvaryaustin.controlpanel;

/**
 * A interface that can be used by common taglibs, etc. to reference a resource (file) within the system, 
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
     * Returns the site to the resource
     * @return the site to the resource
     */
    public String getSite();
    /**
     * Returns the name of the resource 
     * @return String the name of the resource 
     */
    public String getName();
    /**
     * Returns true if the resource is a collection
     * @return boolean true if the resource is a collection
     */
    public boolean isCollection();
}
