package org.calvaryaustin.web;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessages;
import org.apache.struts.action.ActionServlet;

/**
 * A nice abstraction from the HTTP servlet API with some helper methods.
 * This class contains everything there is to know about a request, its
 * associated UserSession, and associated security context. This enables a single
 * parameter of this class type to be passed around the UI layer, rather
 * than a growing list of parameters as the layer matures.
 * <p>
 * In addition, some extra getParameter() methods are offered for type
 * conversion of request variables not part of a form bean.
 * </p><p>
 * Interesting methods include:
 * </p><p>
 * <code>getMapping()</code> : Returns the struts mapping for looking
 * up forwards and attribute names of form beans assoc with the mapping
 * </p><p>
 * <code>getActionForm()</code> : Returns the struts action form for
 * the request - may be null if the action does not define a form bean
 * up forwards
 * </p>
 * @see org.calvaryaustin.web.BaseAction
 * @author jhigginbotham
 * @version $Revision: 1.2 $
 */
public class UserRequest implements java.io.Serializable
{
  /**
   * Returns the value of the parameter from the current request as a
   * String.
   * @param name the name of the parameter to find
   * @return parameter value, or null if not found
   */
  public String getParameter( String name )
  {
    return getParameter( name, null );
  }


  /**
   * Returns the value of the parameter from the current request as a
   * String.
   * @param name the name of the parameter to find
   * @return parameter value, or defaultValue if not found
   */
  public String getParameter( String name, String defaultValue )
  {
    String value = request_.getParameter( name );

    if ( value == null )
    {
      value = defaultValue;
    }

    return value;
  }


  /**
   * Returns the value of the parameter from the current request as an
   * int.
   * @param name the name of the parameter to find
   * @return parameter value, or defaultValue if not found
   */
  public int getParameterAsInt( String name, int defaultValue )
  {
    String value = getParameter( name, null );

    if ( value != null )
    {
      try
      {
        return Integer.parseInt( value );
      }
      catch ( NumberFormatException ex )
      {
      }
    }

    return defaultValue;
  }


  /**
   * Returns the value of the parameter from the current request as a
   * long.
   * @param name the name of the parameter to find
   * @return parameter value, or defaultValue if not found
   */
  public long getParameterAsLong( String name, long defaultValue )
  {
    String value = getParameter( name, null );

    if ( value != null )
    {
      try
      {
        return Long.parseLong( value );
      }
      catch ( NumberFormatException ex )
      {
      }
    }

    return defaultValue;
  }


  /**
   * Returns the value of the parameter from the current request as a
   * boolean.
   * @param name the name of the parameter to find
   * @return parameter value, or defaultValue if not found
   */
  public boolean getParameterAsBoolean( String name, boolean defaultValue )
  {
    boolean result = defaultValue;
    String bool = getParameter( name, null );

    if ( bool != null )
    {
      result = ( bool.equalsIgnoreCase( "true" )
                 || bool.equalsIgnoreCase( "t" )
                 || bool.equalsIgnoreCase( "yes" )
                 || bool.equalsIgnoreCase( "y" ) );

      if ( !result )
      {
        result = defaultValue;
      }
    }

    return result;
  }


  /**
   * Returns the values of the parameter from the current request as a
   * String.
   * @param name the name of the parameter to find
   * @return parameter value, or an empty array if not found
   */
  public String[] getParameterValues( String name )
  {
    String[] values = request_.getParameterValues( name );

    if ( values == null )
    {
      values = new String [ 0 ];
    }

    return values;
  }


  /**
   * Returns an enumeration to a list of parameter names in the request.
   * This should be changed to Interator, but uses enumeration due to
   * the Servlet API usage.
   * @return Enumeration containing the list of parameter names (keys) in the
   * request
   */
  public Enumeration getParameterNames()
  {
    return request_.getParameterNames();
  }

  /**
   * Return the Struts action mapping for this request's action (from mapping.xml)
   * @return the action mapping
   */
  public ActionMapping getMapping()
  {
    return mapping_;
  }


  /**
   * Returns the action servlet that handled this request
   * @return the action servlet that handled this request
   */
  public ActionServlet getActionServlet()
  {
    return servlet_;
  }


  /**
   * Return the http request for this user request
   * @return the http request
   */
  public HttpServletRequest getRequest()
  {
    return request_;
  }


  /**
   * Return the http response for this user request
   * @return the http response
   */
  public HttpServletResponse getResponse()
  {
    return response_;
  }

  /**
   * Returns the ActionForm JavaBean for this action
   * @return the action form
   */
  public ActionForm getActionForm()
  {
    return form_;
  }

  /**
   * Returns an instance of ActionErrors that can be shared only for
   * the term of the current request. This enables the errors to
   * accumulate across our action logic without having to pass around
   * a reference to the ActionErrors we will later save into the
   * request using saveErrors()
   *
   * @return an <code>ActionErrors</code> to use for the current request
   */
  public ActionErrors getErrors()
  {
	if(actionErrors_ == null)
	{
	  actionErrors_ = new ActionErrors();
	}
	return actionErrors_;
  }

  /**
   * Returns an instance of ActionMessages that can be shared only for
   * the term of the current request. This enables the messages to
   * accumulate across our action logic without having to pass around
   * a reference to the ActionMessages we will later save into the
   * request using saveMessages()
   *
   * @return an <code>ActionMessages</code> to use for the current request
   */
  public ActionMessages getMessages()
  {
	if(actionMessages_ == null)
	{
		actionMessages_ = new ActionMessages();
	}
	return actionMessages_;
  }

  /**
   * Sets an attribute in the REQUEST SCOPE with the given key and
   * value 
   *
   * @param key The key
   * @param attrib the object to save
   */
  public void setRequestAttribute( String key, Object attrib )
  {
    request_.setAttribute( key, attrib );
  }
  
  /**
   * Returns an attribute in the REQUEST SCOPE with the given key
   *
   * @param key the key to locate the attribute
   * @return the located attribute, or null if not found
   */
  public Object getRequestAttribute( String key )
  {
    return request_.getAttribute( key );
  }

  /**
   * Removes the attribute for the request with the given name
   * @param name the name
   */
  public void removeRequestAttribute( String name )
  {
    request_.removeAttribute( name );
  }
  
  //  Ok, so I've done the work in case we need it, but we should be
  //  using the UserSessionContext instead....  I put this here so that
  //  the API will be certainly defined
  
  /**
   * Sets an attribute in the SESSION SCOPE with the given key and
   * value 
   *
   * @param key The key
   * @param attrib the object to save
   */
  public void setSessionAttribute( String key, Object attrib )
  {
    request_.getSession().setAttribute( key, attrib );
  }
  
  /**
   * Returns an attribute in the SESSION SCOPE with the given key
   *
   * @param key the key to locate the attribute
   * @return the located attribute, or null if not found
   */
  public Object getSessionAttribute( String key )
  {
    return request_.getSession().getAttribute( key );
  }

  /**
   * Removes the attribute in the APPLICATION scope with the given key
   * @param key the key
   */
  public void removeSessionAttribute( String key )
  {
    request_.getSession().removeAttribute( key );
  }
  
  /**
   * Removes the action form that is in the session scope - usually called after a wizard is complete
   * @param key the key
   */
  public void removeActionFormFromSession()
  {
    System.out.println("attribute is:"+mapping_.getAttribute());
    removeSessionAttribute(mapping_.getAttribute());
  }
  
  /**
   * Sets an attribute in the APPLICATION SCOPE with the given key and
   * value 
   *
   * @param key The key
   * @param attrib the object to save
   */
  public void setApplicationAttribute( String key, Object attrib )
  {
    servlet_.getServletContext().setAttribute( key, attrib );
  }
  
  /**
   * Returns an attribute in the APPLICATION SCOPE with the given key
   *
   * @param key the key to locate the attribute
   * @return the located attribute, or null if not found
   */
  public Object getApplicationAttribute( String key )
  {
    return servlet_.getServletContext().getAttribute( key ); 
  }

  /**
   * Removes the attribute in the APPLICATION scope with the given key
   * @param key the key
   */
  public void removeApplicationAttribute( String key )
  {
    servlet_.getServletContext().removeAttribute( key );
  }
  
  /** The servlet that handled the request */
  protected ActionServlet servlet_;
  /** The mapping for the specific action from the mapping.xml file */
  protected ActionMapping mapping_;
  /** The Javabean filled up by Struts, as specified in the mapping file */
  protected ActionForm form_;
  /** The HTTP request */
  protected HttpServletRequest request_;
  /** The HTTP response */
  protected HttpServletResponse response_;
  /** A general ActionErrors that can be shared for the given request **/
  protected ActionErrors actionErrors_;
  /** A general ActionMessages that can be shared for the given request **/
  protected ActionMessages actionMessages_;
}
