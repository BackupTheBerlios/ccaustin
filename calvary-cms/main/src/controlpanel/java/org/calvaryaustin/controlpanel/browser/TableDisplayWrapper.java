package org.calvaryaustin.controlpanel.browser;

import javax.servlet.http.HttpServletRequest;

import org.apache.slide.taglib.bean.NodeBean;
import org.apache.struts.Globals;
import org.apache.struts.action.ActionMapping;
import org.apache.taglibs.display.TableDecorator;
import org.calvaryaustin.cms.RepositoryUtil;

/**
 * A custom display taglibrary decorator for the browser web component
 * @todo Add support for checking lock status
 * 
 * @author jhigginbotham
 */
public class TableDisplayWrapper extends TableDecorator 
{
	/**
	 * Returns the HTML to render an image relative to the current servlet 
	 * context based on the type of node we are displaying
	 * @return HTML String for the cell 
	 */	
	public String getTypeIcon()
	{
		String contextPath = ((HttpServletRequest)getPageContext().getRequest()).getContextPath();
		ActionMapping mapping = (ActionMapping)((HttpServletRequest)getPageContext().getRequest()).getAttribute(Globals.MAPPING_KEY);
		BrowserForm form = (BrowserForm)((HttpServletRequest)getPageContext().getRequest()).getAttribute( mapping.getAttribute() );
		NodeBean node = (NodeBean)this.getObject();
		String imageUrl = contextPath; 
		if( form.getSite() == null )
		{
			// browsing sites
			imageUrl += SITE_ICON;
		} 
		else if( node.getHasChildren() )
		{
			imageUrl += FOLDER_ICON;
		} 
		else
		{
			imageUrl += DOCUMENT_ICON;
			// TODO: Link in locked document icon 
		}
		return "<img src='"+imageUrl+"'/>";
	}
	
	/**
	 * Returns the name of the current node as a link to the appropriate page that should
	 * display it (this browser for directories, detail page for a document)
	 * @return the name of the current node as a link to the appropriate page that should
	 * display it
	 */
	public String getLinkedName()
	{
		String contextPath = ((HttpServletRequest)getPageContext().getRequest()).getContextPath();
		ActionMapping mapping = (ActionMapping)((HttpServletRequest)getPageContext().getRequest()).getAttribute(Globals.MAPPING_KEY);
		BrowserForm form = (BrowserForm)((HttpServletRequest)getPageContext().getRequest()).getAttribute( mapping.getAttribute() );
		NodeBean node = (NodeBean)this.getObject();
		if( form.getSite() == null )
		{
			// browsing sites
			String link = "<a href='"+contextPath+"/browser.do?site="+node.getName()+"&path=/'>"
			  +node.getName()+"</a>";
			return link;
		} 
		else if( node.getHasChildren() )
		{
			// build the call to this same page via the Action with the new path
			String site = form.getSite();
			String path = RepositoryUtil.normalize( form.getPath()+"/"+node.getName() );
			String link = "<a href='"+contextPath+"/browser.do?site="+site+"&path="+path+"'>"
			  +node.getName()+"</a>";
			return link;
		} 
		else 
		{
			String site = form.getSite();
			String path = RepositoryUtil.normalize( form.getPath()+"/"+node.getName() );
			String link = "<a href='"+contextPath+"/viewer.do?site="+site+"&path="+path+
				"&file="+node.getName()+"'>"
			  +node.getName()+"</a>";
			return link;
		}
	}
	
	public static final String SITE_ICON = "/images/icons/sites-closed1.gif";
	public static final String FOLDER_ICON = "/images/icons/folder2.gif";
	public static final String DOCUMENT_ICON = "/images/icons/doc2.gif";
	
	private String contextPath;
}
