<?xml version="1.0"?>
    
<!-- 

     Renderer that produces a page that is divided into titled sections
     
     $Id: sectioned.xsl,v 1.1 2002/12/13 20:04:06 javajames27 Exp $
     
-->          

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="html.xsl"/>

<xsl:template match="intro">
  <table width="100%" border="0">
    <!-- Heading -->
    <tr>
      <td><xsl:apply-templates/></td>
    </tr>
  </table>
</xsl:template>

<xsl:template match="section">
  <table width="100%" border="0">
    <!-- Heading -->
    <tr>
      <td colspan="2">
        <xsl:choose>
          <xsl:when test="@img != ''">
            <img src="{@img}" alt="{@heading}"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@heading"/>
          </xsl:otherwise>
        </xsl:choose>
        
      </td>
    </tr>
    <!-- Content -->
    <tr>
      <td width="25%"><br/></td>
      <td width="75%"><xsl:apply-templates/></td>
    </tr>
  </table>
</xsl:template>

<!-- Can I override the heading tag, or should I just rename it within the section tag to keep them separate? -->
</xsl:stylesheet>
