package org.calvaryaustin.cms.slide;
 
import java.util.*;

import org.apache.slide.common.*;
import org.apache.slide.lock.*;
import org.apache.slide.structure.*;
 

/**
 * Renews all locks on a given resource for the given duration period
 * @author jhigginbotham
 */
public class RenewLockCommand extends AbstractSlideCommand
{

    /**
     * Initialize the lock command that is to be performed
     * @param slideToken the client token to use for the work
     * @param namespace the namespace token to perform the work
     * @param uriToLock the URI to the resource to lock
     * @param lockDurationInSeconds the duration time for the lock before expiration
     */
    public RenewLockCommand(SlideToken slideToken, NamespaceAccessToken namespace, String uriToLock,
    						 int lockDurationInSeconds)
    {
        super(slideToken, namespace);
        this.uriToLock = uriToLock;
        this.lockDuration = lockDurationInSeconds;
    }


	public void execute() throws SlideException
	{
        SubjectNode toLockSubject = null;
        Date lockDate = null;

        // Prevent dirty reads
        slideToken.setForceStoreEnlistment(true);

        NamespaceConfig namespaceConfig = namespace.getNamespaceConfig();
            
        Enumeration lockTokens = lock.enumerateLocks(slideToken, uriToLock, false);
                
        NodeLock currentLockToken = null;
        Date newExpirationDate = new Date((new Date()).getTime() + (lockDuration * 1000));
        while (lockTokens.hasMoreElements()) 
        {
            currentLockToken = (NodeLock) lockTokens.nextElement();
            lock.renew(slideToken, currentLockToken, newExpirationDate);
        }
	}
	
    /**
     * Lock subject.
     */
    private String uriToLock;

    /**
     * Lock duration.
     */
    private int lockDuration = DEFAULT_TIMEOUT;
}
