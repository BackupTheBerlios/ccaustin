<?xml version="1.0"?>
    
<!-- 

	Generate Staff Template
	
	Uses the servants.xml, finding only those servants who are flagged as staff members and generates a second 
	xml file.
	
	$Id: gen-staff.xsl,v 1.1 2002/04/13 21:57:57 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
<xsl:element name="content">
  <xsl:attribute name="title">Meet the Staff</xsl:attribute>
  <xsl:element name="stafflist">
  <xsl:for-each select="content/servant">
		<xsl:if test="role[@staff = 'true']">
			<xsl:copy-of select="."/>
		</xsl:if>
  </xsl:for-each>		
  </xsl:element>
</xsl:element>
</xsl:template>

</xsl:stylesheet>
