Here is how you have to extend the WebdavServlet:
1) compile the provided SimpleWebdavServlet
2) copy it here: webapps\slide\WEB-INF\classes\SimpleWebdavServlet.class
3) modify: webapps\slide\WEB-INF\web.xml
change:
    <servlet-class>org.apache.slide.webdav.WebdavServlet</servlet-class>

to:
    <servlet-class>SimpleWebdavServlet</servlet-class>

Now when you request a directory listing, the following text is printed
on the top of the page
"This my servlet and not the default one"

You can change the look and implement the doPost method or anything you want.
Only be carefull to always use a directory as a target to do your special actions.
Operations on files always go to the original WebdavServlet and you can only change
doGet and doPost, not the other WebDAV specific methods.
