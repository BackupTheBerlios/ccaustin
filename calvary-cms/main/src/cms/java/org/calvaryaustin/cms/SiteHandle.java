package org.calvaryaustin.cms;

import java.io.Serializable;

/**
 * A handle to a site in the repository
 * @author jhigginbotham
 */
public class SiteHandle implements Serializable
{
	/**
	 * Default constructor - for serialization
	 */
	public SiteHandle()
	{
	}

	/**
	 * Constructs a valid sitehandle for doing finds/gets
	 * @param id the site ID - unique to the repository
	 */
	public SiteHandle(String id)
	{
		this.id = id;
	}

	/**
	 * Constructs a valid sitehandle
	 * @param id the site ID - unique to the repository
	 * @param name the site name - unique to the repository
	 */
	public SiteHandle(String id, String name)
	{
		this.id = id;
		this.name = name;
	}

	/**
	 * @return the site ID - unique to the repository
	 */
	public String getId()
	{
		return id;
	}

	/**
	 * @return the site name - unique to the repository
	 */
	public String getName()
	{
		return name;
	}

	private String id; // same as name for now
	private String name;
}
