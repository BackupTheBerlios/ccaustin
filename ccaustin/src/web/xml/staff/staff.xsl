<?xml version="1.0"?>
    
<!-- 

	Staff Template
	
	Uses the servants.xml, finding only those servants who are flagged as staff members and generates a second 
	xml file.
	
	$Id: staff.xsl,v 1.1 2002/04/13 21:57:57 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
		<xsl:for-each select="servant">
		<tr>
		<xsl:choose>
			<!-- 
				The hardest part of the template: put Pastor Allen in the center top, the even number on the left, 
				odd number on the right. When the foreach loop comes around for the odd, ignore it since the 
				even number processes even and even +1.
			-->
			<xsl:when test="position() =1">
				<td colspan="4"><br/></td>
				<td colspan="2" width="20%" align="center" class="textsubtitle">
				  <xsl:element name="img">
  	                    <xsl:attribute name="src"><xsl:value-of select="thumbnail/@href"/></xsl:attribute>
  	                    <xsl:attribute name="alt"><xsl:value-of select="fullname"/></xsl:attribute>
  	                    </xsl:element>
  	                    <br/><xsl:value-of select="fullname"/><br/><xsl:apply-templates select="role/@title"/><br/></td>
				<td colspan="4"><br/></td>
			</xsl:when>
			
			<xsl:when test="position() mod 2 = 0">
  		         <xsl:variable name="curr"><xsl:value-of select="position()"/></xsl:variable>
				<td colspan="1" width="10%">
				  <xsl:element name="img">
  	                    <xsl:attribute name="src"><xsl:value-of select="thumbnail/@href"/></xsl:attribute>
  	                    <xsl:attribute name="alt"><xsl:value-of select="fullname"/></xsl:attribute>
  	                    </xsl:element>
				</td>
				<td colspan="2" align="left" class="textsubtitle"><xsl:apply-templates select="fullname"/><br/><xsl:apply-templates select="role/@title"/><br/></td>
				<td colspan="4" class="textsubtitle"><br/></td>
				<td colspan="2" align="right" class="textsubtitle"><xsl:apply-templates select="../servant[($curr+1)]/fullname"/><br/><xsl:value-of select="../servant[($curr+1)]/@title"/><br/></td>
				<td colspan="1" width="10%"><img src="{../servant[($curr+1)]/thumbnail/@href}" alt="{../servant[($curr+1)]/fullname}"/></td>
			</xsl:when>

			<xsl:otherwise>
			</xsl:otherwise>
			
		</xsl:choose>
		
		</tr>
		</xsl:for-each>
	</table>
</xsl:template>


</xsl:stylesheet>
