package org.calvaryaustin.controlpanel.editor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionMapping;
import org.calvaryaustin.controlpanel.ResourceContentForm;

/**
 * Generates the appropriate HTML for linking to the editor to edit a specific content resource
 * @author jhigginbotham
 */
public class EditorButtonTag extends TagSupport
{

    public int doStartTag() throws JspException
    {
        ActionMapping mapping = (ActionMapping)pageContext.getRequest().getAttribute(Globals.MAPPING_KEY);
        ResourceContentForm form = (ResourceContentForm)pageContext.getRequest().getAttribute( mapping.getAttribute() );
        if(form == null)
        {
            throw new JspException("FormBean was not found under name "+mapping.getAttribute());
        }
		
        try 
        {
            String contextPath = ((HttpServletRequest)pageContext.getRequest()).getContextPath();
            pageContext.getOut().print("<a href='"+contextPath+"/editor.do?"+
                "site="+form.getSite()+
                "&path="+form.getPath()+
                "&file="+form.getFile()+
                "'>");
        } catch (java.io.IOException e)
        {
            throw new JspException("Error during I/O",e);
        }
		
        return EVAL_PAGE;
    }

    public int doEndTag() throws JspException
    {
        try 
        {
            pageContext.getOut().println("</a>");
        } catch (java.io.IOException e)
        {
            throw new JspException("Error during I/O",e);
        }
		
        return EVAL_PAGE;
    }
}