package org.calvaryaustin.cms;

/**
 * RepositoryUtil.java
 *
 *
 * Created: Tue Jan 28 20:14:37 2003
 *
 * @author <a href="mailto:jhigginbotham@betweenmarkets.com">James Higginbotham</a>
 * @version $Revision: 1.1 $
 */

public class RepositoryUtil 
{

    /**
     * Return a context-relative path, beginning with a "/", that represents
     * the canonical version of the specified path after ".." and "." elements
     * are resolved out.  If the specified path attempts to go outside the
     * boundaries of the current context (i.e. too many ".." path elements
     * are present), return <code>null</code> instead.
     *
     * @param path the path to be normalized.
     * @return the normalized path.
     */
    public static String normalize(String path) 
    {
        if (path == null)
            return null;

        String normalized = path;

        // Normalize the slashes and add leading slash if necessary
        if (normalized.indexOf('\\') >= 0)
            normalized = normalized.replace('\\', '/');
        if (!normalized.startsWith("/"))
            normalized = "/" + normalized;

        // Resolve occurrences of "/./" in the normalized path
        while (true) {
            int index = normalized.indexOf("/./");
            if (index < 0)
            break;
            normalized = normalized.substring(0, index) +
            normalized.substring(index + 2);
        }

        // Resolve occurrences of "/../" in the normalized path
        while (true) {
            int index = normalized.indexOf("/../");
            if (index < 0)
            break;
            if (index == 0)
            return ("/");  // The only left path is the root.
            int index2 = normalized.lastIndexOf('/', index - 1);
            normalized = normalized.substring(0, index2) +
            normalized.substring(index + 3);
        }

        // Resolve occurrences of "//" in the normalized path
        while (true) {
            int index = normalized.indexOf("//");
            if (index < 0)
            break;
            normalized = normalized.substring(0, index) +
            normalized.substring(index + 1);
        }

        // Return the normalized path that we have completed
        return (normalized);
    }
  
  
  private RepositoryUtil ()
  {
    
  }
  
}// RepositoryUtil
