package org.calvaryaustin.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.RequestProcessor;
import org.apache.struts.config.ForwardConfig;
import org.apache.struts.action.ActionForward;
import org.apache.struts.Globals;
import org.apache.struts.taglib.html.Constants;



/**
 * A custom request processor for Struts that is aware of the WizardAction and does some fancy struts
 * mapping when validation fails in the middle of the wizard, to ensure we get back to the right
 * page where the error occurred.
 *
 * @author jhigginbotham
 * @version $Revision: 1.1 $
 */
public class WizardRequestProcessor extends RequestProcessor
{
  public static final String WIZARD_INPUT_VALUE = "wizard";
  
  /**
   * Overloading this method to do some fancy footwork
   */
  protected boolean processValidate(HttpServletRequest request,
                                    HttpServletResponse response,
                                    ActionForm form,
                                    ActionMapping mapping)
      throws IOException, ServletException {

    if (form == null) {
      return (true);
    }

    // Was this submit cancelled?
    if ((request.getParameter(Constants.CANCEL_PROPERTY) != null) ||
        (request.getParameter(Constants.CANCEL_PROPERTY_X) != null)) {
      if (log.isDebugEnabled()) {
        log.debug(" Cancelled transaction, skipping validation");
      }
      return (true);
    }

    // Has validation been turned off for this mapping?
    if (!mapping.getValidate()) {
      return (true);
    }

    // Call the form bean's validation method
    if (log.isDebugEnabled()) {
      log.debug(" Validating input form properties");
    }
    ActionErrors errors = form.validate(mapping, request);
    if ((errors == null) || errors.isEmpty()) {
      if (log.isTraceEnabled()) {
        log.trace("  No errors detected, accepting input");
      }
      return (true);
    }

    // Special handling for multipart request
    if (form.getMultipartRequestHandler() != null) {
      if (log.isTraceEnabled()) {
        log.trace("  Rolling back multipart request");
      }
      form.getMultipartRequestHandler().rollback();
    }

    // Has an input form been specified for this mapping?

    String input = mapping.getInput();
    if (input == null) {
      if (log.isTraceEnabled()) {
        log.trace("  Validation failed but no input form available");
      }
      response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                         getInternal().getMessage("noInput",
                                                  mapping.getPath()));
      return (false);
    }

    // JWH: Here is where our magic comes in....
    if ( input.equals( WIZARD_INPUT_VALUE ) )
    {
      // so, we want to find the right page for where we currently are and return the user
      // there.. here we go..
      int pageNumber = getParameterAsInt( request, WizardAction.PAGE_KEY, 0 );
      if ( pageNumber == 0 )
      {
        if (log.isDebugEnabled()) {
          log.debug(" Wizard was detected but no page number specified. Assuming the start of a wizard and bypassing validation.");
        }
        return (true); // no specific page number, so we must be on the first page of the
                       // wizard.. just say its ok for now.. 
      } // end of if ()
      if (log.isDebugEnabled()) {
        log.debug(" Validation failed, found wizard page of '" + pageNumber + "'");
      }
      
      ActionForward currentPage = mapping.findForward( WizardAction.PAGE_KEY + pageNumber );
      if ( currentPage == null )
      {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                           getInternal().getMessage("noInput",
                                                    WizardAction.PAGE_KEY + pageNumber));
        return (false);
      } // end of if ()
      else
      {
        input = currentPage.getPath();
        request.setAttribute( WizardAction.PAGE_KEY, ""+ pageNumber );        
      } // end of else
      
    } // end of if ()
    

    // Save our error messages and return to the input form if possible
    if (log.isDebugEnabled()) {
      log.debug(" Validation failed, returning to '" + input + "'");
    }
    request.setAttribute(Globals.ERROR_KEY, errors);

    if (moduleConfig.getControllerConfig().getInputForward()) {
      ForwardConfig forward = mapping.findForward(input);
      processForwardConfig( request, response, forward);
    } else {
      internalModuleRelativeForward(input, request, response);
    }

    return (false);

  }

  private int getParameterAsInt( HttpServletRequest req, String name, int defaultValue )
  {
    String value = req.getParameter( name );

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
}
