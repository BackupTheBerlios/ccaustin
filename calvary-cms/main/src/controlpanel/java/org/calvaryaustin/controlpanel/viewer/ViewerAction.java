package org.calvaryaustin.controlpanel.viewer;

import java.io.IOException;

import javax.servlet.ServletException;

import org.apache.struts.action.ActionForward;
import org.calvaryaustin.cms.RepositoryUtil;
import org.calvaryaustin.cms.WebdavRepositoryDAO;
import org.calvaryaustin.web.BaseAction;
import org.calvaryaustin.web.UserRequest;

/**
 * Processes requests to view either the summary of a document in the repository
 * or the contents of a specific branch and revision.
 * <p>
 * Requires the following parameters:
 * <pre>
 *   site   - the name of the site that the document resides
 *   path   - the path to the document, excluding the document name
 *   file   - the filename of the document, excluding the path
 *   rev    - (optional) the revision to view the detail for
 *   branch - (optional) the branch to view a revision for - rev is required 
 * </pre>
 * </p>
 * @author jhigginbotham
 */
public class ViewerAction extends BaseAction
{
	public ActionForward handleRequest(UserRequest request)
		throws IOException, ServletException
	{
		ViewerForm viewerForm = (ViewerForm)request.getActionForm();
		String siteName = viewerForm.getSite();
		siteName = siteName == null ? "" : siteName;
		String path = viewerForm.getPath();
		path = path == null ? "" : path;
		String file = viewerForm.getFile();
		// compute the path, using our DAO (which we shouldn't use from here, 
		// but no time to do it right by talking to the repository right now -
		// instead, we are going to use the Slide tags which talk directly to the kernel
		String uri = RepositoryUtil.normalize(WebdavRepositoryDAO.FILES_PREFIX + WebdavRepositoryDAO.PATH_SITES + "/" + siteName + "/" + path + "/" + file); 
        log.debug("uri="+uri);
        viewerForm.setComputedUri( uri );
		
		if(viewerForm.getRev() != null &&
		   !viewerForm.getRev().equals(""))
	    {	
	       if(viewerForm.getBranch() == null ||
	          viewerForm.getBranch().equals(""))
	       {
	       		viewerForm.setBranch("main"); // default Slide branch name    
	       }
           return request.getMapping().findForward("viewer.viewRev");
		       
	    }
		return request.getMapping().findForward("viewer.summary");

	}

}
