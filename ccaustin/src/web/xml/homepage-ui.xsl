<?xml version="1.0"?>
    
<!--
	This XSL handles the homepage UI layout and look and feel. It uses
	Javascript to generate dynamic menus and other page features. This provides
	a more "current browser version" feel.

	Import this into your sheet by inserting the following after the xsl:stylesheet 
	tag to activate these templates:

	<xsl:include href="../homepage-ui.xsl"/>

	$Id: homepage-ui.xsl,v 1.2 2002/04/01 02:07:06 javajames27 Exp $
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
    </head>
    <body>
      <xsl:apply-templates/>
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
