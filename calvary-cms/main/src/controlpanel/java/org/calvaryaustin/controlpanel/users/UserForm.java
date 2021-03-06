/*
 * $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/ccaustin/Repository/calvary-cms/main/src/controlpanel/java/org/calvaryaustin/controlpanel/users/UserForm.java,v 1.1 2003/02/12 22:06:57 javajames27 Exp $
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

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * Form class containing information about a user in the namespace.
 * 
 * @author <a href="mailto:cmlenz@apache.org">Christopher Lenz</a>
 * @version $Revision: 1.1 $
 */
public final class UserForm extends ActionForm {
    
    
    // ----------------------------------------------------- Instance Variables
    
    
    /**
     * Whether the user should have root access.
     **/
    private boolean hasRootRole;
    
    
    /**
     * The original URI of the user node.
     **/
    private String originalUri;
    
    
    /**
     * The password.
     **/
    private String password;
    
    
    /**
     * The username.
     **/
    private String username;
    
    
    // ------------------------------------------------------------- Properties
    
    
    /**
     * Return whether the user should have root access.
     **/
    public boolean getHasRootRole() {
        
        return hasRootRole;
    }
    
    
    /**
     * Set whether the user should have root access.
     *
     * @param hasRootRole whether the user should have root access
     **/
    public void setHasRootRole(boolean hasRootRole) {
        
        this.hasRootRole = hasRootRole;
    }
    
    
    /**
     * Return the original URI of the user node.
     **/
    public String getOriginalUri() {
        
        return originalUri;
    }
    
    
    /**
     * Sets the original URI of the user node.
     **/
    public void setOriginalUri(String originalUri) {
        
        this.originalUri = originalUri;
    }
    
    
    /**
     * Return the password.
     **/
    public String getPassword() {
        
        return password;
    }
    
    
    /**
     * Set the password.
     *
     * @param password The new password
     **/
    public void setPassword(String password) {
        
        this.password = password;
    }
    
    
    /**
     * Return the username.
     **/
    public String getUsername() {
        
        return username;
    }
    
    
    /**
     * Set the username.
     *
     * @param username The new username
     **/
    public void setUsername(String username) {
        
        this.username = username;
    }
    
    
    // --------------------------------------------------------- Public Methods
    
    
    /**
     * Reset all properties to their default values.
     *
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     **/
    public void reset(ActionMapping mapping, 
                      HttpServletRequest request) {
        
        hasRootRole = false;
        originalUri = null;
        password = null;
        username = null;
    }
    
    
    /**
     * Validate the properties that have been set from this HTTP request,
     * and return an <code>ActionErrors</code> object that encapsulates any
     * validation errors that have been found.  If no errors are found, return
     * <code>null</code> or an <code>ActionErrors</code> object with no
     * recorded error messages.
     *
     * @param mapping The mapping used to select this instance
     * @param request The servlet request we are processing
     **/
    public ActionErrors validate(ActionMapping mapping, 
                                 HttpServletRequest request) {
        
        ActionErrors errors = new ActionErrors();
        
        // TODO: check if the name's a valid URI
        if ((username == null) || (username.length() < 1)) {
            errors.add("username",
                       new ActionError("userForm.error.usernameRequired"));
        }
        
        if ((password == null) || (password.length() < 1)) {
            errors.add("password",
                       new ActionError("userForm.error.passwordRequired"));
        }
        
        return errors;
    }
    
    
}

