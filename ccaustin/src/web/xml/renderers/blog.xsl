<?xml version="1.0"?>
    
<!-- 

	Blog Renderer
	
	Processes the blog <entry/> tag
	
	$Id: blog.xsl,v 1.1 2003/03/12 22:02:21 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="html.xsl"/>

<xsl:template match="blog">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td width="100%" class="heading" align="left" valign="top" nowrap="true">Weblog for <xsl:value-of select="@name"/></td>
		</tr>
		<tr>
			<td width="100%" align="left" valign="top"><br/></td>
		</tr>
	</table>
	<xsl:apply-templates select="entry">
		<xsl:sort select="@date" order="descending"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="entry">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td width="100%" align="left" valign="top" colspan="2"><br/></td>
		</tr>
		<tr>
			<td width="5%" class="heading" align="left" valign="top" nowrap="true"><p>Date:</p></td>
			<td width="95%" align="left" valign="middle"><p><xsl:value-of select="@date"/></p></td>
		</tr>
		<tr>
			<td width="100%" align="left" valign="top" colspan="2"><br/></td>
		</tr>
		<tr>
			<td width="100%" align="left" valign="top" colspan="2"><xsl:apply-templates/></td>
		</tr>
		<tr>
			<td width="100%" align="left" valign="top" colspan="2"><br/></td>
		</tr>
		<tr>
			<td width="100%" align="left" valign="top" colspan="2"><hr/></td>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
