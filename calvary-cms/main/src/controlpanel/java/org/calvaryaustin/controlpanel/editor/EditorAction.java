package org.calvaryaustin.controlpanel.editor;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
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
import org.apache.slide.taglib.bean.NamespaceBean;
import org.apache.slide.taglib.bean.NodeBean;
import org.apache.slide.taglib.bean.RevisionBean;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForward;
import org.calvaryaustin.cms.RepositoryUtil;
import org.calvaryaustin.cms.WebdavRepositoryDAO;
import org.calvaryaustin.cms.slide.CreateLockCommand;
import org.calvaryaustin.cms.slide.KillLockCommand;
import org.calvaryaustin.cms.slide.UpdateCommand;
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
 * 
 * @author jhigginbotham
 */
public class EditorAction extends AdminAction
{
    // TODO: Add support for previewing once we get the meta data about the renderer, template, layout
    // TODO: After save, forward to the view page with a success message
    // TODO: Add a cancel editing which would unlock the resource and return to the view page
    // TODO: Add form validation
    
    public static final String BUTTON_PREVIEW = "Preview";
    public static final String BUTTON_CANCEL = "Cancel";
    public static final String BUTTON_SAVE = "Save";

    public ActionForward handleRequest(AdminUserRequest request)
        throws IOException, ServletException
    {
        EditorForm form = (EditorForm) request.getActionForm();
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

        // if save clicked attempt to save the modified content
        if (buttonPressed(request, BUTTON_SAVE))
        {
            log.debug("Save pressed");
			return processSave( request, form );
        }
        // else, if preview clicked
        else if (buttonPressed(request, BUTTON_PREVIEW))
        {
            log.debug("Preview pressed");
            // TODO: call the preview page
        }
        // else, if cancel clicked
        else if (buttonPressed(request, BUTTON_CANCEL))
        {
            log.debug("Cancel pressed");
            // call the cancel logic
            return processCancel(request, form);
        }
        // else, default to init'ing the editing
        else
        {
            log.debug("Initializing editor");
            return processInitEditor(request, form);
        }

        return request.getMapping().findForward("editor.default");
    }

    private ActionForward processSave( AdminUserRequest request, EditorForm form)
    {
        // validate that, if the user submitted XML, its valid
        
        NamespaceAccessToken nat = request.getNamespaceAccessToken();
        SlideToken slideToken = request.getSecurityToken();
        try 
        {
            nat.begin();
            
            // TODO; first, verify the lock is still valid

            // TODO: if not, attempt to obtain the lock again

            // TODO: if not, show error

            // otherwise, update the content
            UpdateCommand updateCommand = new UpdateCommand(slideToken, nat, form.getComputedUri(), form.getContentType(), form.getContent());
            updateCommand.execute();	
            
            // TODO: next, attach the properties for our build system
            											  
            // now, remove the lock
            KillLockCommand killCommand = new KillLockCommand(slideToken, nat, form.getComputedUri() );
			killCommand.execute();  
			
			nat.commit();          												  

            // finally, forward to the success page
            // TODO: Add a nice message and put a nice message area into the master layout that shows an info message if available (vs. errors)
            return request.getMapping().findForward("editor.save.success");
        } catch(Exception e)
        {
            log.error("caught",e);
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

    private ActionForward processCancel( AdminUserRequest request, EditorForm form)
    {
        NamespaceAccessToken nat = request.getNamespaceAccessToken();
        SlideToken slideToken = request.getSecurityToken();

        // get the helpers	
        Structure structure = nat.getStructureHelper();
        Lock lock = nat.getLockHelper();

	    try
	    {
	        nat.begin();
            KillLockCommand command = new KillLockCommand(slideToken, nat, form.getComputedUri());
            command.execute();
	        nat.commit();
	    }
	    catch (Exception e)
	    {
	       log.error("General error occured",e);
           // rollback the transaction, as something failed
           try
           {
               nat.rollback();
           } catch (SystemException se)
           {
               // ignore
               log.warn("Error during rollback",se);
           }
		}        

        if (!request.getErrors().isEmpty())
        {
            saveErrors(request, request.getErrors());
        }

		// no matter what, go back to the viewer

		// TODO: consider if we want to write some utility or Facade for the package for forwarding to it or something?!
		// (may also need to create some interfaces that the form beans implement to allow things like site, path, file to be 
		//  obtained without specific module class knowledge) 

		// NOTE: Since the variables were hidden fields in the JSP, it will be grabbed by the viewer and 
		//       forwarded
        return (request.getMapping().findForward("editor.cancel"));
    }
    
    private ActionForward processInitEditor( AdminUserRequest request, EditorForm form)
    {
        NamespaceAccessToken nat = request.getNamespaceAccessToken();
        SlideToken slideToken = request.getSecurityToken();
        
        // get the helpers	
        Structure structure = nat.getStructureHelper();
        Lock lock = nat.getLockHelper();

        // do the actual transaction
        try
        {
            try
            {
                nat.begin();

                // first, attempt to lock the requested doc
                
                // Note: Since our UpdateCommand called when the save button is pressed is currently using the HTTP method 
                // of talking to the server, it automatically checksout then checksin the resource - no need to lock right now
                 
                //CreateLockCommand createLock = new CreateLockCommand(slideToken, nat, form.getComputedUri(), true, true, CreateLockCommand.DEFAULT_TIMEOUT);
                //createLock.execute();
                
                // next, load up the contents of the latest revision and fill in a form bean using the slide struts beans
                NamespaceBean namespace = new NamespaceBean(nat, slideToken);
                NodeBean nodeBean = namespace.getNode( form.getComputedUri(), true );
				String contentType = nodeBean.getLatestRevision().getContentType();
				String content = readContent( nodeBean.getLatestRevision() );
				form.setContentType( contentType );
				form.setContent( content );

                // finally, commit and forward to the appropriate editor
                nat.commit();
                return (request.getMapping().findForward("editor.default"));

            } catch (ObjectIsAlreadyLockedException e)
            {
                log.error("Error while obtaining lock - already locked",e);
                
                // Check to see who owns the lock. If its not the current user for this request, 
                // then show an error page.. Otherwise, forward to the editor anyway
                ObjectNode principal = nat.getSecurityHelper().getPrincipal( slideToken ); 
                log.debug("principal uri="+principal.getUri());
                Enumeration enum = nat.getLockHelper().enumerateLocks(slideToken, form.getComputedUri(), false);
                boolean found = false;
                while(enum.hasMoreElements())
                {
                    NodeLock nodeLock = (NodeLock)enum.nextElement();
                    log.debug("  inner loop:"+nodeLock.getSubjectUri());
                    if( nodeLock.getSubjectUri().equals(principal.getUri()))
                    { 
                        log.debug("Found a lock by the current user, so we'll renew the lock and proceed");
                        found = true;
                   		// TODO: Add renew lock code here     
                    }
                }
                if (!found)
                {
                	log.debug("Could not locate a lock by the current user, so someone else has it.. Forward to error page with info");
                    // TODO: Construct a nice error to let the user know who owns the lock and forward to the error page
                }
                
            } catch (LockTokenNotFoundException e)
            {
                log.error("Error while obtaining lock",e);
                // lock token not found
                // FIXME: more details: which object, which token ?
                request.getErrors().add(
                    ActionErrors.GLOBAL_ERROR,
                    new ActionError("killLocks.error.notFound"));
            } catch (ServiceAccessException e)
            {
                log.error("Error while obtaining lock",e);
                // low level service access failed
                request.getErrors().add(
                    ActionErrors.GLOBAL_ERROR,
                    new ActionError(
                        "error.service",
                        e.getCauseException().getMessage()));
            } catch (javax.transaction.NotSupportedException e)
            {
                log.error("TX Error while obtaining lock",e);
                // rollback the transaction here and below to try to get the JTA TX back on track
                try
                {
                    nat.rollback();
                } catch (SystemException se)
                {
                    // ignore
                    log.warn("Error during rollback",se);
                }
                
            } catch (Exception e)
            {
                log.error("Error while obtaining lock",e);
                // any other errors are unanticipated
                request.getErrors().add(
                    "username",
                    new ActionError("error.unexpected", e.getMessage()));
            }
        } catch (Exception e)
        {
            log.error("General error occured",e);
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
	
	    return (request.getMapping().findForward("editor.failure"));
	}

	private String readContent( RevisionBean revision ) throws IOException, SlideException
	{
        Reader reader = revision.getReader();
        BufferedReader br = new BufferedReader(reader);
        StringBuffer sb = new StringBuffer();
        int i;
        while ((i = reader.read()) != -1) {
            sb.append((char)i);
        }
        return sb.toString();
    }

}
