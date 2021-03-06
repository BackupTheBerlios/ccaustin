package org.calvaryaustin.controlpanel.browser;

import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionMapping;
import org.calvaryaustin.controlpanel.ResourceForm;

/**
 * A tag that uses the form bean for the current action and renders a navigator (breadcrumbs)
 * for the user to move backward from the current path 
 * @author jhigginbotham
 */
public class BrowserBreadcrumbTag extends TagSupport
{
    
	public int doEndTag() throws JspException
	{
		ActionMapping mapping = (ActionMapping)pageContext.getRequest().getAttribute(Globals.MAPPING_KEY);
        ResourceForm form = (ResourceForm)pageContext.getRequest().getAttribute( mapping.getAttribute() );
		
		try 
		{
			String contextPath = ((HttpServletRequest)pageContext.getRequest()).getContextPath();
			pageContext.getOut().println("<div class='browserBreadcrumbs'>");
			if(form.getSite() == null)
			{
				// we are browsing all sites, so no need to do more than this
				pageContext.getOut().println("sites");
				return EVAL_PAGE; 
			}
			pageContext.getOut().println("<a href='"+contextPath+"/browser.do'>sites</a> : ");
			pageContext.getOut().println("<a href='"+contextPath+"/browser.do?site="+
			  form.getSite()+"&path=/'>"+form.getSite()+"</a>");
			pageContext.getOut().println(" : ");
			//pageContext.getOut().println(link);
			//pageContext.getOut().println(" / ");
			String currentPath = "";
            // tokenize the path, and for each part of the path show a link for that portion
            boolean browsingContent = !form.isCollection();
			StringTokenizer st = new StringTokenizer(form.getPath(),"/");
			while(st.hasMoreTokens())
			{
				String segment = st.nextToken();
				if(st.hasMoreTokens() || browsingContent)
				{
					currentPath += "/" + segment;
					pageContext.getOut().println("<a href='"+contextPath+"/browser.do?site="+form.getSite()+
						"&path="+currentPath+"'>"+segment+"</a>");
	  				pageContext.getOut().println(" / ");
				}
				else
				{
                   // we are on the last element, so don't make a link, its redundant
                   pageContext.getOut().println(segment);
				}
				
			}
			if( browsingContent )
			{
                //pageContext.getOut().println(" : ");
                pageContext.getOut().println("<a href='"+contextPath+"/viewer.do?site="+form.getSite()+
                    "&path="+form.getPath()+"&file="+form.getName()+"'>"+form.getName()+"</a>");
			}
            pageContext.getOut().println("");
			pageContext.getOut().println("</div>");
		} catch (java.io.IOException e)
		{
			throw new JspException("Error during I/O",e);
		}
		
		return EVAL_PAGE;
	}

}
