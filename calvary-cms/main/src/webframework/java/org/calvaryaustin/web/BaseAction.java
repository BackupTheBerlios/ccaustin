package org.calvaryaustin.web;

import java.io.IOException;

import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessages;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


/**
 * Provides a base subclass of the Action superclass for the project.
 * This class changes the primary entry method of subclasses from
 * {@link #perform perform()} to {@link #handleRequest handleRequest()}.
 * This enables all arguments, and any future arguments needed by the
 * web framework, to be passed within the UserRequest class. In
 * addition, the UserRequest class has some convienance methods for
 * doing parameter conversion. For example, <code>userRequest.getParameterAsInt("name")</code>.
 * <p>
 * The following variables may be used by subclasses:
 * </p>
 * <pre>
 * log : Reference to a log4j reference created in the constructor
 * </pre>
 * </p><p>
 * Useful methods available to subclasses include:
 * </p><p>
 * <code>buttonPressed( request, buttonName )</code> : determines if a submit
 * button with the name <code>submit</code> with the value
 * <code>buttonName</code> exists in the request, or if an image
 * button with the name <code>buttonName</code> was pressed.
 * </p><p>
 * <code>sucessPage( userRequest, messageKey, forwardUrl )</code> :
 * returns an action forward that calls a generic success page with a
 * given message key (i18n resource via struts) and a link that
 * forwards to the forwardUrl value.
 * </p><p>
 * <code>errorPage( userRequest, messageKey, forwardUrl )</code> :
 * returns an action forward that calls a generic error page with a
 * given message key (i18n resource via struts) and a link that
 * forwards to the forwardUrl value.
 * </p><p>Example Action implementation:
 * <pre>
 *
 *  public class LogonAction extends BaseAction
 *  {
 *
 *   public ActionForward handleRequest( UserRequest request )
 *       throws IOException, ServletException
 *   {
 *     UserSessionContext session = request.getUserSessionContext();
 *     ActionErrors errors = new ActionErrors();
 *     LogonForm loginForm = ( LogonForm ) request.getActionForm();
 *     // doing business logic here
 *     Credential credential = new Credential( loginForm.getUsername(),
 *  				    loginForm.getPassword() );
 *     UserSecurityContext securityContext = request.getUserSecurityContext();
 *     boolean valid = false;
 *     // perform logic here......
 *
 *     // based on result, we determine which page to go to in the
 *     // mapping: success (main page) or failure (self)
 *     if ( valid )
 *     {
 *      // do work here....
 *      return ( request.getMapping().findForward( "success" ) );
 *     }
 *     else
 *     {
 *       errors.add( ActionErrors.GLOBAL_ERROR,
 *                   new ActionError( "logonForm.error.mismatch" ) );
 *       saveErrors( request.getRequest(), errors );
 *       return ( request.getMapping().findForward("failure") );
 *     }
 *  }
 *

 * </pre>
 * </p><p>
 * This class collaborates with the AccessControlServletFilter to
 * ensure that the user security and session context are in their
 * proper locations within the HttpSession and that they are in their
 * proper state.
 * </p>
 * @author jhigginbotham
 * @version $Revision: 1.3 $
 */
abstract public class BaseAction extends Action
{
  /**
   * Default Constructor
   *
   */
  public BaseAction()
  {
    super();
    log = LogFactory.getLog( this.getClass() );
  }


  /**
   * Normal entry in Struts, this method does the appropriate work to
   * call the handleRequest(UserRequest) method. DO NOT OVERRIDE THIS
   * METHOD.
   * @param servlet The ActionServlet making this request
   * @param mapping The ActionMapping used to select this instance
   * @param actionForm The optional ActionForm bean for this request (if any)
   * @param request The HTTP request we are processing
   * @param response The HTTP response we are creating
   *
   * @exception IOException if an input/output error occurs
   * @exception ServletException if a servlet exception occurs
   * @see #handleRequest
   */
  public ActionForward execute(
          ActionMapping mapping, ActionForm form, HttpServletRequest req, HttpServletResponse res )
            throws IOException, ServletException
  {
    log.debug( "perform() invoked" );

    ActionForward forward = null;

    UserRequest request = createUserRequest();
    populateUserRequest(mapping, form, req, res, request);

    log.debug( "invoking subclass handleRequest()" );

    try
    {
      forward = handleRequest( request );
    } catch(Exception e)
    {
      log.debug("Error during handleRequest",e);
    }

    if ( forward != null )
    {
      log.debug( "Calling " + forward.getPath() );
    }

    return forward;
  }

	/**
	 * Fills in a new UserRequest with the values from the current request. Allows
	 * subclasses to override and fill in their custom fields. Subclasses MUST call 
	 * super.populateUserRequest(...) to properly init the request.
     * @param servlet The ActionServlet making this request
     * @param mapping The ActionMapping used to select this instance
     * @param actionForm The optional ActionForm bean for this request (if any)
     * @param request The HTTP request we are processing
     * @param response The HTTP response we are creating
	 * @param request The UserRequest to populate
	 */
	protected void populateUserRequest( ActionMapping mapping,
  									      ActionForm form,
										  HttpServletRequest req,
										  HttpServletResponse res,
										  UserRequest request)
	{
	    //      request.servlet_ = this;
	    request.mapping_ = mapping;
	    request.form_ = form;
	    request.request_ = req;
	    request.response_ = res;
	}


  /**
   * Performs the actual work in place of perform(). Subclasses should
   * override this method and do the actual work.
   * @param request the request to handle
   * @return the action forward reference to the next page
   */
  abstract public ActionForward handleRequest( UserRequest request )
    throws IOException, ServletException;

  /**
   * Returns true if a button or image button was pressed in the
   * current request.
   *
   * @param request The UserRequest to check for the button press
   * @param buttonName the buttonName to check for
   * @return true if the button was pressed
   */
  protected boolean buttonPressed( UserRequest request, String buttonName )
  {
    HttpServletRequest req = request.getRequest();
    // check for the button by name and for an image button with <name>.x
    String value = req.getParameter("submit");
    if(value != null){ return value.equals(buttonName); }
    else if(req.getParameter(buttonName) != null){ return true; }
    // for image buttons, we can't guess the x coord ('buttonName'), so
    // simply look for the name
    else{ return (req.getParameter(buttonName+".x") != null); }
  }

    //---------------------------------------------------
    /**
     *  <code>getDebugRequestString</code> returns the
     *  parameters in the request in a string form
     *
     * @param request an <code>UserRequest</code> value
     * @return a <code>String</code> value
     */
    protected String getDebugRequestString( UserRequest request ) {


	String returnValue = "";
	HttpServletRequest req = request.getRequest();
	Enumeration names = req.getParameterNames();
        for ( ; names.hasMoreElements(); ) {
	    String name = (String) names.nextElement();
	    returnValue+=" name: "+name+" value: "+req.getParameter( name )+"\n";
	}
	return returnValue;
    }
    

  /**
   * Sets a success message key and forwards to the 'success' global
   * forward to display a message to the user
   *
   * @param request The current UserRequest
   * @param messageKey the message key for the user message
   * @return the forward to the success page
   */
  protected ActionForward successPage( UserRequest request,
				       String messageKey,
				       String forwardUrl)
  {
      log.debug( "messageKey: "+messageKey );
      log.debug( "forwardUrl: "+forwardUrl );
      HttpServletRequest req = request.getRequest();
      req.setAttribute( SUCCESS_MESSAGE_KEY, messageKey );
      req.setAttribute( SUCCESS_FORWARD_KEY, forwardUrl );
      return request.getMapping().findForward( SUCCESS_PAGE_KEY );
  }
  protected ActionForward nextPage( UserRequest request,
                       String messageKey,
                       String forwardUrl,
                       String key)
  {
      log.debug( "messageKey: "+messageKey );
      log.debug( "forwardUrl: "+forwardUrl );
      HttpServletRequest req = request.getRequest();
      req.setAttribute( SUCCESS_MESSAGE_KEY, messageKey );
      req.setAttribute( SUCCESS_FORWARD_KEY, forwardUrl );
      return request.getMapping().findForward( key );
  }

  /**
   * Sets a success message key and forwards to the 'success' global
   * forward to display a message to the user
   *
   * @param request The current UserRequest
   * @param messageKey the message key for the user message
   * @return the forward to the success page
   */
  protected ActionForward errorPage( UserRequest request,
				     String messageKey,
				     String forwardUrl)
  {
    HttpServletRequest req = request.getRequest();
    req.setAttribute( ERROR_MESSAGE_KEY, messageKey );
    req.setAttribute( ERROR_FORWARD_KEY, forwardUrl );
    return request.getMapping().findForward( ERROR_PAGE_KEY );
  }

  /**
   * Saves the ErrorList managed by the UserRequest into the request so
   * that that  &lt;html:errors/&gt; tag can display error messages.
   * @see com.betweenmarkets.web.UserRequest#getErrors
   * @param userRequest The action to delegate the saveErrors call to
   */
  protected void saveErrors( UserRequest userRequest )
  {
	saveErrors( userRequest.getRequest(), userRequest.getErrors() );
  }

  /**
   * Saves the ErrorList managed by the UserRequest into the request so
   * that that  &lt;html:errors/&gt; tag can display error messages.
   * @see com.betweenmarkets.web.UserRequest#getErrors
   * @param userRequest The action to delegate the saveErrors call to
   */
  protected void saveErrors( UserRequest userRequest, ActionErrors errors )
  {
	saveErrors( userRequest.getRequest(), errors );
  }

  /**
   * Saves the Message list managed by the UserRequest into the request so
   * that that  &lt;html:messages/&gt; tag can display the messages.
   * @param userRequest The action to delegate the saveMessages call to
   */
  protected void saveMessages( UserRequest userRequest )
  {
	saveMessages( userRequest.getRequest(), userRequest.getMessages() );
  }

  /**
   * Saves the Message list managed by the UserRequest into the request so
   * that that  &lt;html:messages/&gt; tag can display the messages.
   * @param userRequest The action to delegate the saveMessages call to
   * @param messages the messages to save to the request
   */
  protected void saveMessages( UserRequest userRequest, ActionMessages messages )
  {
	saveMessages( userRequest.getRequest(), messages );
  }

  /**
   * Creates a UserRequest - allows for subclasses to return a custom subclass
   * @return a new UserRequest
   */
  protected UserRequest createUserRequest()
  {
      return new UserRequest();
  }

  /** reference to a logger that is setup during construction for this
      and subclasses */
  protected Log log = null;
  static private Log staticlog = LogFactory.getLog( BaseAction.class );

  public final static String SUCCESS_PAGE_KEY = "success";
  public final static String SUCCESS_MESSAGE_KEY = "success.message";
  public final static String SUCCESS_FORWARD_KEY = "success.forward";
  public final static String ERROR_PAGE_KEY = "error";
  public final static String ERROR_MESSAGE_KEY = "error.message";
  public final static String ERROR_FORWARD_KEY = "error.forward";
  public final static String ERROR_HEADER = "errors.header";
  public final static String ERROR_FOOTER = "errors.footer";

}

