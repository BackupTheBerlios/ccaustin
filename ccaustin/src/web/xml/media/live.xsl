<?xml version="1.0"?>
    
<!-- 

	Calvary Live Template
	
	$Id: live.xsl,v 1.2 2002/04/10 01:57:19 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="welcome">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td colspan="2" class="tableheader" align="left">Welcome to our Live Broadcast!</td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell" align="left"><xsl:apply-templates select="node()"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell" align="left"><br/></td>
  	     </tr>
	</table>
</xsl:template>

<xsl:template match="broadcasts">
	<table border="0" cellspacing="0" width="100%">
  	     <tr>
  	     	<td colspan="3"><img src="../images/underbar.gif"/></td>
  	     </tr>
  	     <tr>
  	     	<td colspan="3"><br/></td>
  	     </tr>
		<tr>
			<td width="50%" class="tablecell" align="center">
				<a href="viewlive.html" border="0"><img src="../images/livmsg.jpg" alt="Join our Calvary Worship Service Live!" border="0"/></a><br/><br/>
				<xsl:for-each select="broadcast">
					<xsl:value-of select="."/><br/>
				</xsl:for-each>
			</td>
			<td width="30%" class="tablecell" align="left"><xsl:apply-templates select="sidetext"/></td>
			<td class="tablecell" align="left"><br/></td>
  	     </tr>
  	     <tr>
  	     	<td colspan="3"><br/></td>
  	     </tr>
	</table>
</xsl:template>

<xsl:template match="video-archives">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td class="tableheader" align="left">Webcast Archives</td>
  	     </tr>
		<tr>
			<td class="tablecell" align="left"><xsl:apply-templates select="node()"/></td>
  	     </tr>
		<tr>
             <td><br/></td>
		</tr>
	</table>
</xsl:template>

<xsl:template match="broadcast-archive">
	<table border="0" cellspacing="0" width="100%"> 
  	     <tr>
  	     	<td colspan="3"><img src="../images/underbar.gif"/></td>
  	     </tr>
  	     <tr>
  	     	<td colspan="3" class="tablesubtitle">Available Services</td>
  	     </tr>
		<tr>
			<td width="40%" class="tablecell" align="center" valign="top">
				<img src="../images/vidallen.jpg" alt="View recent services with RealVideo" border="0"/><br/><br/>
			</td>
			<td width="60%" class="tablecell" align="left" valign="top">
				<xsl:for-each select="broadcast">
				  <xsl:element name="a">
				    <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
				    <xsl:value-of select="text()"/>
				  </xsl:element>
					<br/>
				</xsl:for-each>
			</td>
			<td class="tablecell" align="left"><br/></td>
  	     </tr>
  	     <tr>
  	     	<td colspan="3"><br/></td>
  	     </tr>
	</table>
</xsl:template>

<xsl:template match="audio-archives">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td class="tableheader" align="left">Audio Archives</td>
  	     </tr>
		<tr>
			<td class="tablecell" align="left"><xsl:apply-templates select="*|@*|text()"/></td>
  	     </tr>
		<tr>
             <td><br/></td>
		</tr>
	</table>
</xsl:template>

</xsl:stylesheet>
