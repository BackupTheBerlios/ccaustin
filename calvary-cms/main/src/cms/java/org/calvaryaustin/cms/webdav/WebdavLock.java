package org.calvaryaustin.cms.webdav;

import org.calvaryaustin.cms.Lock;

/**
 * A Webdav-aware lock implementation
 * @author jhigginbotham
 */
public class WebdavLock implements Lock
{
	
	public WebdavLock(String id, String owner)
	{
		this.id = id;
		this.owner = owner;
	}

	public String getId()
	{
		return id;
	}

	public String getOwner()
	{
		return owner;
	}

	private String id;
	private String owner;
}
