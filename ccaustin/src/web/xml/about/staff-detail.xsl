<?xml version="1.0"?>
    
<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="/">
	<xsl:apply-templates select="stafflist/staff"/>
</xsl:template>

<xsl:template match="staff">
		<xsl:variable name="staffname"><xsl:value-of select="@name"/></xsl:variable>
		<xsl:document href="staff-{staffname}.html">
			<xsl:call-template name="layout"/>
		</xsl:document>
</xsl:template>


<xsl:template match="stafflist">
	<table width="100%">
		<tr>
			<td colspan="10" class="tableheader">Meet Our Staff</td>
		</tr>
		<xsl:for-each select="staff">
		<tr>
		<xsl:if test="position() mod 2 = 1">
			<td colspan="1" width="10%"><img src="{@thumbnail}" alt="{@name}"/></td>
			<td colspan="9"><xsl:apply-templates select="@name"/><br/><xsl:apply-templates select="@role"/><br/></td>
		</xsl:if>
		<xsl:if test="position() mod 2 = 0">
			<td colspan="9"><xsl:apply-templates select="@name"/><br/><xsl:apply-templates select="@role"/><br/></td>
			<td colspan="1" width="10%"><img src="{@thumbnail}" alt="{@name}"/></td>
		</xsl:if>
		</tr>
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template match="summary">
	<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
