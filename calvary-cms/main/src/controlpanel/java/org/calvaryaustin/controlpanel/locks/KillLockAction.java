package org.calvaryaustin.controlpanel.locks;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.transaction.SystemException;

import org.apache.slide.common.NamespaceAccessToken;
import org.apache.slide.common.ServiceAccessException;
import org.apache.slide.common.SlideException;
import org.apache.slide.common.SlideToken;
import org.apache.slide.lock.Lock;
import org.apache.slide.lock.LockTokenNotFoundException;
import org.apache.slide.lock.NodeLock;
import org.apache.slide.lock.ObjectIsAlreadyLockedException;
import org.apache.slide.structure.ObjectNode;
import org.apache.slide.structure.Structure;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForward;
import org.calvaryaustin.cms.RepositoryUtil;
import org.calvaryaustin.cms.WebdavRepositoryDAO;
import org.calvaryaustin.cms.slide.CreateLockCommand;
import org.calvaryaustin.cms.slide.KillLockCommand;
import org.calvaryaustin.controlpanel.AdminAction;
import org.calvaryaustin.controlpanel.AdminUserRequest;

/**
 * Processes requests to either 1) Begin an editing session, 2) Preview an existing editing
 * session's changes without saving, or 3) Save the modifications of an active editing session
 * <p>
 * Requires the following parameters:
 * <pre>
 *   site   - the name of the site that the document resides
 *   path   - the path to the document, excluding the document name
 *   file   - the filename of the document, excluding the path
 * </pre>
 * </p>
 * @author jhigginbotham
 */
public class KillLockAction extends AdminAction
{
    public static final String BUTTON_PREVIEW = "Preview";
    public static final String BUTTON_SAVE = "Save";

    public ActionForward handleRequest(AdminUserRequest request)
        throws IOException, ServletException
    {
        LockForm form = (LockForm) request.getActionForm();
        String siteName = form.getSite();
        siteName = siteName == null ? "" : siteName;
        String path = form.getPath();
        path = path == null ? "" : path;
        String file = form.getFile();
        // compute the path, using our DAO (which we shouldn't use from here, 
        // but no time to do it right by talking to the repository right now -
        // instead, we are going to use the Slide tags which talk directly to the kernel
        String uri = RepositoryUtil.normalize(WebdavRepositoryDAO.FILES_PREFIX + WebdavRepositoryDAO.PATH_SITES + "/" + siteName + "/" + path + "/" + file); 
        log.debug("uri="+uri);
        form.setComputedUri( uri );

        return processKillLock(request);
    }
    
    private ActionForward processKillLock(AdminUserRequest request)
    {
        NamespaceAccessToken nat = request.getNamespaceAccessToken();
        SlideToken slideToken = request.getSecurityToken();
        LockForm form = (LockForm)request.getActionForm();
    
        // get the helpers	
        Structure structure = nat.getStructureHelper();
        Lock lock = nat.getLockHelper();

        // do the actual transaction
        try
        {
            nat.begin();

            // attempt to kill the lock 
            KillLockCommand command = new KillLockCommand(slideToken, nat, form.getComputedUri());
            command.execute();
            nat.commit();
            return (request.getMapping().findForward("killLock.success"));

        } catch (SlideException e)
        {
            log.error("Error while killing lock",e);
        } catch (Exception e)
        {
            log.error("Error while killing lock",e);
            // any other errors are unanticipated
        }
            
        // rollback the transaction, as something failed
        try
        {
            nat.rollback();
        } catch (SystemException se)
        {
            // ignore
            log.warn("Error during rollback",se);
        }
            

        if (!request.getErrors().isEmpty())
        {
            saveErrors(request, request.getErrors());
        }
        //request.setAttribute("locks", locksForm);

        return (request.getMapping().findForward("killLock.failure"));
    }
}


