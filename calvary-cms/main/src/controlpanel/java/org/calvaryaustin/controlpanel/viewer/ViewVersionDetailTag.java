package org.calvaryaustin.controlpanel.viewer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionMapping;
import org.calvaryaustin.controlpanel.ResourceContentForm;
import org.calvaryaustin.controlpanel.ResourceForm;

/**
 * @author jhigginbotham
 */
public class ViewVersionDetailTag extends TagSupport
{

    public int doEndTag() throws JspException
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
            pageContext.getOut().print("<a href='"+contextPath+"/viewer.do?"+
            	"site="+form.getSite()+            	"&path="+form.getPath()+
				"&file="+form.getFile()+
				"&rev="+getRevisionNumber()+
				"&branch="+getRevisionBranch()+
				"'>");
            pageContext.getOut().println("View</a>");
        } catch (java.io.IOException e)
        {
            throw new JspException("Error during I/O",e);
        }
		
        return EVAL_PAGE;
    }

    public int doStartTag() throws JspException
    {
        return EVAL_PAGE;
    }

    /**
     * @return String
     */
    public String getRevisionBranch()
    {
        return revisionBranch;
    }

    /**
     * @return String
     */
    public String getRevisionNumber()
    {
        return revisionNumber;
    }

    /**
     * Sets the revisionBranch.
     * @param revisionBranch The revisionBranch to set
     */
    public void setRevisionBranch(String revisionBranch)
    {
        this.revisionBranch = revisionBranch;
    }

    /**
     * Sets the revisionNumber.
     * @param revisionNumber The revisionNumber to set
     */
    public void setRevisionNumber(String revisionNumber)
    {
        this.revisionNumber = revisionNumber;
    }

    private String revisionNumber;
    private String revisionBranch;

}