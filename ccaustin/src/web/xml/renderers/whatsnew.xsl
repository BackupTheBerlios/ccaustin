<?xml version="1.0"?>
    
<!-- 

	What's New template
	
	Processes news items into a single page
	
	$Id: whatsnew.xsl,v 1.1 2002/12/13 20:04:06 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="html.xsl"/>

<xsl:template match="news">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
          <tr>
            <td colspan="2" class="tableheader" align="left">What's New?</td>
          </tr>
          <tr>
            <td colspan="2" class="tableheader" align="left"><br/></td>
          </tr>
          <xsl:apply-templates select="news-item[@expires &gt; $DATE]">
            <xsl:sort select="@date"/>
          </xsl:apply-templates>
        </table>
</xsl:template>

<xsl:template match="news-item">
  <a name="{@id}"/>
  <tr>
    <td colspan="2" class="heading" align="left"><xsl:value-of select="title"/></td>
  </tr>
  <xsl:choose>
    <xsl:when test="date/text()">
      <tr>
        <td colspan="2" class="tablesubtitle" align="left"><xsl:value-of select="date"/></td>
      </tr>
    </xsl:when>
  </xsl:choose>
  <tr>
    <td colspan="2" class="tablecell,newsitem" align="left" valign="top"><p><xsl:apply-templates select="detail"/></p></td>
  </tr>
  <tr>
    <td colspan="2"><br/></td>
  </tr>
</xsl:template>

</xsl:stylesheet>
