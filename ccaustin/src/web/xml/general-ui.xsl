<?xml version="1.0"?>
    
<!--
	This XSL handles the majority of the UI layout and look and feel. It uses
	Javascript to generate dynamic menus and other page features. This provides
	a more "current browser version" feel.

	Import this into your sheet by inserting the following after the xsl:stylesheet 
	tag to activate these templates:

	<xsl:include href="../general-ui.xsl"/>

	
	A variant of this file may offer more search engine or accessibility-friendly
	navigation and less Javascript features for older browsers. 
	
	$Id: general-ui.xsl,v 1.1 2002/01/31 03:25:33 javajames27 Exp $
-->

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<!--
	The start of the processing for a page begins here. 
-->
<xsl:template match="/">
	<!-- 
		By calling the layout template from here, we can override this template using
		standard XSL import and override rules, doing special work before the layout 
		is started.
	-->
	<xsl:call-template name="layout"/>
</xsl:template>

<!--
	The HTML layout template. This section is where the look and feel of the site can
	be changed. It handles to header, footer, and placement of the page content. 
	The content is then further processed by the other XSL templates based on the 
	appropriate XML tags.
-->
<xsl:template name="layout">
<html>
<head>
<title>Calvary Austin / <xsl:value-of select="./content/@title"/></title>
<link REL="STYLESHEET" href="../css/ca.css"></link>
<meta content="text/html; charset=windows-1252" http-equiv="Content-Type"></meta>
<script language="JavaScript1.2" src="../js/menu.js"></script>
<script language="JavaScript1.2" src="../js/ca.js"></script>
</head>
<body bgColor="white" leftMargin="0" text="#2544a9" topMargin="0" vLink="#758ee1" marginheight="0" marginwidth="0">

<!--
	The main page structure is the header followed by body.
	The header contains 2 regions: logo + menus, and variable
	content, separated as 2 table cells.  The right cell can
	contain page-specific images, titles, whatever.
	The entire page is enclosed in a table that forces the
	width to 640.
-->

<table border="0" cellPadding="0" cellSpacing="0" width="100%">
  <tbody>
  <tr>

    <!--
      This cell contains the primary table that forces a total width
      of 640.  The "middle" attribute keeps the overall page layout
      centered in the browser.
    -->

    <td align="middle">
      <table border="0" cellPadding="0" cellSpacing="0" width="640">
        <tbody>
        <tr>

	  <!--
	    Following is the logo + menus section, the left cell
	    of the header.
	  -->

          <td align="left" vAlign="top">
            <table border="0" cellpadding="0" cellspacing="0">
              <tbody>
              <tr>
                <td colspan="6"><img height="64" src="../images/maintop.jpg" width="282"></img></td></tr>
              <tr>
                <td><img height="15" src="../images/main007.jpg" width="37"></img></td>
                <td><a href="javascript:window.showMenu(window.menuAbout,108,84);" onmouseover="window.showMenu(window.menuAbout,108,84);"><img border="0" height="15" name="mitem1" src="../images/main008.jpg" width="58"></img></a></td>
                <td><img height="15" src="../images/main009.jpg" width="55"></img></td>
                <td><img height="15" src="../images/main010.jpg" width="57"></img></td>
                <td><img height="15" src="../images/main011.jpg" width="59"></img></td>
                <td><img height="15" src="../images/main012.jpg" width="16"></img></td>
	      </tr>
              <tr>
                <td colspan="6"><img height="16" src="../images/mainbtm.jpg" width="282"></img></td>
	      </tr>
	      </tbody>
	    </table>
	  </td>

	  <!--
	    Here's the right cell of the header.
	  -->

          <td width="358">
            <table border="0" cellpadding="0" cellspacing="0" width="320">
              <tbody>
              <tr>

	        <!--
		  This table cell (td) contains page specific information.
		  Note that the enclosing table sets the width to exactly
		  320.  Don't put anything wider than that in here, or the
		  overall layout will get trashed!
		-->

                <td>Page-specific images go here... </td>
	      </tr>
	      </tbody>
	    </table>
	  </td>
	</tr>


	<!--
	  Main page content goes here.  It should enclosed in the cell (td)
	  below, but any kind of layout can be accommodated.  Note that the
	  overall page width should remain 640.
	-->

        <tr>
	    <!-- spacer row -->
          <td colspan="2"><br/>
	   </td>
	</tr>

        <tr>
          <td colspan="2">
		
		<!--
			This directive tells the XSLT processor to proceed with the rest of the 
			XML document, and is why the content of an XML file is rendered in this 
			table cell all the time.
		-->
			
		<xsl:apply-templates/>
	   </td>
	</tr>


	<!--
	  Page footer.  Everypage should include a footer that indicates the
	  date of the last update, plus a link for sending email to the
	  web-servant for comments or problem reports.
	-->

        <tr>
          <td colspan="2">
            <table border="0" cellpadding="0" cellspacing="0">
              <tbody>
              <tr>
                <td align="middle" colspan="7"><br/></td>
	      </tr>
              <tr>
                <td align="middle" colspan="7"><img border="0" src="../images/arcupper.jpg"></img></td>
	      </tr>
              <tr>
                <td align="right" colspan="7">
		  <font size="1">
		  Copyright © 1999,2001 Calvary Chapel of Austin<br/>
		  For Website problems or comments, send mail to
		  <a href="mailto:webservant-austin@calvarychapel.org"><img border="0" src="../images/email.gif"></img> webservant-austin@calvarychapel.org</a><br/>
		  Latest update: May 18, 2001<br/>
		  </font>
		</td>
	      </tr>
              <tr>
                <td align="middle" colspan="7"><img border="0" src="../images/arclower.jpg"></img></td>
	      </tr>
	      </tbody>
	    </table>
	  </td>
	</tr>
	<!-- End of footer -->
	</tbody>
      </table>
    </td>
  </tr>
  </tbody>
</table>

<!-- This section causes the menus to be built -->
<script language="JavaScript1.2">
<![CDATA[
<!-- 
if ( document.all ) 
{   
buildMenus(); 
} //-->
]]>
</script>

</body>
</html>

</xsl:template>

<!--
	Any XML tag that is <text></text> gets processed as-is. This is useful for pages 
	that are only text and no other special data. It can be processed as-is, just like
	standard HTML without any work by the XSL writer.
-->
<xsl:template match="text">
	<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
