<?xml version="1.0"?>
    
<!-- 

	Articles Template
	
	Processes each article in this directory
	
	$Id: articles.xsl,v 1.1 2002/04/10 01:46:26 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="article">
    <xsl:variable name="id"><xsl:value-of select="@id"/></xsl:variable>
  <tr>
    <td colspan="2" align="left" class="tableheader"><xsl:value-of select="title"/></td>
  </tr>
  <tr>
    <td colspan="2" align="left" class="tablesubtitle"><br/></td>
  </tr>
  <tr>
    <td colspan="2" align="left" class="tablesubtitle"><xsl:apply-templates select="parts"/>
     </td>
  </tr>
  <tr>
    <td colspan="2" align="left" class="tablesubtitle"><br/></td>
  </tr>
  <tr>
    <td colspan="2" align="left" class="tablecell"><xsl:apply-templates select="full"/></td>
  </tr>
</xsl:template>

<xsl:template match="parts">
    Don't miss 
    <xsl:for-each select="part">
      <xsl:element name="a">
      	<xsl:attribute name="href"><xsl:value-of select="@id"/>.html</xsl:attribute><xsl:value-of select="."/>
      </xsl:element><xsl:text> </xsl:text>
    </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
