package org.calvaryaustin.controlpanel.viewer;

import java.io.IOException;

import javax.servlet.ServletException;

import org.apache.struts.action.ActionForward;
import org.calvaryaustin.cms.RepositoryUtil;
import org.calvaryaustin.cms.WebdavRepositoryDAO;
import org.calvaryaustin.web.BaseAction;
import org.calvaryaustin.web.UserRequest;

/**
 * @author jhigginbotham
 */
public class ViewerAction extends BaseAction
{

	/* (non-Javadoc)
	 * @see org.calvaryaustin.web.BaseAction#handleRequest(org.calvaryaustin.web.UserRequest)
	 */
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
		return request.getMapping().findForward("viewer.success");

	}

}
