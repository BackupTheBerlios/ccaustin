<?xml version="1.0"?>
    
<!-- 

	Ministry Home Page
	
	Processes the ministry tag and its children tags
	
	$Id: ministry-home.xsl,v 1.1 2002/03/15 03:58:27 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="ministry">
	<table border="0" cellspacing="0" width="100%">
		<xsl:apply-templates/>
	</table>
</xsl:template>

<xsl:template match="name">
      <xsl:variable name="logo"><xsl:value-of select="../ministry-logo"/></xsl:variable>
		<tr>
			<td width="100%" class="tableheader" align="left" valign="top" nowrap="true"><!--img src="{$logo}"/--><xsl:value-of select="text()"/></td>
		</tr>
		<xsl:apply-templates select="overview"/>
</xsl:template>

<xsl:template match="overview">
		<tr>
			<td width="100%" class="tablecell" align="left" valign="top"><xsl:value-of select="text()"/></td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
</xsl:template>

<xsl:template match="ministry-logo">
</xsl:template>


<xsl:template match="long-description">
		<tr>
			<td width="100%" class="tableheader" align="left" valign="top" nowrap="true">About</td>
		</tr>
		<tr>
			<td width="100%" class="tablecell" align="left" valign="top"><xsl:apply-templates/></td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
</xsl:template>

<xsl:template match="contacts">
		<tr>
			<td width="100%" class="tableheader" align="left" valign="top" nowrap="true">Contact</td>
		</tr>
		<tr>
			<td width="100%" class="tablecell" align="left" valign="top"><xsl:value-of select="contact-web"/></td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
</xsl:template>

</xsl:stylesheet>
