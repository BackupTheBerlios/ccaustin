package org.calvaryaustin.cms;

import java.util.List;

/**
 * A Site Resource is a base interface for anything that a site may contain 
 * @author jhigginbotham
 */
public interface SiteResource
{
	/**
	 * @return
	 */
	public String getName();
	/**
	 * @return
	 */
	public String getPath();
}
