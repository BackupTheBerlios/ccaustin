package org.calvaryaustin.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForward;

/**
 * A base action that specializes in looking for Next, Back, Cancel,
 * and Create button presses and takes the proper actions.
 * <p>
 * To create a wizard, perform the following steps:</p><pre>
 *
 * 1. Subclass WizardAction and implement {@link #processCreate processCreate()} 
 * and {@link #processCancel processCancel()} for handling the Create
 * and Cancel button logic.
 *
 * 1b. Overide {@link #processUnknownButton processUnknownButton()} if there are additional buttons
 * beyond the standard set
 *
 * 2. [NEW WAY] Create a wizard entry in the <code>struts-config.xml</code> that map to your wizard:
 * <PRE>
 * &lt;action path="/createTC" 
 *         type="com.betweenmarkets.transactionmanager.web.actions.constraints.NewTechnicalConstraintAction" 
 *         name="technicalConstraintForm" 
 *         scope="request" 
 *         input="wizard"&gt; 
 *   &lt;forward name="page1" path="/tcm/createTC.jsp"/&gt;
 *   &lt;forward name="page2" path="/tcm/createTC_2.jsp"/&gt;
 *   &lt;forward name="cancel" path="/tcm/tcm.jsp"/&gt;
 * &lt;/action&gt;
 * </PRE>
 * 
 * Note: Notice the input="wizard" - this is required to trigger our custom Struts request processor
 * to return the user to the proper page if a validation error occurs.
 *
 * 2. [OLD WAY] Create entries for each step in the
 * <code>struts-config.xml</code> that all map to the same action:
 *
 * &lt;action path="/createTC" 
 *         type="com.betweenmarkets.transactionmanager.web.actions.constraints.NewTechnicalConstraintAction" 
 *         name="technicalConstraintForm" 
 *         scope="request" 
 *         input="/tcm/createTC.jsp"&gt;
 *   &lt;forward name="page1" path="/tcm/createTC.jsp"/&gt;
 *   &lt;forward name="page2" path="/tcm/createTC_2.jsp"/&gt;
 *   &lt;forward name="cancel" path="/tcm/tcm.jsp"/&gt;
 * &lt;/action>
 * &lt;action path="/createTC2" 
 *         type="com.betweenmarkets.transactionmanager.web.actions.constraints.NewTechnicalConstraintAction" 
 *         name="technicalConstraintForm" 
 *         scope="request" 
 *         input="/tcm/createTC_2.jsp"&gt;
 *   &lt;forward name="page1" path="/tcm/createTC.jsp"/&gt;
 *   &lt;forward name="page2" path="/tcm/createTC_2.jsp"/&gt;
 *   &lt;forward name="cancel" path="/tcm/tcm.jsp"/&gt;
 * &lt;/action&gt;
 *
 * NOTE: /createTC maps to page1 of the wizard, /createTC2 maps to
 * page2 of the wizard. These duplicate entries with the same action
 * class enables the validation logic to redirect to the correct page
 * should a validation error occur. When validation errors occur, the
 * struts framework uses the input attribute of the action mapping to
 * determine which page to redirect to. Thus, we have to have page 1
 * POST to /createTC2.bmi so that if an error occurs on page 2 it will
 * refresh page 2 rather than showing page 1. Struts produces
 * singletons of the actions on a per classname level, so the 2
 * entries of the same classname are shared and thus conserve memory.
 *
 * We can reevaluate this wizard with other struts workflow extensions
 * in the future.
 *
 * 3. Place forward entries for the actions in the
 * <code>struts-config.xml</code> with the naming convention page1,
 * page2, etc. as shown above. 
 * 
 * 4. Insert the following tags in your JSP where appropriate:
 *
 * &lt;bmi:wizardBack/&gt;
 * &lt;bmi:wizardNext/&gt;
 * &lt;bmi:wizardCancel/&gt;
 * &lt;bmi:wizardCreate/&gt;
 *
 * Note:  disabled="true" and img="../images/create.gif" are optional
 * arguments to the tags. See the tags for more information.
 *
 * 5. Insert the following custom BMI tag to insert the proper page
 * number into the JSP as a hidden field within the form. For best
 * results, place on the next line after the <html:form> tag:
 *
 * &lt;bmi:pagenumber/&gt;
 *
 * 6. Place the proper validation entries in the validation.xml file
 * with page numbers next to fields corresponding to the page number
 * the fields belong to:
 *
 * &lt;field property="tradingProfile"
 *        depends="required"
 *        page="2"&gt;
 *        &lt;arg0 key="createTC.tradingprofile.displayname"/&gt;
 * &lt;/field&gt;    
 *
 * </pre>
 * @author jhigginbotham
 * @version $Revision: 1.1 $
 */
abstract public class WizardAction extends BaseAction
{
  /**
   * Process the request by first looking for a next or back button
   * press. If not found, then try to locate create, save, cancel
   *
   * @param request the UserRequest being processed
   * @return an <code>ActionForward</code> containing the new page to
   * go to
   * @exception IOException if an error occurs
   * @exception ServletException if an error occurs
   */
  public ActionForward handleRequest( UserRequest request )
      throws IOException, ServletException
  {
    int pageNumber = request.getParameterAsInt( PAGE_KEY, 1 );
    ActionErrors errors = new ActionErrors();
    /*
    java.util.Enumeration enum = request.getParameterNames();
    while(enum.hasMoreElements()){
      String key = (String)enum.nextElement();
      String[] paramValues = request.getParameterValues(key);
      log.debug("request params");
      for(int i=0;i < paramValues.length;i++){
          log.debug(key + " : "  + paramValues[i]);
      }
    }  
    */  
    if( buttonPressed( request, BUTTON_NEXT ) )
    {
      log.debug("Processing next button");
      if (validatePage( request, pageNumber, BUTTON_NEXT ) )
      {
        log.debug("Showing next page");
        onBeforeDisplayEvent( request, pageNumber, BUTTON_NEXT );
        return nextPage( request );
      }
      else
      {
        log.debug("Showing current page");
        saveErrors(request);
        return currentPage( request );
      }
    }
    else if (buttonPressed( request, BUTTON_BACK ) )
    {
      log.debug("Processing back button");
      if( validatePage( request, pageNumber, BUTTON_BACK ) )
      {
        log.debug("Showing previous page");
        onBeforeDisplayEvent( request, pageNumber, BUTTON_BACK );
        return previousPage( request );
      }
      else
      {
        log.debug("Showing current page");
        saveErrors(request);
        return currentPage( request );
      }
          
    }
    else if (buttonPressed( request, BUTTON_CREATE ) )
    {
      log.debug("Processing create button");
      if( validatePage( request, pageNumber, BUTTON_CREATE ) )
      {
        log.debug("Processing create button");
        return processCreate( request );
      }
      else
      {
        log.debug("Showing current page");
        saveErrors(request);
        return currentPage( request );
      }
    }
    else if (buttonPressed( request, BUTTON_CANCEL ) )
    {
      log.debug("Processing cancel button");
      return processCancel( request );
    }
    else
    {
      log.debug("Processing unknown button");
      return processUnknownButton( request );
    }
  }

  /**
   * Method called just before navigating to a new page (next, prev,
   * unknown button) to allow for the retrieval of special data
   *
   * @param request the current UserRequest
   * @param pageNumber the page number that is to be shown
   * @param buttonPressed the button name that was pressed by the user
   */
  protected void onBeforeDisplayEvent( UserRequest request,
                                       int pageNumber,
                                       String buttonPressed )
  {
    // default noop
  }
  
  /**
   * Method called just before processing the next, back, and create buttons to
   * allow for application-specific validation (beyond the Struts
   * field-level validation logic).
   * <p>
   * NOTE: Be sure to do proper condition checking if you don't want
   * the validation logic to be performed on a back button. It is
   * called when a back button is pressed for flexibility, but
   * normally this is an undesired effect.
   * </p>
   * @param request the current UserRequest
   * @param pageNumber the page number that is being processed (sent
   * in on the request)
   * @param buttonPressed the button name that was pressed by the user
   * @param errors an errors bundle that can allow errors to be added
   * and automatically saved into the request if the return
   * value is false, meaning an error occurred.
   * @return true if the button action should be processed (next,
   * back), false if the current page should be returned to again
   */
  protected boolean validatePage( UserRequest request,
                                  int pageNumber,
                                  String buttonPressed)
      throws IOException, ServletException
  {
    // default noop
    return true;
  }

  /**
   * Tries to locate a forward mapping to a string in the format
   * 'pageX' where X is the incremented value of the PAGE_KEY parameter
   * found in the request. If the PAGE_KEY value is not found, the
   * default is to locate 'page1'.
   *
   * @param request the UserRequest to check for the page variable
   * @return a forward to the next page, defaulting to 'page1' if the
   * page number is not found in the request.
   */
  protected ActionForward nextPage( UserRequest request )
  {
    int pageNumber = request.getParameterAsInt( PAGE_KEY, 0 );
    HttpServletRequest req = request.getRequest();
    req.setAttribute( PAGE_KEY, ""+ ++pageNumber );
    return request.getMapping().findForward( PAGE_KEY + pageNumber );
  }
  
  /**
   * Displays the current page, defaulting to 1 if the PAGE_KEY
   * variable is not in the current request
   * @param request the UserRequest to check for the page variable
   * @return a forward to the next page, defaulting to 'page1' if the
   * page number is not found in the request.
   */
  protected ActionForward currentPage( UserRequest request )
  {
    int pageNumber = request.getParameterAsInt( PAGE_KEY, 1 );
    HttpServletRequest req = request.getRequest();
    req.setAttribute( PAGE_KEY, "" + pageNumber );
    return request.getMapping().findForward( PAGE_KEY + pageNumber );
  }
  
  /**
   * Tries to locate a forward mapping to a string in the format
   * 'pageX' where X is the decremented value of the PAGE_KEY parameter
   * found in the request. If the PAGE_KEY value is not found, the
   * default is to locate 'page1'.
   *
   * @param request the UserRequest to check for the page variable
   * @return a forward to the previous page, defaulting to 'page1' if the
   * page number is not found in the request.
   */
  protected ActionForward previousPage( UserRequest request )
  {
    int pageNumber = request.getParameterAsInt( PAGE_KEY, 2 );
    HttpServletRequest req = request.getRequest();
    req.setAttribute( PAGE_KEY, ""+ --pageNumber );
    return request.getMapping().findForward( PAGE_KEY + pageNumber );
  }
  
 
  /**
   * Processes a create button press and forwards to the success page
   * unless an error occurs
   *
   * @param request the request being processed
   * @return the ActionForward of the success or failure page 
   */
  abstract protected ActionForward processCreate( UserRequest request )
      throws IOException, ServletException;
  /**   
   * Processes a cancel button press and forwards to the main page
   *
   * @param request the request being processed
   * @return the ActionForward of the success or failure page 
   */
  abstract protected ActionForward processCancel( UserRequest request )
      throws IOException, ServletException;

  /**
   * Provides subclasses with a hook for the checking of custom button
   * presses. The subclass should call {@link #onBeforeDisplayEvent onBeforeDisplayEvent()}
   * with the current page number, the button constant pressed, and
   * the request to ensure the pre-display logic can be processed.
   * <p>
   * The default logic is to show the first page in the wizard
   * @param request the UserRequest to check for the page variable
   * @return a forward to the next page based on the button pressed
   */
  protected ActionForward processUnknownButton( UserRequest request )
  {
    int pageNumber = request.getParameterAsInt( PAGE_KEY, 0 );
    log.debug("*unknown* button - refreshing page by default: "+request.getMapping().getInput());
    onBeforeDisplayEvent( request, pageNumber, BUTTON_UNKNOWN );
    return currentPage( request );
  }

  public static final String BUTTON_NEXT = "Next";
  public static final String BUTTON_BACK = "Back";
  public static final String BUTTON_CANCEL = "Cancel";
  public static final String BUTTON_CREATE = "Create";
  public static final String BUTTON_UNKNOWN = "N/A";
  public static final String PAGE_KEY = "page";
}







