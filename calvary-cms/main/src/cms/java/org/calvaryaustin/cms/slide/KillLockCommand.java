package org.calvaryaustin.cms.slide;
 
import org.apache.slide.common.*;
import org.apache.slide.structure.*;


/**
 * Kills an existing lock on a resource
 * @author jhigginbotham
 */
public class KillLockCommand extends AbstractSlideCommand
{

    /**
     * Initialize the command that is to be performed
     * @param slideToken the client token to use for the work
     * @param namespace the namespace token to perform the work
     * @param uriToUnlock the URI to the resource to unlock
     */
    public KillLockCommand(SlideToken slideToken, NamespaceAccessToken namespace, String uriToUnlock)
    {
        super(slideToken, namespace);
        this.uriToUnlock = uriToUnlock;
    }


	public void execute() throws SlideException
	{
        // Prevent dirty reads
        slideToken.setForceStoreEnlistment(true);
        NamespaceConfig namespaceConfig = namespace.getNamespaceConfig();
        SubjectNode unlockSubject = (SubjectNode) structure.retrieve(slideToken, uriToUnlock);
        lock.kill(slideToken, unlockSubject);
	}
	
    /**
     * Lock subject.
     */
    private String uriToUnlock;

}
