package org.calvaryaustin.controlpanel;

import java.io.IOException;
import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.slide.authenticate.*;
import org.apache.slide.common.*;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.calvaryaustin.web.BaseAction;
import org.calvaryaustin.web.UserRequest;

/**
 * Abstract class that serves as a foundation for all of the admin actions
 *
 * @author jhigginbotham
 */
public abstract class AdminAction extends BaseAction 
{
    /**
     * Overriding the abstract method, and calling the handleRequest(AdminUserRequest)
     * instead with the casted user request for calling into Slide.
     * @see org.calvaryaustin.web.BaseAction#handleRequest(UserRequest)
     */
    public ActionForward handleRequest(UserRequest request)
        throws IOException, ServletException
    {
		return handleRequest((AdminUserRequest)request);
    }

	/**
	 * Overriding to construct a new AdminUserRequest instance instead of the default 
	 * UserRequest
	 * @see org.calvaryaustin.web.BaseAction#createUserRequest()
	 */
    protected UserRequest createUserRequest()
    {
      	return new AdminUserRequest();
    }

	/**
	 * Calls super, then sets the 2 fields needed for Slide work
	 * @see org.calvaryaustin.web.BaseAction#populateUserRequest(ActionMapping, ActionForm, HttpServletRequest, HttpServletResponse, UserRequest)
	 */
    protected void populateUserRequest( ActionMapping mapping,
                                          ActionForm form,
                                          HttpServletRequest req,
                                          HttpServletResponse res,
                                          UserRequest request)
	{
	    // be sure to allow the framework to fill in the request first
	    super.populateUserRequest(mapping, form, req, res, request);
	    
        AdminUserRequest adminRequest = (AdminUserRequest)request;

        // get the slide token
        CredentialsToken credentials;
        Principal principal = req.getUserPrincipal();
        if (principal != null) {
            credentials = new CredentialsToken(principal);
        } else {
            credentials = new CredentialsToken("");
        }
        adminRequest.security = new SlideTokenImpl(credentials);
        
        // get the namespace access token
        String namespaceName = 
            (String)getServlet().getServletContext().getAttribute
            ("org.apache.slide.NamespaceName");
        if (namespaceName == null) {
            namespaceName =
                getServlet().getServletContext().getInitParameter
                ("org.apache.slide.NamespaceName");
        }
        if (namespaceName == null) {
            // the default namespace
            namespaceName = Domain.getDefaultNamespace();
        }
        SecurityToken security = 
            new SecurityToken(getServlet().getServletContext());

        adminRequest.namespace = Domain.accessNamespace(security, namespaceName);
	}
                                          
    
    /**
     * Override this method to get an already casted form of the user request for 
     * doing Slide-specific work
     * @param request
     * @return ActionForward
     * @throws IOException
     * @throws ServletException
     */
    abstract public ActionForward handleRequest(AdminUserRequest request)
        throws IOException, ServletException;

}

