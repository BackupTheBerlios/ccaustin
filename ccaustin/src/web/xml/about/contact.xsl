<?xml version="1.0"?>
    
<!-- 

	Location/Map/Contact Template
	
	$Id: contact.xsl,v 1.1 2002/04/13 23:08:33 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="contact-info">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td colspan="2" class="tableheader" align="left">Contact Information</td>
  	     </tr>
  	     <tr>
  	     	<td colspan="2" class="tablecell" align="center">
			      <TABLE CELLSPACING="0" CELLPADDING="0" BORDER="0" ALIGN="center">
				<TR>
				  <TD><IMG SRC="../images/map000.gif" WIDTH="92" HEIGHT="185"/></TD>
				  <TD><IMG SRC="../images/map001.gif" WIDTH="169" HEIGHT="185"/></TD>
				  <TD><IMG SRC="../images/map002.gif" WIDTH="219" HEIGHT="185"/></TD>
				</TR>
				<TR>
				  <TD><IMG SRC="../images/map003.gif" WIDTH="92" HEIGHT="179"/></TD>
				  <TD><IMG SRC="../images/map004.gif" WIDTH="169" HEIGHT="179"/></TD>
				  <TD><IMG SRC="../images/map005.gif" WIDTH="219" HEIGHT="179"/></TD>
				</TR>
			      </TABLE>
              </td>
         </tr>
		<tr>
			<td colspan="2" class="tablecell" align="left"><br/></td>
  	     </tr>
  	     <xsl:apply-templates select="address"/>
		<tr>
			<td colspan="2" class="tablecell" align="left"><br/></td>
  	     </tr>
  	     <xsl:apply-templates select="office-hours"/>
  	     <xsl:apply-templates select="phone"/>
  	     <xsl:apply-templates select="fax"/>
  	     <xsl:apply-templates select="email"/>
  	     <xsl:apply-templates select="web"/>
  	     <xsl:apply-templates select="prayer-chain"/>
  	     <xsl:apply-templates select="women-counseling"/>
	</table>
</xsl:template>

<xsl:template match="address">
  	     <tr>
  	     	<td colspan="2" class="tablecell" align="center"><xsl:value-of select="address1"/><br/><xsl:value-of select="address2"/><br/><xsl:value-of select="address3"/></td>
  	     </tr>
</xsl:template>

<xsl:template match="office-hours">
  	     <tr>
  	          <td class="tablecell" align="right">Office Hours:</td>
  	     	<td class="tablecell" align="left"><xsl:value-of select="."/></td>
  	     </tr>
</xsl:template>

<xsl:template match="phone">
  	     <tr>
  	          <td class="tablecell" align="right">Phone:</td>
  	     	<td class="tablecell" align="left"><xsl:value-of select="."/></td>
  	     </tr>
</xsl:template>

<xsl:template match="fax">
  	     <tr>
  	          <td class="tablecell" align="right">Fax:</td>
  	     	<td class="tablecell" align="left"><xsl:value-of select="."/></td>
  	     </tr>
</xsl:template>

<xsl:template match="email">
  	     <tr>
  	          <td class="tablecell" align="right">Email:</td>
  	     	<td class="tablecell" align="left"><a href="mailto:{.}"><xsl:value-of select="."/></a></td>
  	     </tr>
</xsl:template>

<xsl:template match="web">
  	     <tr>
  	          <td class="tablecell" align="right">Web:</td>
  	     	<td class="tablecell" align="left"><a href="{.}"><xsl:value-of select="."/></a></td>
  	     </tr>
</xsl:template>

<xsl:template match="prayer-chain">
  	     <tr>
  	          <td class="tablecell" align="right">Prayer Chain:</td>
  	     	<td class="tablecell" align="left"><xsl:value-of select="."/></td>
  	     </tr>
</xsl:template>

<xsl:template match="women-counseling">
  	     <tr>
  	          <td class="tablecell" align="right">Women's Counseling:</td>
  	     	<td class="tablecell" align="left"><xsl:value-of select="."/></td>
  	     </tr>
</xsl:template>


</xsl:stylesheet>
