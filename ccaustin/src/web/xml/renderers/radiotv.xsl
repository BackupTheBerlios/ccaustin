<?xml version="1.0"?>
    
<!-- 

	Calvary Radio/TV Template
	
	$Id: radiotv.xsl,v 1.1 2002/12/13 20:04:06 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="html.xsl"/>

<xsl:template match="radio">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td colspan="2" class="tablecell" align="left"><img src="../images/hdradio.gif" alt="Radio"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell" align="left"><xsl:value-of select="description"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell" align="center"><br/><xsl:apply-templates select="timeslot"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell" align="center"><br/></td>
  	     </tr>
	</table>
</xsl:template>

<xsl:template match="tv">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td colspan="2" class="tablecell" align="left"><img src="../images/hdtv.gif" alt="Radio"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell" align="left"><xsl:value-of select="description"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell" align="center"><br/><xsl:apply-templates select="timeslot"/></td>
  	     </tr>
	</table>
</xsl:template>

<xsl:template match="timeslot">
	<p><xsl:value-of select="day"/><br/>
	<xsl:for-each select="time">
		<xsl:value-of select="."/><br/>
	</xsl:for-each>
	<span class="note"><xsl:value-of select="note"/></span></p>
</xsl:template>

</xsl:stylesheet>
