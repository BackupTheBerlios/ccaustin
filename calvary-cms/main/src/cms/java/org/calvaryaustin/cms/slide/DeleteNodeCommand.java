package org.calvaryaustin.cms.slide;

import org.apache.slide.common.NamespaceAccessToken;
import org.apache.slide.common.SlideException;
import org.apache.slide.common.SlideToken;
import org.apache.slide.macro.Macro;
import org.apache.slide.macro.MacroParameters;

/**
 * Uses the Slide macro helper to delete a node
 * @author jhigginbotham
 */
public class DeleteNodeCommand extends AbstractSlideCommand
{

	/**
	 * Initialize the command
	 * @param slideToken The slidetoken to use when performing the work
	 * @param namespace the namespace access token to use when performing the work
	 * @param sourceUri the path to the node to delete
	 * @param recursive true if the delete operation should be recursive
	 */
	public DeleteNodeCommand(SlideToken slideToken, NamespaceAccessToken namespace, String sourceUri, boolean recursive)
	{
		super(slideToken, namespace);
		
		this.sourceUri = sourceUri;
		this.recursive = recursive;
	}

	public void execute() throws SlideException
	{
		Macro macro = namespace.getMacroHelper();
		// do the delete
  	    macro.delete(slideToken, sourceUri, 
		  		     new MacroParameters(recursive, false));	
	}

	private String sourceUri; 
	private boolean recursive; 
}
