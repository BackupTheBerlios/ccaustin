<?xml version="1.0"?>
    
<!-- 

	Ministry Home Page
	
	Processes the ministry tag and its children tags. Most tags reference news and articles located in other files, 
	so we perform queries on other documents to obtain the data we need for this page. Nice for reusability!
	
	$Id: home.xsl,v 1.6 2002/07/01 02:15:13 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="home">
	<table width="100%">
		<tbody>
			<tr>
				<td width="75%">
					<table width="100%" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<td width="225"><img src="../images/homepage/featured-article-placeholder.jpg" alt="Featured Article"/></td>
								<td width="99%" valign="top"><br/><p>Text Text Text Text Text Text Text Text Text Text Text </p></td>
							</tr>
						</tbody>
					</table>
				</td>
				<td width="25%"></td>
			</tr>
			<tr>
				<td width="75%"><xsl:apply-templates select="news"/></td>
				<td width="25%"></td>
			</tr>
			<tr>
				<td width="75%"><xsl:apply-templates select="features"/></td>
				<td width="25%"></td>
			</tr>
		</tbody>
	</table>
</xsl:template>

<xsl:template match="news">
	<table border="0" cellspacing="0" width="100%">
	<!--
		<tr>
			<td width="95%" class="tablecell" align="center" valign="middle" nowrap="true"><img src="../images/homepage/stuff.gif" alt="Stuff To Know"/></td>
             <td><br/></td>
		</tr>
		-->
		<xsl:apply-templates select="news-ref"/>
	</table>
</xsl:template>

<xsl:template match="news-ref">
    <xsl:variable name="id"><xsl:value-of select="@newsId"/></xsl:variable>
    <xsl:variable name="id_file">../news/<xsl:value-of select="@newsId"/>.xml</xsl:variable>
    <xsl:apply-templates select="document($id_file)//content/news-item[@id=$id]"/>
</xsl:template>

<xsl:template match="news-item">
		<tr>
			<td colspan="2" class="tableheader" align="left">News: <xsl:value-of select="title"/></td>
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
    <td colspan="2" align="left" class="tablecell"><p><xsl:value-of select="intro"/><span class="readmore">[<a href="../articles/{$id}.html" class="readmore ">Read More</a>]</span></p></td>
  </tr>
</xsl:template>


</xsl:stylesheet>
