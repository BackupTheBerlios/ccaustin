<?xml version="1.0"?>
    
<!--

	Extends the general-ui.xsl template to provide a small left sidebar that can contain
	one image with the rest of the space occupied with the content on the right.
	
	In the XML, set the "sidebar-image" attribute to the URL of the image, and the
	"sidebar-imagealt" to the text description of the image. 
	
	NOTE: Include this IN PLACE OF general-ui.xsl, not in addition to it!

	<xsl:include href="../general-left-image.xsl"/>
	
	$Id: general-left-image.xsl,v 1.1 2002/01/31 03:25:33 javajames27 Exp $
-->

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="general-ui.xsl"/>
<xsl:include href="general-html.xsl"/>

<!-- 
	Normally we don't worry about the content tag itself, we just process
	its children tags. But for this template, we create a table with the content and image
	cells and then process the children accordingly.
 -->
<xsl:template match="content">
	<table width="100%">
		<tr>
			<!-- image cell processing here -->
			<td width="5%" nowrap="true" valign="top" align="left"><img src="{@sidebar-image}" alt="{@sidebar-imagealt}"/></td>
			<!-- normal processing here -->
			<td><xsl:apply-templates/></td>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
