package org.calvaryaustin.cms.slide;

/**
 * Interface wrapper around the constants needed for Slide
 * @author jhigginbotham
 */
public interface SlideConstants
{
    /**
     * Default timeout value.
     */
    public static final int DEFAULT_TIMEOUT = 3600;
    
    
    /**
     * Maximum timeout.
     */
    public static final int MAX_TIMEOUT = 604800;
    
    /**
     * The default owner if not explicitely specified by the request.
     */
    public static final String DEFAULT_LOCK_OWNER = "";


}
