/*
 * $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/ccaustin/Repository/calvary-cms/main/src/controlpanel/java/org/calvaryaustin/controlpanel/locks/Attic/KillLocksAction.java,v 1.1 2003/02/12 22:06:57 javajames27 Exp $
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

package org.calvaryaustin.controlpanel.locks;

import java.io.IOException;
import java.security.Principal;
import java.util.Locale;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.*;

import org.apache.slide.authenticate.*;
import org.apache.slide.common.*;
import org.apache.slide.lock.*;
import org.apache.slide.structure.*;
import org.apache.struts.action.*;
import org.apache.struts.util.MessageResources;

import org.calvaryaustin.controlpanel.*;

/**
 * Action that will try to kill all locks selected in a given 
 * {@link org.apache.slide.admin.locks.LocksForm LocksForm}.
 *
 * @author <a href="mailto:cmlenz@apache.org">Christopher Lenz</a>
 * @version $Revision: 1.1 $
 */
public final class KillLocksAction extends AdminAction {
    
    
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
        LocksForm locksForm = (LocksForm)form;
        
        // remove the obsolete form bean from the request
        if (mapping.getAttribute() != null) {
            request.removeAttribute(mapping.getAttribute());
        }
        
        ActionErrors errors = new ActionErrors();
        
        String[] locks = locksForm.getLocks();
        if ((nat != null) && (locks.length > 0)){
            
            // get the helpers
            Structure structure = nat.getStructureHelper();
            Lock lock = nat.getLockHelper();
            
            // do the actual transaction
            try {
                try {
                    nat.begin();
                    
                    for (int i = 0; i < locks.length; i++) {
                        SubjectNode subject = 
                            (SubjectNode)structure.retrieve(st, locks[i]);
                        lock.kill(st, subject);
                    }
                    
                    nat.commit();
                    return (mapping.findForward("killLocks.success"));
                    
                } catch (LockTokenNotFoundException e) {
                    // lock token not found
                    // FIXME: more details: which object, which token ?
                    errors.add(
                        ActionErrors.GLOBAL_ERROR,
                        new ActionError("killLocks.error.notFound"));
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
        request.setAttribute("locks", locksForm);
        
        return (mapping.findForward("killLocks.failure"));
    }
    
    
}

