package org.calvaryaustin.cms;

import java.util.Date;
import java.util.List;

/**
 * A File is comprised of its content and associated meta-data. A File has one or more versions 
 * associated to it. A File is locked upon a checkout and can then be edited. Changes are commited to
 * the repository upon a checkin, when the lock is released. 
 * @author jhigginbotham
 */
public interface File extends SiteResource
{
	/**
	 * Returns a Date representation of the creation date
	 * @return a Date representation of the creation date
	 */
	public Date getCreationDate();
	/**
	 * Returns the latest (most current) version of the file
	 * @return the latest (most current) version of the file
	 */
	public FileVersion getLatestVersion() throws RepositoryException;
	
	/**
	 * Returns true if this file is currently checked out. Use the getLocks() method to determine who 
	 * owns the lock
	 * @return true if this file is currently checked out
	 */
	public boolean isCheckedOut() throws RepositoryException;
	
	/**
	 * Returns a list of Locks or an empty list if the file isn't locked
	 * @return a list of Locks or an empty list if the file isn't locked
	 */
	public List getLocks() throws RepositoryException;
	
	/**
	 * Kills any/all locks on this resource. Quietly returns if not locks were found.
	 * @throws RepositoryException if an error occurs
	 */
	public void killLocks() throws RepositoryException;
	
	/**
	 * Checks out the file for a duration of 1 hour, in which time a user has the file locked and 
	 * may edit the contents and associated meta data. If the checkout expires before a checkin occurs, 
	 * the lock is removed and another lock must be obtained via this method.  
	 * @throws RepositoryException is an error occurs during checkout
	 * @throws PageLockedException if the file is already locked
	 */
	public FileVersion checkout() throws RepositoryException, FileLockedException;	
	/**
	 * Check in a version that was previously checked out. The updated version is then used to create a new
	 * version in the repository, marks the new version as the latest (most current), and the lock is removed from the file.
	 * @throws RepositoryException is an error occurs
	 * @throws PageNotLockedException if the file has not been locked or the previous lock expired
	 */
	public void checkin(FileVersion updatedVersion) throws RepositoryException,FileNotLockedException;
	/**
	 * Deletes the file and all historical versions, unless the file is currently locked
	 * @throws RepositoryException if an error occurs
	 * @throws FileNotLockedException if the file is currently locked
	 */	
	public void delete() throws RepositoryException,FileLockedException;	
}
