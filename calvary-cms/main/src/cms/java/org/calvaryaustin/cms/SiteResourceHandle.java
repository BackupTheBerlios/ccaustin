package org.calvaryaustin.cms;

import java.io.Serializable;

/**
 * A handle to a site resource in the repository
 * @author jhigginbotham
 */
public class SiteResourceHandle implements Serializable
{
	/**
	 * Default constructor - for serialization
	 */
	public SiteResourceHandle()
	{
	}

	/**
	 * Constructs a valpath sitehandle
	 * @param path the site path - unique to the repository
	 * @param name the site name - unique to the path
	 */
	public SiteResourceHandle(String path, String name)
	{
		this.path = path;
		this.name = name;
	}

	/**
	 * Returns the site path - unique to the repository
	 * @return the site path - unique to the repository
	 */
	public String getPath()
	{
		return path;
	}

	/**
	 * Returns the resource name
	 * @return the resource name 
	 */
	public String getName()
	{
		return name;
	}
	
	/**
	 * Returns true if this resource is a folder
	 * @return true if this resource is a folder
	 */
	public boolean isFolder()
	{
		return isFolder;
	}

	private String path; 
	private String name;
	private boolean isFolder;
}
