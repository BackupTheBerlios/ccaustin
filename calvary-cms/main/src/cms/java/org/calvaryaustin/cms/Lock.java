package org.calvaryaustin.cms;

/**
 * A Lock that exists on a File
 * @author jhigginbotham
 */
public interface Lock
{
	public String getId();
	public String getOwner();
	public String getExpires();
	public void kill() throws RepositoryException;
}
