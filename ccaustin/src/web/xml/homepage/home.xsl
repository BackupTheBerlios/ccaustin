<?xml version="1.0"?>
    
<!-- 

	Ministry Home Page
	
	Processes the ministry tag and its children tags
	
	$Id: home.xsl,v 1.3 2002/04/02 04:10:10 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="news">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td width="95%" class="tablecell" align="center" valign="middle" nowrap="true"><img src="../images/homepage/stuff.gif" alt="Stuff To Know"/></td>
             <td><br/></td>
		</tr>
		<xsl:apply-templates/>
	</table>
</xsl:template>

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

<xsl:template match="feature">
  <tr>
    <td>To Do! Feature <xsl:value-of select="@articleId"/></td>
  </tr>
</xsl:template>


</xsl:stylesheet>
