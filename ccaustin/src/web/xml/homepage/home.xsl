<?xml version="1.0"?>
    
<!-- 

	Ministry Home Page
	
	Processes the ministry tag and its children tags. Most tags reference news and articles located in other files, 
	so we perform queries on other documents to obtain the data we need for this page. Nice for reusability!
	
	$Id: home.xsl,v 1.11 2002/07/06 04:42:37 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="home">
	<table width="100%" cellpadding="0" cellspacing="0"  border="0">
		<tbody>
		       <xsl:apply-templates select="featured-item"/>
		       <xsl:apply-templates select="news"/>
		</tbody>
	</table>
</xsl:template>

<xsl:template match="news">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="2%"><br/></td>
           <td width="96%"><br/>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr class="tablecellnews"> 
		    <td width="8" height="14" valign="top" align="left" class="tableheadernews"><img src="../images/homepage/im_tablefttop.gif" width="8" height="17" border="0"/></td>
		    <td width="99%" height="14" class="tableheadernews">News</td>
		    <td width="8" height="14" valign="top" align="right" class="tableheadernews"><img src="../images/homepage/im_tablerighttop.gif" width="8" height="17" border="0"/></td>
		  </tr>
		  <tr class="tablecellnews">
		    <td colspan="3">
			<table border="0" cellspacing="0" width="100%">
		          <tr>
		            <td>
		              <table border="0" cellspacing="0" width="100%">
			  	   <xsl:apply-templates select="news-ref"/>
		              </table>
		            </td>
		          </tr>
			</table>
		    </td>
		  </tr>
		  <tr class="tablecellnews"> 
		    <td valign="bottom" align="left" width="8" height="17"><img src="../images/homepage/im_tableleftbottom.gif" width="8" height="17" border="0"/></td>
		    <td><br/></td>
		    <td valign="bottom" align="right" width="8" height="17"><img src="../images/homepage/im_tablerightbottom.gif" width="8" height="17" border="0"/></td>
		  </tr>
		</table>
           </td>
           <td width="2%"><br/></td>
         </tr>
	</table>

</xsl:template>

<xsl:template match="news-ref">
    <xsl:variable name="id"><xsl:value-of select="@newsId"/></xsl:variable>
    <xsl:variable name="id_file">../news/<xsl:value-of select="@newsId"/>.xml</xsl:variable>
    <xsl:apply-templates select="document($id_file)//content/news-item[@id=$id]"/>
</xsl:template>

<xsl:template match="news-item">
		<tr>
			<td colspan="2" class="newstitle" align="left" valign="top"><xsl:value-of select="title"/></td>
		</tr>
		<tr>
			<td colspan="2" class="newssubtitle" align="left" valign="top"><xsl:value-of select="date"/></td>
		</tr>
		<tr>
			<td colspan="2" class="newsitem" align="left" valign="top"><xsl:value-of select="full"/></td>
  	     </tr>
</xsl:template>

<xsl:template match="featured-item">
			<tr>
				<td width="75%">
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tbody>
							<xsl:apply-templates select="article"/>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td width="75%"><xsl:apply-templates select="news"/></td>
			</tr>
			<tr>
				<td width="75%"><xsl:apply-templates select="features"/></td>
			</tr>
</xsl:template>

<xsl:template match="article">
       <xsl:variable name="doc">../articles/<xsl:value-of select="@id"/>.xml</xsl:variable>
	<xsl:for-each select="document($doc)/content/article">
							<tr class="featuredarticlebox">
								<td width="225"><img src="../images/{@image}" alt="Featured Article"/></td>
								<td width="99%" valign="center"><xsl:value-of select="heading"/><br/><p class="featureintro"><xsl:value-of select="intro"/><xsl:text> </xsl:text><span class="readmore">[<a href="../articles/{@id}.html" class="readmore ">Read More...</a>]</span></p></td>
							</tr>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
