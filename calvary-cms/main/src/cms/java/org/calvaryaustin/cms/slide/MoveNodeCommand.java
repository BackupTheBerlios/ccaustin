package org.calvaryaustin.cms.slide;

import org.apache.slide.common.NamespaceAccessToken;
import org.apache.slide.common.SlideException;
import org.apache.slide.common.SlideToken;
import org.apache.slide.macro.Macro;
import org.apache.slide.macro.MacroParameters;

/**
 * Uses the Slide macro helper to move a node from one location to another
 * @author jhigginbotham
 */
public class MoveNodeCommand extends AbstractSlideCommand
{

	/**
	 * Initialize the command
	 * @param slideToken The slidetoken to use when performing the work
	 * @param namespace the namespace access token to use when performing the work
	 * @param sourceUri the path to the node to move
	 * @param destinationUri the path to the new location for the node
	 * @param recursive true if the move operation should be recursive
	 * @param overwrite true if the move operation should overwrite an existing node in the new location
	 */
	public MoveNodeCommand(SlideToken slideToken, NamespaceAccessToken namespace, String sourceUri, String destinationUri, boolean recursive, boolean overwrite)
	{
		super(slideToken, namespace);
		
		this.sourceUri = sourceUri;
		this.destinationUri = destinationUri;
		this.recursive = recursive;
		this.overwrite = overwrite;
	}

	public void execute() throws SlideException
	{
		Macro macro = namespace.getMacroHelper();
		if (!destinationUri.equals(sourceUri)) {
			 // move the user node
			 macro.move(slideToken, sourceUri, destinationUri, 
						new MacroParameters(recursive, overwrite));
		 }
	}

	private String sourceUri; 
	private String destinationUri;
	private boolean recursive; 
	private boolean overwrite;
}
