package org.calvaryaustin.controlpanel.browser;

import java.io.IOException;
import javax.servlet.ServletException;
import org.calvaryaustin.web.BaseAction;
import org.calvaryaustin.web.UserRequest;
import org.apache.struts.action.ActionForward;
import org.calvaryaustin.cms.webdav.RepositoryUtil;
import org.calvaryaustin.cms.webdav.WebdavRepositoryDAO;

/**
 * Controller that will process the viewing of site contents, and allow the user to (if authorized)
 * launch into content creation and editing.
 * 
 * This action currently is reponsible for taking a BrowserForm JavaBean, filled by the Struts 
 * framework upon user request, and calculating the actual WebDAV path using the Repository
 * APIs. This calc'ed path is then used by the Slide tags in the view to render the current
 * node (either a site or directory).
 *
 * @author jhigginbotham
 * @version $Revision: 1.6 $
 */
public final class BrowserAction extends BaseAction 
{
	// TODO: Add reason for change column to the browser 
	//       - this may require a rework of the models used in the UI (rather than slide taglibs)
	
	public ActionForward handleRequest( UserRequest request )
		throws IOException, ServletException
	{
		BrowserForm browserForm = (BrowserForm)request.getActionForm();
        String siteName = browserForm.getSite();
        siteName = siteName == null ? "" : siteName;
        String path = browserForm.getPath();
        path = path == null ? "" : path;
        // compute the path, using our DAO (which we shouldn't use from here, 
        // but no time to do it right by talking to the repository right now -
        // instead, we are going to use the Slide tags which talk directly to the kernel
        String uri = RepositoryUtil.normalize(WebdavRepositoryDAO.FILES_PREFIX + WebdavRepositoryDAO.PATH_SITES + "/" + siteName + "/" + path); 
        log.debug("uri="+uri);
        browserForm.setComputedUri( uri );
        return request.getMapping().findForward("browser.success");
    }
}

