package org.calvaryaustin.controlpanel.users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.transaction.*;
import org.apache.slide.common.*;
import org.apache.slide.structure.ObjectAlreadyExistsException;
import org.apache.struts.action.*;
import org.calvaryaustin.cms.slide.CreateUserCommand;
import org.calvaryaustin.controlpanel.*;

/**
 * Adds a new user into the system 
 * 
 * @author jhigginbotham
 */
public class AddUserAction extends AdminAction
{
    public static final String BUTTON_CREATE = "Create";
    public static final String MESSAGE_SUCCESS = "addUser.success";

    public ActionForward handleRequest(AdminUserRequest request)
        throws IOException, ServletException
    {
    	UserForm form = (UserForm)request.getActionForm();
		if (buttonPressed(request, BUTTON_CREATE))
		{
			log.debug("Processing create");
			// If there are any errors, show them on the input form
			ActionErrors errors = form.validate(request.getMapping(), request.getRequest()); // validate form
			if (!errors.isEmpty()) {
				saveErrors(request, errors);
				return (new ActionForward(request.getMapping().getInput()));
			}
			return processCreate( request, form);
		}
		// else, default to initialization
		else
		{
			log.debug("Initializing");
			return processInit(request, form);
		}
    }
    
    private ActionForward processCreate(AdminUserRequest request, UserForm form) 
		throws IOException, ServletException
    {
		NamespaceAccessToken nat = request.getNamespaceAccessToken();
		SlideToken slideToken = request.getSecurityToken();

		// do the actual transaction
		try
		{
			nat.begin();

			// attempt to create the user 
			CreateUserCommand command = new CreateUserCommand(slideToken, nat, form.getUsername(), form.getPassword(), form.getHasRootRole());
			command.execute();
			nat.commit();
			request.getMessages().add(ActionMessages.GLOBAL_MESSAGE, new ActionMessage( MESSAGE_SUCCESS, form.getUsername() ) );
			saveMessages( request );
			return (request.getMapping().findForward("addUser.success"));

		} catch (ObjectAlreadyExistsException e)
		{
			request.getErrors().add(ActionErrors.GLOBAL_ERROR, new ActionError("addUser.error.alreadyExists", form.getUsername() ) );
		} catch (SlideException e)
		{
			log.error("Error while creating user",e);
		} catch (Exception e)
		{
			log.error("Error while creating user",e);
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

		return (request.getMapping().findForward("addUser.failure"));
    }
    
	private ActionForward processInit(AdminUserRequest request, UserForm form) 
		throws IOException, ServletException
	{
		return request.getMapping().findForward("addUser.default");
	}
	    
    // --------------------------------------------------------- Public Methods
    
    
    /**
     * Process the specified HTTP request, and create the corresponding HTTP
     * response (or forward to another web component that will create it).
     * Return an <code>ActionForward</code> instance describing where and how
     * control should be forwarded, or <code>null</code> if the response has
     * already been completed.
     *
     * @param mapping The ActionMapping used to select this instance
     * @param actionForm The optional ActionForm bean for this request (if any)
     * @param request The HTTP request we are processing
     * @param response The HTTP response we are creating
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet exception occurs
    public ActionForward perform
        (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        super.perform(mapping, form, request, response);
        
        // extract attributes and parameters we will need
        Locale locale = getLocale(request);
        MessageResources messages = getResources();
        UserForm userForm = (UserForm)form;
        
        // remove the obsolete form bean from the request
        if (mapping.getAttribute() != null) {
            request.removeAttribute(mapping.getAttribute());
        }
        
        // was this transaction cancelled?
        if (isCancelled(request)) {
            return (mapping.findForward("addUser.cancelled"));
        }
        
        ActionErrors errors = new ActionErrors();
        
        if (nat != null) {
            // get the users path
            NamespaceConfig nc = nat.getNamespaceConfig();
            String strUri = nc.getUsersPath() + "/" + userForm.getUsername();
            
            // get the helpers
            Structure structure = nat.getStructureHelper();
            Content content = nat.getContentHelper();
            Security security = nat.getSecurityHelper();
            
            // do the actual transaction
            try {
                try {
                    nat.begin();
                    
                    // create the node in the structure
                    ObjectNode object;
                    if (userForm.getHasRootRole()) {
                        object = new slideroles.basic.RootRoleImpl();
                    } else {
                        object = new slideroles.basic.UserRoleImpl();
                    }
                    structure.create(st, object, strUri);
                    
                    // create a revision with the appropriate properties set
                    NodeRevisionDescriptor revision = 
                        new NodeRevisionDescriptor(0);
                    revision.setProperty(
                        new NodeProperty("resourcetype", "<collection/>",
                                         true));
                    revision.setCreationDate(new Date());
                    revision.setLastModified(new Date());
                    revision.setProperty(
                        new NodeProperty("getcontentlength", "0", true));
                    revision.setProperty(
                        new NodeProperty("source", "", true));
                    revision.setProperty(
                        new NodeProperty("password", userForm.getPassword(),
                                         NodeProperty.SLIDE_NAMESPACE));
                    content.create(st, strUri, revision, null);
                    
                    nat.commit();
                    return (mapping.findForward("addUser.success"));
                    
                } catch (ObjectAlreadyExistsException e) {
                    // duplicate username
                    errors.add(
                        "username", 
                        new ActionError("addUser.error.alreadyExists",
                                        userForm.getUsername()));
                    throw e;
                } catch (ServiceAccessException e) {
                    // low level service access failed
                    errors.add(
                        ActionErrors.GLOBAL_ERROR,
                        new ActionError("error.service",
                                        e.getCauseException().getMessage()));
                    throw e;
                } catch (Exception e) {
                    // any other errors are unanticipated
                    errors.add(
                        "username", 
                        new ActionError("error.unexpected", e.getMessage()));
                    throw e;
                }
            } catch (Exception e) {
                // rollback the transaction
                try {
                    nat.rollback();
                } catch (SystemException se) {
                    // ignore
                }
            }
        }
        
        if (!errors.empty()) {
            saveErrors(request, errors);
        }
        request.setAttribute("user", userForm);
        
        return mapping.findForward("addUser.failure");
    }
     */
    

}

