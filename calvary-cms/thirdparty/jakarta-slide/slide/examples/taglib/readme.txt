Slide Tag Libraries
Example JSP
-----------------------------------

This is an example JSP page that uses many features of the Slide Tag Library 
for Struts. Copy it into a new web application, and add the following to that 
webapp's web.xml file:

  <taglib>
    <taglib-uri>/WEB-INF/slide-struts.tld</taglib-uri>
    <taglib-location>/WEB-INF/slide-struts.tld</taglib-location>
  </taglib>
  <taglib>
    <taglib-uri>/WEB-INF/struts-bean.tld</taglib-uri>
    <taglib-location>/WEB-INF/struts-bean.tld</taglib-location>
  </taglib>
  <taglib>
    <taglib-uri>/WEB-INF/struts-logic.tld</taglib-uri>
    <taglib-location>/WEB-INF/struts-logic.tld</taglib-location>
  </taglib>

You'll also need to copy the TLD files references above (slide-struts.tld, 
struts-bean.tld and struts-logic.tld) into the WEB-INF directory. You should 
be able to find them in the Slide and the Struts info, respectively. Also 
adjust the security constraints so that you have access to the default slide 
namespace after authentication (refer to the configuration of the WebDAV 
servlet for detailed instructions).

Next copy slide-taglib-common.jar, slide-taglib-struts.jar and struts.jar into
WEB-INF/lib.

Initialization of the slide domain & namespace should happen elsewhere (eg the 
WebDAV servlet, the Slide host/realm, etc) before the JSP is compiled.
