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
import org.apache.struts.action.*;
import org.apache.struts.util.MessageResources;

import org.calvaryaustin.controlpanel.*;

/**
 * Action that will find a user in the namespace and populate a fresh
 * {@link org.apache.slide.admin.users.UserForm UserForm} with the user's 
 * properties if found, then forward to the page for the actual editing of that
 * user.
 *
 * @author <a href="mailto:cmlenz@apache.org">Christopher Lenz</a>
 * @version $Revision: 1.2 $
 */
public final class EditUserAction extends AdminAction {
    
    
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
        
        // remove the obsolete form bean from the request
        if (mapping.getAttribute() != null) {
            request.removeAttribute(mapping.getAttribute());
        }
        
        ActionErrors errors = new ActionErrors();
        
        if (nat != null) {
            // get the helpers
            Structure structure = nat.getStructureHelper();
            Security security = nat.getSecurityHelper();
            
            String userName = "";
            
            // find the user
            try {
                String userUri = request.getParameter("uri");
                ObjectNode userNode = structure.retrieve(st, userUri);
                
                userName = userUri;
                int sep = userName.lastIndexOf('/');
                if (sep > 0) {
                    userName = userName.substring(sep + 1, userName.length());
                }
                
                UserForm userForm = new UserForm();
                // don't set the password (bits of humble security)
                userForm.setOriginalUri(userUri);
                userForm.setUsername(userName);
                if (security.hasRole(userNode, "root")) {
                    userForm.setHasRootRole(true);
                }
                request.setAttribute("user", userForm);
                
                return (mapping.findForward("editUser.success"));
            } catch (ObjectNotFoundException e) {
                // couldn't find the node of the user that should be edited
                errors.add(
                    "username", 
                    new ActionError("editUser.error.notFound", userName));
            } catch (ServiceAccessException e) {
                // low level service access failed
                errors.add(
                    ActionErrors.GLOBAL_ERROR,
                    new ActionError("error.service",
                                    e.getCauseException().getMessage()));
            } catch (Exception e) {
                // any other errors are unanticipated
                errors.add(
                    "username", 
                    new ActionError("error.unexpected", e.getMessage()));
            }
        }
        
        if (!errors.empty()) {
            saveErrors(request, errors);
        }

        return (mapping.findForward("editUser.failure"));
    }
*/
    
    public ActionForward handleRequest(AdminUserRequest request)
        throws IOException, ServletException
    {
        // TODO Auto-generated method stub
        return null;
    }
    
}

