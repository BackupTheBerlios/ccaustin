<?xml version="1.0"?>

<!-- 

	About Staff Page
	
	Processes the stafflist tag and its children tags and builds a 2 column output of the staff.
	
	$Id: staff.xsl,v 1.1 2002/01/31 03:25:35 javajames27 Exp $
	
-->	    

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="stafflist">
	<table width="100%">
		<tr>
			<td colspan="10" class="tableheader">Meet Our Staff</td>
		</tr>
		<tr><td><br/></td></tr>
		<xsl:for-each select="staff">
		<tr>
		<xsl:variable name="lastpos"><xsl:value-of select="position() +1"/></xsl:variable>
		<xsl:choose>
			<!-- 
				The hardest part of the template: put Pastor Allen in the center top, the even number on the left, 
				odd number on the right. When the foreach loop comes around for the odd, ignore it since the 
				even number processes even and even +1.
			-->
			<xsl:when test="position() =1">
				<td colspan="4"><br/></td>
				<td colspan="2" width="20%" align="center" class="textsubtitle"><img src="{@thumbnail}" alt="{@name}"/><br/><xsl:apply-templates select="@name"/><br/><xsl:apply-templates select="@role"/><br/></td>
				<td colspan="4"><br/></td>
			</xsl:when>
			
			<xsl:when test="position() mod 2 = 0">
				<td colspan="1" width="10%"><img src="{@thumbnail}" alt="{@name}"/></td>
				<td colspan="2" align="left" class="textsubtitle"><xsl:apply-templates select="@name"/><br/><xsl:apply-templates select="@role"/><br/></td>
				<td colspan="4" class="textsubtitle"><br/></td>
				<td colspan="2" align="right" class="textsubtitle"><xsl:apply-templates select="../staff[@id = $lastpos]/@name"/><br/><xsl:apply-templates select="../staff[@id = $lastpos]/@role"/><br/></td>
				<td colspan="1" width="10%"><img src="{../staff[@id = $lastpos]/@thumbnail}" alt="{../staff[@id = $lastpos]/@name}"/></td>
			</xsl:when>

			<xsl:otherwise>
			</xsl:otherwise>
			
		</xsl:choose>
		
		</tr>
		</xsl:for-each>
	</table>
</xsl:template>

<xsl:template match="summary">
	<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
