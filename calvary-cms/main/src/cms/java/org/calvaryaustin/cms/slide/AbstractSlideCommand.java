package org.calvaryaustin.cms.slide;

import org.apache.slide.common.*;
import org.apache.slide.macro.*;
import org.apache.slide.lock.*;
import org.apache.slide.content.*;
import org.apache.slide.search.Search;
import org.apache.slide.security.Security;
import org.apache.slide.structure.*;

/**
 * Base class from which all slide commands should extend - provides common functionality needed 
 * to perform common slide tasks
 * @author jhigginbotham
 */
abstract public class AbstractSlideCommand implements SlideConstants
{
    /**
     * Initialize the class with the appropriate tokens and helpers
     * @param slideToken the client token to use for the work
     * @param namespace the namespace token to perform the work
     */
    public AbstractSlideCommand(SlideToken slideToken, NamespaceAccessToken namespace)
    {
        super();
        this.slideToken = slideToken;
        this.namespace = namespace;

        // initialize helpers
        structure = namespace.getStructureHelper();
        content = namespace.getContentHelper();
        security = namespace.getSecurityHelper();
        lock = namespace.getLockHelper();
        macro = namespace.getMacroHelper();
    }

	/**
	 * Performs the actual work
	 * @throws SlideException if a Slide error occurs
	 */
    abstract public void execute() throws SlideException; 

	/**
	 * The slide token that represents the client
	 */
    protected SlideToken slideToken;
    /**
     * The namespace token that will be used to obtain access to the slide kernel
     */
    protected NamespaceAccessToken namespace;
    /**
     * Structure helper.
     */
    protected Structure structure;
    /**
     * Content helper.
     */
    protected Content content;
    /**
     * Security helper.
     */
    protected Security security;
    /**
     * Lock helper.
     */
    protected Lock lock;
    /** 
     * Search helper.
     */
    protected Search search;
    /**
     * Macro helper.
     */
    protected Macro macro;
}
