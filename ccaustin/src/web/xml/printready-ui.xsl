<?xml version="1.0"?>
    
<!--
	This XSL handles a printable version UI. We may need to revisit this page in the future.

	Import this into your sheet by inserting the following after the xsl:stylesheet 
	tag to activate these templates:

	<xsl:include href="../printready-ui.xsl"/>

	
	$Id: printready-ui.xsl,v 1.1 2002/05/30 01:20:31 javajames27 Exp $
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
<script language="JavaScript1.2" src="../js/win.js"></script>
<xsl:apply-templates select="content/script"/> <!-- allow our pages to include custom scripting -->
</head>
<body bgColor="white" leftMargin="0" text="#2544a9" topMargin="0" vLink="#758ee1" marginheight="0" marginwidth="0">
<xsl:if test="content/@onUnload != '' ">
	<xsl:attribute name="onUnload"><xsl:value-of select="content/@onUnload"/></xsl:attribute>
</xsl:if>
<!--
	The main page structure is the header followed by body.
	The header is currently empty to make printing easier.
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
      <table border="0" cellPadding="0" cellSpacing="0" width="575">
        <tbody>

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


	</tbody>
      </table>
    </td>
  </tr>
  </tbody>
</table>

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

<xsl:template match="script">
  <script language="JavaScript1.2">
  	<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
  </script> 
</xsl:template>

</xsl:stylesheet>

