package org.calvaryaustin.controlpanel.browser;

import java.io.IOException;
import java.security.Principal;
import java.util.Date;
import java.util.Iterator;
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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.calvaryaustin.controlpanel.*;
import org.calvaryaustin.cms.RepositoryUtil;
import org.calvaryaustin.cms.WebdavRepositoryDAO;

/**
 * Controller that will process the viewing of site contents, and allow the user to (if authorized)
 * launch into content creation and editing.
 *
 * @author <a href="mailto:james@calvaryaustin.org">James Higginbotham</a>
 * @version $Revision: 1.2 $
 */
public final class BrowserAction extends AdminAction {
    
    
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
     */
    public ActionForward perform
        (ActionMapping mapping, ActionForm form,
         HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        super.perform(mapping, form, request, response);


        log.debug("Got here!");
        String siteName = request.getParameter("site");
        String path = request.getParameter("path");
        // compute the path, using our DAO (which we shouldn't use from here, 
        // but no time to do it right by talking to the repository right now -
        // instead, we are going to use the Slide tags which talk directly to the kernel
        String uri = RepositoryUtil.normalize(WebdavRepositoryDAO.FILES_PREFIX + WebdavRepositoryDAO.PATH_SITES + "/" + siteName + "/" + path); 
        log.debug("uri="+uri);
        request.setAttribute("uri", uri);
        return mapping.findForward("browser.success");
        
//         // extract attributes and parameters we will need
//         Locale locale = getLocale(request);
//         MessageResources messages = getResources();
//         UserForm userForm = (UserForm)form;
        
//         // remove the obsolete form bean from the request
//         if (mapping.getAttribute() != null) {
//             request.removeAttribute(mapping.getAttribute());
//         }
        
//         // was this transaction cancelled?
//         if (isCancelled(request)) {
//             return (mapping.findForward("addUser.cancelled"));
//         }
        
//         ActionErrors errors = new ActionErrors();
        
//         if (nat != null) {
//             // get the users path
//             NamespaceConfig nc = nat.getNamespaceConfig();
//             String strUri = nc.getUsersPath() + "/" + userForm.getUsername();
            
//             // get the helpers
//             Structure structure = nat.getStructureHelper();
//             Content content = nat.getContentHelper();
//             Security security = nat.getSecurityHelper();
            
//             // do the actual transaction
//             try {
//                 try {
//                     nat.begin();
                    
//                     // create the node in the structure
//                     ObjectNode object;
//                     if (userForm.getHasRootRole()) {
//                         object = new slideroles.basic.RootRoleImpl();
//                     } else {
//                         object = new slideroles.basic.UserRoleImpl();
//                     }
//                     structure.create(st, object, strUri);
                    
//                     // create a revision with the appropriate properties set
//                     NodeRevisionDescriptor revision = 
//                         new NodeRevisionDescriptor(0);
//                     revision.setProperty(
//                         new NodeProperty("resourcetype", "<collection/>",
//                                          true));
//                     revision.setCreationDate(new Date());
//                     revision.setLastModified(new Date());
//                     revision.setProperty(
//                         new NodeProperty("getcontentlength", "0", true));
//                     revision.setProperty(
//                         new NodeProperty("source", "", true));
//                     revision.setProperty(
//                         new NodeProperty("password", userForm.getPassword(),
//                                          NodeProperty.SLIDE_NAMESPACE));
//                     content.create(st, strUri, revision, null);
                    
//                     nat.commit();
//                     return (mapping.findForward("addUser.success"));
                    
//                 } catch (ObjectAlreadyExistsException e) {
//                     // duplicate username
//                     errors.add(
//                         "username", 
//                         new ActionError("addUser.error.alreadyExists",
//                                         userForm.getUsername()));
//                     throw e;
//                 } catch (ServiceAccessException e) {
//                     // low level service access failed
//                     errors.add(
//                         ActionErrors.GLOBAL_ERROR,
//                         new ActionError("error.service",
//                                         e.getCauseException().getMessage()));
//                     throw e;
//                 } catch (Exception e) {
//                     // any other errors are unanticipated
//                     errors.add(
//                         "username", 
//                         new ActionError("error.unexpected", e.getMessage()));
//                     throw e;
//                 }
//             } catch (Exception e) {
//                 // rollback the transaction
//                 try {
//                     nat.rollback();
//                 } catch (SystemException se) {
//                     // ignore
//                 }
//             }
//         }
        
//         if (!errors.empty()) {
//             saveErrors(request, errors);
//         }
//         request.setAttribute("user", userForm);
        
        //return mapping.findForward("addUser.failure");
    }
    
    
  private static final Log log = LogFactory.getLog( BrowserAction.class );
}

