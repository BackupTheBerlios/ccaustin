<?xml version="1.0"?>
    
<!-- 

	About Vision Page
	
	Processes the visionstatement tag and its children tags.
	
	$Id: vision.xsl,v 1.1 2002/12/13 20:04:06 javajames27 Exp $
	
-->	    

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="html.xsl"/>

<xsl:template match="visionstatement">
	<xsl:apply-templates select="purpose"/>
	<xsl:apply-templates select="vision"/>
	<p align="center"><xsl:apply-templates select="text"/></p>
	
</xsl:template>

<xsl:template match="purpose">
	
	<table>
		<tr>
			<td class="tableheader">Purpose Statement</td>
		</tr>
		<tr>
			<td><xsl:value-of select="text()"/></td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
	</table>

</xsl:template>

<xsl:template match="vision">
	<table>
		<tr>
			<td class="tableheader" colspan="2">Our Vision</td>
		</tr>
		<tr>
			<td width="20%"><img src="{./item[@id=1]/@goalLogo}" alt="{./item[@id=1]/@goal}"/></td>
			<td width="80%"><img src="{./item[@id=1]/@goalImg}" alt="{./item[@id=1]/@goal}"/><br/><div class="textsubtitle">according to <xsl:value-of select="./item[@id=1]/@according"/></div>
			<br/><div class="textemphasis"><xsl:value-of select="./item[@id=1]/@quote"/></div>
			</td>
		</tr>
		<tr colspan="2">
			<td><br/></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="80%" align="right"><img src="{./item[@id=2]/@goalImg}" alt="{./item[@id=1]/@goal}"/><br/><div class="textsubtitle">according to <xsl:value-of select="./item[@id=2]/@according"/></div>
			<br/><div class="textemphasis"><xsl:value-of select="./item[@id=2]/@quote"/></div>
			</td>
			<td width="20%"><img src="{./item[@id=2]/@goalLogo}" alt="{./item[@id=1]/@goal}"/></td>
		</tr>
		<tr colspan="2">
			<td><br/></td>
		</tr>
	</table>
	<table>
		<tr>
			<td width="20%"><img src="{./item[@id=3]/@goalLogo}" alt="{./item[@id=1]/@goal}"/></td>
			<td width="80%"><img src="{./item[@id=3]/@goalImg}" alt="{./item[@id=1]/@goal}"/><br/><div class="textsubtitle">according to <xsl:value-of select="./item[@id=3]/@according"/></div>
			<br/><div class="textemphasis"><xsl:value-of select="./item[@id=3]/@quote"/></div>
			</td>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
