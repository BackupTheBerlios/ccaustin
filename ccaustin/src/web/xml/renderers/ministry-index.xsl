<?xml version="1.0"?>
    
<!-- 

	Ministry Index Page
	
	Uses the sitemap to produce an index to all the ministries
	
	$Id: ministry-index.xsl,v 1.1 2002/12/13 20:04:06 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template name="page-render">
	<xsl:apply-templates select="website"/>
</xsl:template>

<xsl:template match="website">
	<table width="100%">
	<xsl:for-each select="section[@name='ministries']">
		<tr>
			<td class="tableheader"><xsl:value-of select="title"/></td>
		</tr>
		<tr>
			<td><p>The following is a complete list of ministries at Calvary Chapel of Austin:</p></td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
		<xsl:for-each select="page">
			<xsl:choose>
				<xsl:when test="@exclude = 'true'"></xsl:when>
				<xsl:otherwise>
                                  <xsl:variable name="doc">../ministries/<xsl:value-of select="substring-after(@datafile,'/')"/></xsl:variable>
					<tr>
						<td class="text">
						  <a><xsl:attribute name="href">..<xsl:value-of select="@html"/></xsl:attribute><xsl:value-of select="title"/></a>
						  <br/><xsl:value-of select="document($doc)/content/ministry/overview"/>
						  
						 </td>
					</tr>
					<tr>
						<td><br/></td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:for-each>
	
	</table>
</xsl:template>

<xsl:template match="section">
	<xsl:text>here!</xsl:text>
</xsl:template>

</xsl:stylesheet>
