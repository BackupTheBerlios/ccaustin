package org.calvaryaustin.web;

import org.apache.struts.validator.ValidatorForm;
import javax.servlet.http.HttpServletRequest;

/**
 * A simple base class for all validating form beans - helps isolate the binding to Struts
 * and provide convienance methods in the future
 *
 * @author jhigginbotham
 * @version $Revision: 1.1 $
 */
public class BaseValidatorForm extends ValidatorForm
{
  protected int getPageNumber(HttpServletRequest request){
    String pageNumberString = request.getParameter(WizardAction.PAGE_KEY);
    try{
        if(pageNumberString != null){ return Integer.parseInt(pageNumberString); }
        else return -1;
    }
    catch(NumberFormatException NFe){ return -1; }
  }
}
