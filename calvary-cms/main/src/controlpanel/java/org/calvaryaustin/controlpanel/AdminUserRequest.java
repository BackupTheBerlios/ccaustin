package org.calvaryaustin.controlpanel;

import org.apache.slide.common.NamespaceAccessToken;
import org.apache.slide.common.SlideToken;
import org.calvaryaustin.web.UserRequest;

/**
 * Custom UserRequest for AdminRequests that need to perform Slide-specific work
 * @author jhigginbotham
 */
public class AdminUserRequest extends UserRequest
{
    /**
     * Returns the Slide NAT for getting access to the rest of the APIs
     * @return the Slide NAT for getting access to the rest of the APIs
     */
    public NamespaceAccessToken getNamespaceAccessToken()
    {
        return namespace;
    }
    
    /**
     * Returns the SlideToken that represents the user's security access 
     * for the rest of the APIs
     * @return the SlideToken that represents the user's security access 
     * for the rest of the APIs
     */
    public SlideToken getSecurityToken()
    {
        return security; 
    }
    
    NamespaceAccessToken namespace;
    SlideToken security;
}
