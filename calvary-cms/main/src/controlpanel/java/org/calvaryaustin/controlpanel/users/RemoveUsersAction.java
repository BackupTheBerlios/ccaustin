package org.calvaryaustin.controlpanel.users;

import java.io.IOException;
import java.security.Principal;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.*;

import org.apache.slide.authenticate.*;
import org.apache.slide.common.*;
import org.apache.slide.content.*;
import org.apache.slide.security.*;
import org.apache.slide.structure.*;
import org.apache.slide.macro.*;
import org.apache.struts.action.*;
import org.apache.struts.util.MessageResources;

import org.calvaryaustin.controlpanel.*;

/**
 * Action that will remove all users selected in a given 
 * {@link org.apache.slide.admin.users.UsersForm UsersForm} from the namespace.
 */
public final class RemoveUsersAction extends AdminAction {
    
    
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
        UsersForm usersForm = (UsersForm)form;
        
        // remove the obsolete form bean from the request
        if (mapping.getAttribute() != null) {
            request.removeAttribute(mapping.getAttribute());
        }
        
        ActionErrors errors = new ActionErrors();
        
        String[] users = usersForm.getUsers();
        if ((nat != null) && (users.length > 0)){
            // get the helpers
            Macro macro = nat.getMacroHelper();
            
            // get the path of the current authenticated user
            String selfName = st.getCredentialsToken().getPublicCredentials();
            NamespaceConfig nc = nat.getNamespaceConfig();
            String selfUri = nc.getUsersPath() + "/" + selfName;
            
            // do the actual transaction
            try {
                try {
                    nat.begin();
                    
                    for (int i = 0; i < users.length; i++) {
                        
                        if (users[i].equals(selfUri)) {
                            // the user may not delete herself
                            errors.add(
                                ActionErrors.GLOBAL_ERROR,
                                new ActionError("removeUsers.error.notSelf",
                                                selfName));
                            throw new Exception();
                        }
                        
                        // FIXME: find and remove links to the deleted 
                        // user node ?
                        
                        // do a recursive delete
                        macro.delete(st, users[i], 
                                     new MacroParameters(true, false));
                    }
                    
                    nat.commit();
                    return (mapping.findForward("removeUsers.success"));
                
                } catch (MacroException e) {
                    // some aspect of the delete operation failed
                    // TODO: provide more details
                    errors.add(
                        ActionErrors.GLOBAL_ERROR,
                        new ActionError("removeUsers.error.deleteFailed"));
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
        request.setAttribute("users", usersForm);
        
        return (mapping.findForward("removeUsers.failure"));
    }
	*/
    
    public ActionForward handleRequest(AdminUserRequest request)
        throws IOException, ServletException
    {
        // TODO Auto-generated method stub
        return null;
    }
    
    
}

