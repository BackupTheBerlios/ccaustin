package org.calvaryaustin.web.validation;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.Serializable;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.validator.Field;
import org.apache.commons.validator.ValidatorAction;
import org.apache.commons.validator.ValidatorUtil;
import org.apache.struts.validator.Resources;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

/**
 * 
 * @author jhigginbotham
 */
public class XMLChecks implements Serializable
{
	public static boolean validateWellFormed(Object bean,
											 ValidatorAction va, 
											 Field field,
											 ActionErrors errors,
											 HttpServletRequest request)
	{
		log.debug("validateWellFormed(): entered");
		// get the field's value
		String xmlDoc = null;
		if (isString(bean)) 
		{
			xmlDoc = (String) bean;
		} 
		else 
		{
			xmlDoc = ValidatorUtil.getValueAsString(bean, field.getProperty());
		}
		
		// first, make sure we are actually dealing with XML here
		
		// TODO: May want to make this a validation requirement to check some field in the 
		// form bean first before hitting this validation step
		if(!xmlDoc.trim().startsWith(XML_PREFIX) )
		{
			log.debug("validateWellFormed(): not an xml doc. done.");
			return true;
		}
		
		// now, parse the XML to be sure we have a well-formed doc
		try 
		{
			log.debug("validateWellFormed(): parsing");
			XMLReader parser = XMLReaderFactory.createXMLReader();
			ByteArrayInputStream bin = new ByteArrayInputStream( xmlDoc.getBytes() );
			InputSource is = new InputSource( bin );
			parser.parse( is );
		} catch( SAXParseException e )
		{
			log.debug("validateWellFormed(): caught and processing",e);
			// typical error - save the exception and add the action error	
			ActionError error = Resources.getActionError(request, va, field);
			ActionError formattedError = new ActionError( error.getKey(), error.getValues()[0], e.getMessage(),e.getLineNumber()+"", e.getColumnNumber()+"");		
			errors.add(field.getKey(), formattedError );
			return false;
		} catch( SAXException e )
		{
			log.debug("validateWellFormed(): caught and processing",e);
			errors.add(field.getKey(), Resources.getActionError(request, va, field));
			return false;
		} catch( IOException e )
		{
			log.debug("validateWellFormed(): caught and processing",e);
			errors.add(field.getKey(), Resources.getActionError(request, va, field));
			return false;
		}
		
		return true;
	}
	
	private static boolean isString(Object o) 
	{
	
	  if (o == null) 
	  {
		return (true);
	  }
	  return (String.class.isInstance(o));
	}
	
	private static final String XML_PREFIX = "<?xml";
	private static final Log log = LogFactory.getLog(XMLChecks.class);
}
