package org.calvaryaustin.controlpanel.dashboard;

import java.io.IOException;

import javax.servlet.ServletException;

import org.apache.struts.action.ActionForward;
import org.calvaryaustin.controlpanel.AdminAction;
import org.calvaryaustin.controlpanel.AdminUserRequest;

/**
 * Initializes the Dashboard view for the current user
 * @author jhigginbotham
 */
public class DashboardAction extends AdminAction
{
	public ActionForward handleRequest(AdminUserRequest request)
		throws IOException, ServletException
	{
		return request.getMapping().findForward("dashboard.default");
	}

}
