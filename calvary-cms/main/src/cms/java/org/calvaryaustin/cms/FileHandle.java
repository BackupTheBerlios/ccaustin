package org.calvaryaustin.cms;

import java.io.Serializable;

/**
 * A handle to a Page in a site
 * @author jhigginbotham
 */
public class FileHandle implements Serializable
{
	/**
	 * Default constructor - for serialization
	 */
	public FileHandle()
	{
	}

	/**
	 * Constructs a valid PageHandle for doing finds/gets given a full path
	 * @param path the path to the Page - unique to a site
	 */
	public FileHandle(String path)
	{
		this.path = path;
	}

	/**
	 * Constructs a valid PageHandle with the path and name for returning in a result set
	 * @param path the path to the Page - unique to a site
	 * @param name the Page name, which is part of the path also
	 */
	public FileHandle(String path, String name)
	{
		this.path = path;
		this.name = name;
	}

	/**
	 * @return the Page name
	 */
	public String getName()
	{
		return name;
	}

	/**
	 * @return the Page path - unique to the site
	 */
	public String getPath()
	{
		return path;
	}

	private String path; 
	private String name;
}
