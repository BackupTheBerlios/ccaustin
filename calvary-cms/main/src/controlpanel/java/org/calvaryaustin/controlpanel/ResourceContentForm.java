package org.calvaryaustin.controlpanel;

/**
 * A interface that can be used by common taglibs, etc. to reference a resource (file) within the system, 
 * without binding the caller to any particular module's form bean
 * @author jhigginbotham
 */
public interface ResourceContentForm extends ResourceCollectionForm
{
    /**
     * Returns the filename to the resource
     * @return the filename to the resource
     */
    public String getFile();

}
