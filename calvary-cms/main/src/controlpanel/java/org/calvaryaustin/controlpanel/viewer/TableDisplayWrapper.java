package org.calvaryaustin.controlpanel.viewer;

import javax.servlet.http.HttpServletRequest;

import org.apache.slide.taglib.bean.LockBean;
import org.apache.slide.taglib.bean.NodeBean;
import org.apache.slide.taglib.bean.PropertyBean;
import org.apache.slide.taglib.bean.RevisionBean;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionMapping;
import org.apache.taglibs.display.TableDecorator;

/**
 * A TableDecorator for the display:* taglib
 * @author jhigginbotham
 */
public class TableDisplayWrapper extends TableDecorator
{
    /**
     * Returns a better display string for the type of lock held
     * @return a better display string for the type of lock held
     */
    public String getLockType()
    {
        LockBean lock = (LockBean)this.getObject();
        if( lock.getIsExclusive())
        {
            return "Exclusive";
        }
        else
        {
            return "Shared";
        }
    }
    
    /**
     * Returns the name of the current revision as a link to the appropriate page that should
     * display it 
     * @return the name of the current revision as a link to the appropriate page that should
     * display it
     */
    public String getLinkedNumber()
    {
        String contextPath = ((HttpServletRequest)getPageContext().getRequest()).getContextPath();
        ActionMapping mapping = (ActionMapping)((HttpServletRequest)getPageContext().getRequest()).getAttribute(Globals.MAPPING_KEY);
        ViewerForm form = (ViewerForm)((HttpServletRequest)getPageContext().getRequest()).getAttribute( mapping.getAttribute() );
        NodeBean node = (NodeBean)getPageContext().getAttribute("node");
        RevisionBean rev = (RevisionBean)this.getObject();
        
	    String link = "<a href='"+contextPath+"/viewer.do?site="+form.getSite()+
        "&path="+form.getPath()+
        "&file="+node.getName()+
        "&branch="+rev.getBranch()+
        "&rev="+rev.getNumber()+"'>"
    	  +rev.getNumber()+"</a>";
	    return link;
    }
    
    /**
     * Returns an HTML string containing the link(s) for the view actions of a 
     * specific branch revision
     * @return an HTML string containing the link(s) for the view actions of a 
     * specific branch revision
     */
    public String getViewActions()
    {
        String contextPath = ((HttpServletRequest)getPageContext().getRequest()).getContextPath();
        ActionMapping mapping = (ActionMapping)((HttpServletRequest)getPageContext().getRequest()).getAttribute(Globals.MAPPING_KEY);
        ViewerForm form = (ViewerForm)((HttpServletRequest)getPageContext().getRequest()).getAttribute( mapping.getAttribute() );
        NodeBean node = (NodeBean)getPageContext().getAttribute("node");
        
        String link = "View | <a href='"+contextPath+"/editor.do?site="+form.getSite()+
        "&path="+form.getPath()+
        "&file="+node.getName()+
        "'>"+
        "Edit"+
        "</a>";
        return link;
    }
    
    /**
     * Returns the namspace+name for a revision property
     * @return String the namspace+name for a revision property
     */
    public String getQualifiedName()
    {
        PropertyBean prop = (PropertyBean)this.getObject();
        return prop.getNamespace()+prop.getName();
    }

	/**
	 * Returns an HTML string containing the link(s) for the lock actions for this resource
	 * @return an HTML string containing the link(s) for the lock actions for this resource
	 */
	public String getLockActions()
	{
        String contextPath = ((HttpServletRequest)getPageContext().getRequest()).getContextPath();
        ActionMapping mapping = (ActionMapping)((HttpServletRequest)getPageContext().getRequest()).getAttribute(Globals.MAPPING_KEY);
        ViewerForm form = (ViewerForm)((HttpServletRequest)getPageContext().getRequest()).getAttribute( mapping.getAttribute() );
        NodeBean node = (NodeBean)getPageContext().getAttribute("node");
        
        String link = "<a href='"+contextPath+"/killLock.do?site="+form.getSite()+
        "&path="+form.getPath()+
        "&file="+node.getName()+
        "'>"+
        "Kill Lock"+
        "</a>";
	    return link;
	}
}
