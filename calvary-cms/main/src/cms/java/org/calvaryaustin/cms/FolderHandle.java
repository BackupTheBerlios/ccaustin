package org.calvaryaustin.cms;

import java.io.Serializable;

/**
 * A handle to a folder in a site
 * @author jhigginbotham
 */
public class FolderHandle implements Serializable
{
	/**
	 * Default constructor - for serialization
	 */
	public FolderHandle()
	{
	}

	/**
	 * Constructs a valid FolderHandle for doing finds/gets given a full path
	 * @param path the path to the folder - unique to a site
	 */
	public FolderHandle(String path)
	{
		this.path = path;
	}

	/**
	 * @return the folder path - unique to the site
	 */
	public String getPath()
	{
		return path;
	}

	private String path; 
}
