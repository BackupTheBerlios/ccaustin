package org.calvaryaustin.cms;

/**
 * A Lock that exists on a File
 * @author jhigginbotham
 */
public interface Lock
{
	/**
	 * Returns the internal id for the lock
	 * @return the internal id for the lock
	 */
	public String getId();
	/**
	 * Returns the owner of the lock
	 * @return the owner of the lock
	 */
	public String getOwner();
}
