<?xml version="1.0"?>
    
<!-- 

	Ministry Home Page
	
	Processes the ministry tag and its children tags
	
	$Id: home.xsl,v 1.4 2002/04/08 21:11:38 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="news">
	<table border="0" cellspacing="0" width="100%">
	<!--
		<tr>
			<td width="95%" class="tablecell" align="center" valign="middle" nowrap="true"><img src="../images/homepage/stuff.gif" alt="Stuff To Know"/></td>
             <td><br/></td>
		</tr>
		-->
		<xsl:apply-templates/>
	</table>
</xsl:template>

<xsl:template match="item">
		<tr>
			<td colspan="2" class="tableheader" align="left">News: <xsl:value-of select="intro"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablesubtitle" align="left"><xsl:value-of select="date"/></td>
  	     </tr>
		<tr>
			<td colspan="2" class="tablecell,newsitem" align="left" valign="top"><xsl:apply-templates select="full"/></td>
  	     </tr>
		<tr>
             <td colspan="2"><br/></td>
		</tr>
</xsl:template>

<!-- old Slashdot like look
<xsl:template match="item">
		<tr>
			<td width="95%" class="tablecell" align="left" valign="middle">
			  <xsl:element name="img">
			    <xsl:attribute name="src"><xsl:value-of select="logo/@img"/></xsl:attribute>
			    <xsl:attribute name="align"><xsl:value-of select="logo/@align"/></xsl:attribute>
			  </xsl:element>
			  <span class="newsitem"><xsl:apply-templates select="full"/></span>
			</td>
             <td><br/></td>
  	     </tr>
		<tr>
             <td><br/></td>
             <td><br/></td>
		</tr>
</xsl:template>
-->

<xsl:template match="feature">
    <xsl:variable name="id"><xsl:value-of select="@articleId"/></xsl:variable>
    <xsl:variable name="id_file">../articles/<xsl:value-of select="@articleId"/>.xml</xsl:variable>
    <xsl:apply-templates select="document($id_file)//content/article[@id=$id]"/>
</xsl:template>


<xsl:template match="article">
    <xsl:variable name="id"><xsl:value-of select="@id"/></xsl:variable>
  <tr>
    <td colspan="2" align="left" class="tableheader">Feature Article: <xsl:value-of select="heading"/></td>
  </tr>
  <tr>
    <td colspan="2" align="left" class="tablesubtitle"><xsl:value-of select="title"/></td>
  </tr>
  <tr>
    <td colspan="2" align="left" class="tablecell"><xsl:value-of select="intro"/><span class="readmore">[<a href="../articles/{$id}.html" class="readmore ">Read More</a>]</span></td>
  </tr>
</xsl:template>


</xsl:stylesheet>
