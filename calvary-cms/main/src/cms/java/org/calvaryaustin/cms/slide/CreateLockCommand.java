package org.calvaryaustin.cms.slide;
 
import java.util.*;

import org.apache.slide.common.*;
import org.apache.slide.lock.*;
import org.apache.slide.content.*;
import org.apache.slide.structure.*;


/**
 * Creates a new Lock on a given resource and saves the lock information for later use by the caller
 * @author jhigginbotham
 */
public class CreateLockCommand extends AbstractSlideCommand
{

    /**
     * Initialize the lock command that is to be performed
     * @param slideToken the client token to use for the work
     * @param namespace the namespace token to perform the work
     * @param uriToLock the URI to the resource to lock
     * @param inheritance true if the lock is to include all children
     * @param exclusive true if the lock is to be exlusive, false if shared
     * @param lockDurationInSeconds the duration time for the lock before expiration
     */
    public CreateLockCommand(SlideToken slideToken, NamespaceAccessToken namespace, String uriToLock,
    						  boolean inheritance, boolean exclusive, int lockDurationInSeconds)
    {
        super(slideToken, namespace);
        this.uriToLock = uriToLock;
        this.inheritance = inheritance;
        this.exclusive = exclusive;
        this.lockDuration = lockDurationInSeconds;
    }


	public void execute() throws SlideException
	{
            SubjectNode toLockSubject = null;
            Date lockDate = null;

            // Prevent dirty reads
            slideToken.setForceStoreEnlistment(true);

            NamespaceConfig namespaceConfig = namespace.getNamespaceConfig();
                
            try {
                toLockSubject = (SubjectNode) structure.retrieve(slideToken, uriToLock);
            } catch (ObjectNotFoundException ex) {
                    
                // Creating a lock null resource
                toLockSubject = new SubjectNode();
                    
                // Creating new subject
                structure.create(slideToken, toLockSubject, uriToLock);
                    
                NodeRevisionDescriptor revisionDescriptor =
                    new NodeRevisionDescriptor(0);
                    
                // Resource type
                revisionDescriptor.setResourceType("<lock-null/>");
                    
                // Creating the revision descriptor
                content.create(slideToken, uriToLock,
                               revisionDescriptor, null);
                    
                // HACK
                // Setting a max timeout when creating a lock-null
                // resource because the associated lock-null wouldn't
                // be automatically removed when the lock expires
                lockDate = new Date((new Date()).getTime()
                                    + (MAX_TIMEOUT * 1000));
                    
            }
                
            SubjectNode credentialsSubject =
                (SubjectNode) structure.retrieve
                (slideToken, namespaceConfig.getUsersPath() + "/"
                 + slideToken.getCredentialsToken()
                 .getPublicCredentials());
                
            if (lockDate == null)
                lockDate = new Date((new Date()).getTime()
                                    + (lockDuration * 1000));
                
            lockToken =
                new NodeLock(toLockSubject, credentialsSubject,
                             namespaceConfig.getCreateObjectAction(),
                                 lockDate, inheritance, exclusive, lockOwner);
            lock.lock(slideToken, lockToken);
                
            try {
                lockToken = new NodeLock
                    (lockToken,
                     namespaceConfig.getCreateRevisionMetadataAction()
                     .getUri());
                lock.lock(slideToken, lockToken);
            } catch (ObjectIsAlreadyLockedException e) {
                // Silent catch
            }

            try {
                lockToken = new NodeLock
                    (lockToken,
                     namespaceConfig.getModifyRevisionMetadataAction()
                     .getUri());
                lock.lock(slideToken, lockToken);
            } catch (ObjectIsAlreadyLockedException e) {
                // Silent catch
            }
                
            try {
                lockToken = new NodeLock
                    (lockToken,
                     namespaceConfig.getRemoveRevisionMetadataAction()
                     .getUri());
                lock.lock(slideToken, lockToken);
            } catch (ObjectIsAlreadyLockedException e) {
                // Silent catch
            }
                
            try {
                lockToken = new NodeLock
                    (lockToken,
                     namespaceConfig.getModifyRevisionContentAction()
                     .getUri());
                lock.lock(slideToken, lockToken);
            } catch (ObjectIsAlreadyLockedException e) {
                // Silent catch
            }
                
            try {
                lockToken = new NodeLock
                    (lockToken,
                     namespaceConfig.getRemoveRevisionContentAction()
                     .getUri());
                lock.lock(slideToken, lockToken);
            } catch (ObjectIsAlreadyLockedException e) {
                // Silent catch
            }
                
            try {
                lockToken =
                    new NodeLock(lockToken,
                                 namespaceConfig.getRemoveObjectAction()
                                 .getUri());
                lock.lock(slideToken, lockToken);
            } catch (ObjectIsAlreadyLockedException e) {
                // Silent catch
            }

		// add this point, we've successfully locked the resource
		// so, the caller can get the final lockToken via the getLockToken() method                
	}
	
	/**
	 * Returns the final lock token after the resource was successfully locked (null if the command failed)
	 * @return the final lock token after the resource was successfully locked (null if the command failed)
	 */
	public NodeLock getLockToken()
	{
	    return lockToken;
	}

    /**
     * Lock scope.
     */
    private String lockScope;
    
    
    /**
     * Lock owner.
     */
    private String lockOwner;
    
    
    /**
     * Lock subject.
     */
    private String uriToLock;

    /**
     * Lock duration.
     */
    private int lockDuration = DEFAULT_TIMEOUT;

	private boolean inheritance = false;
    private boolean exclusive;
    private NodeLock lockToken = null; // set with the node lock reference of the subject locked after a successful lock

}
