<?xml version="1.0"?>
    
<!-- 

	Generate Staff Template
	
	Uses the servants.xml, finding only those servants who are flagged as staff members and generates a second 
	xml file.
	
	$Id: gen-staff.xsl,v 1.2 2004/07/12 02:35:55 premav Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<xsl:template name="page-render">
  <xsl:apply-templates select="content"/>
</xsl:template>

<xsl:template match="content">
<xsl:element name="content">
  <xsl:attribute name="title">Meet the Staff</xsl:attribute>
  <xsl:element name="stafflist">
  <xsl:for-each select="staffulltime">
		<!--xsl:if test="role[@staff = 'true']">
			<xsl:copy-of select="."/>
		</xsl:if-->
	<xsl:copy-of select="."/>
  </xsl:for-each>		
<xsl:for-each select="staffparttime">
	<xsl:copy-of select="."/>
</xsl:for-each>
<xsl:for-each select="elder">
	<xsl:copy-of select="."/>
</xsl:for-each>
  </xsl:element>
</xsl:element>
</xsl:template>

</xsl:stylesheet>
