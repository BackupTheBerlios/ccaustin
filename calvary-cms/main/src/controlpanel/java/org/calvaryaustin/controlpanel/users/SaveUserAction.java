/*
 * $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/ccaustin/Repository/calvary-cms/main/src/controlpanel/java/org/calvaryaustin/controlpanel/users/SaveUserAction.java,v 1.1 2003/02/12 22:06:57 javajames27 Exp $
 * $Revision: 1.1 $
 * $Date: 2003/02/12 22:06:57 $
 *
 * ====================================================================
 *
 * The Apache Software License, Version 1.1
 *
 * Copyright (c) 1999-2002 The Apache Software Foundation.  All rights 
 * reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer. 
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. The end-user documentation included with the redistribution, if
 *    any, must include the following acknowlegement:  
 *       "This product includes software developed by the 
 *        Apache Software Foundation (http://www.apache.org/)."
 *    Alternately, this acknowlegement may appear in the software itself,
 *    if and wherever such third-party acknowlegements normally appear.
 *
 * 4. The names "The Jakarta Project", "Slide", and "Apache Software
 *    Foundation" must not be used to endorse or promote products derived
 *    from this software without prior written permission. For written 
 *    permission, please contact apache@apache.org.
 *
 * 5. Products derived from this software may not be called "Apache"
 *    nor may "Apache" appear in their names without prior written
 *    permission of the Apache Group.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL THE APACHE SOFTWARE FOUNDATION OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals on behalf of the Apache Software Foundation.  For more
 * information on the Apache Software Foundation, please see
 * <http://www.apache.org/>.
 *
 * [Additional notices, if required by prior licensing conditions]
 *
 */ 

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
import org.apache.slide.macro.*;
import org.apache.slide.lock.*;
import org.apache.struts.util.MessageResources;

import org.calvaryaustin.controlpanel.*;

/**
 * Action that will update the properties of an existing user in the namespace,
 * taking the necessary information from a 
 * {@link org.apache.slide.admin.users.UserForm UserForm}.
 *
 * @author <a href="mailto:cmlenz@apache.org">Christopher Lenz</a>
 * @version $Revision: 1.1 $
 */
public final class SaveUserAction extends AdminAction {
    
    
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
            return (mapping.findForward("saveUser.cancelled"));
        }
        
        ActionErrors errors = new ActionErrors();
        
        if (nat != null) {
            // get the helpers
            Structure structure = nat.getStructureHelper();
            Content content = nat.getContentHelper();
            Macro macro = nat.getMacroHelper();
            Security security = nat.getSecurityHelper();
            
            // get the users path
            NamespaceConfig nc = nat.getNamespaceConfig();
            String sourceUri = userForm.getOriginalUri();
            String destinationUri = 
                nc.getUsersPath() + "/" + userForm.getUsername();
            
            // do the actual transaction
            try {
                try {
                    nat.begin();
                    
                    if (!destinationUri.equals(sourceUri)) {
                        // move the user node
                        macro.move(st, sourceUri, destinationUri, 
                                   new MacroParameters(true, false));
                    }
                    
                    // set the new password
                    NodeRevisionDescriptor revision = null;
                    NodeRevisionDescriptors revisions =
                        content.retrieve(st, destinationUri);
                    if (revisions != null) {
                        revision = content.retrieve(st, revisions);
                    } else {
                        revision = new NodeRevisionDescriptor(0);
                        revision.setProperty(
                            new NodeProperty("resourcetype", "<collection/>",
                                             true));
                        revision.setCreationDate(new Date());
                        revision.setLastModified(new Date());
                        revision.setProperty(
                            new NodeProperty("getcontentlength", "0", true));
                        revision.setProperty(
                            new NodeProperty("source", "", true));
                    }
                    revision.setProperty(
                        new NodeProperty("password", userForm.getPassword(),
                                         NodeProperty.SLIDE_NAMESPACE));
                    content.store(st, destinationUri, revision, null);
                    
                    nat.commit();
                    return (mapping.findForward("saveUser.success"));
                    
                } catch (MacroException e) {
                    // some aspect of the move operation failed
                    // TODO: provide more details
                    errors.add(
                        ActionErrors.GLOBAL_ERROR,
                        new ActionError("editUser.error.moveFailed"));
                    throw e;
                } catch (ObjectLockedException e) {
                    // one or more of the affected objects is currently locked
                    errors.add(
                        ActionErrors.GLOBAL_ERROR,
                        new ActionError("editUser.error.locked"));
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
        
        return (mapping.findForward("saveUser.failure"));
    }
    
    
}

