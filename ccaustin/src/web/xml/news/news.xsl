<?xml version="1.0"?>
    
<!-- 

	News template
	
	Processes a news item to make all news pages look the same
	
	$Id: news.xsl,v 1.1 2002/04/09 00:24:57 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="news-item">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td colspan="2" class="tableheader" align="left"><xsl:value-of select="title"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablesubtitle" align="left"><xsl:value-of select="date"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablesubtitle" align="left"><br/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell,newsitem" align="left" valign="top"><xsl:apply-templates select="full"/></td>
  	     </tr>
		<tr>
             <td colspan="2"><br/></td>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
