<?xml version="1.0"?>
    
<!-- 

	Ministry Home Page
	
	Processes the ministry tag and its children tags
	
	$Id: ministry-home.xsl,v 1.7 2002/05/24 01:08:16 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:variable name="ministryid"><xsl:value-of select="content/ministry/@id"/></xsl:variable>

<xsl:template match="ministry">
	<table border="0" cellpadding="0" width="100%">
		<xsl:apply-templates/>
	</table>
</xsl:template>

<xsl:template match="name">
      <xsl:variable name="logo"><xsl:value-of select="../ministry-logo"/></xsl:variable>
          <xsl:choose>
		  <xsl:when test="$logo != '' ">
			<tr>
			     <td width="100%" align="left"><table border="0"><tr><td class="ministrytitle"><xsl:value-of select="text()"/></td><td width="1%" nowrap="true"><img src="{$logo}"/></td></tr></table></td>
			</tr>
			<tr>
			     <td width="100%" align="left"><br/></td>
			</tr>
		  </xsl:when>
		  <xsl:otherwise>
			<tr>
			     <td width="100%" align="left"><table border="0"><tr><td class="ministrytitle"><xsl:value-of select="text()"/></td><td width="1%" nowrap="true"><img src="../images/ministries/generic.gif"/></td></tr></table></td>
			</tr>
			<tr>
			     <td width="100%" align="left"><br/></td>
			</tr>
		  </xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="overview"/>
</xsl:template>

<xsl:template match="overview">
		<tr>
			<td width="100%" class="tablecell" align="left" valign="top"><xsl:value-of select="text()"/></td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
</xsl:template>

<xsl:template match="ministry-logo">
</xsl:template>


<xsl:template match="long-description">
		<tr>
			<td width="100%" class="tableheader" align="left" valign="top" nowrap="true">Details</td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
		<tr>
			<td width="100%" class="tablecell" align="left" valign="top"><xsl:apply-templates/></td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
</xsl:template>

<xsl:template match="contacts">
		<tr>
			<td width="100%" class="tableheader" align="left" valign="top" nowrap="true">On the Horizon...</td>
		</tr>

		<tr>
			<td width="100%" class="tablecell" align="left" valign="top" nowrap="true"><br/></td>
		</tr>

		<tr>
			<td width="100%" class="tablecell" align="left" valign="top" nowrap="true">Here are some upcoming events...</td>
		</tr>

		<tr>
			<td width="100%" class="tablecell" align="left" valign="top" nowrap="true"><br/></td>
		</tr>

		<xsl:for-each select="document('../calendar/calendar.xml')/content/calendar/event/ministries/ministry[@id=$ministryid]">
			<xsl:call-template name="event"/>
		</xsl:for-each>		
		
		<tr>
			<td width="100%" class="tablecell" align="left" valign="top" nowrap="true"><br/>
			</td>
		</tr>
		<tr>
			<td width="100%" class="tableheader" align="left" valign="top" nowrap="true">For More Information</td>
		</tr>
		<xsl:apply-templates select="contact-email"/>
		<xsl:apply-templates select="contact-web"/>
		<xsl:apply-templates select="contact-phone"/>
		<tr>
			<td><br/></td>
		</tr>
</xsl:template>

<xsl:template match="contact-phone">
  			<tr>
				<td width="100%" class="tablecell" align="left" valign="top"><xsl:value-of select="."/> : <xsl:value-of select="@phone"/> 
                     </td>
			</tr>
</xsl:template>

<xsl:template match="contact-email">
  			<tr>
				<td width="100%" class="tablecell" align="left" valign="top">Contact: 
				  <a>
				    <xsl:attribute name="href">mailto:<xsl:value-of select="@email"/></xsl:attribute>
                         <xsl:value-of select="."/>
                       </a>
                     </td>
			</tr>
</xsl:template>

<xsl:template match="contact-web">
  			<tr>
				<td width="100%" class="tablecell" align="left" valign="top">More Info: 
				  <a>
				    <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
                         <xsl:value-of select="."/>
                       </a>
				</td>
			</tr>
</xsl:template>

<xsl:template name="event">
		<tr>
			<td>
			<table width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td width="25%" class="tableheader" align="left" valign="top" nowrap="true"><xsl:value-of select="../../date"/></td>
					<td width="65%" class="tableheader" align="left" valign="top" nowrap="true" colspan="2"><xsl:value-of select="../../title"/></td>
					<td width="10%" class="tableheader" align="left" valign="top" nowrap="true" colspan="2"><br/></td>
				</tr>
				<tr>
					<td width="25%" align="left" valign="top"><xsl:value-of select="../../time"/></td>
					<td width="75%" align="left" valign="top" colspan="2">
						<xsl:choose>
							<xsl:when test="../../location != '' ">
				  			  Location: <xsl:value-of select="../../location"/>
							</xsl:when>
							<xsl:otherwise>
							   <br/>
							</xsl:otherwise>
						</xsl:choose>
				     </td>
				</tr>
				<tr>
					<td width="25%" align="left" valign="top"><br/></td>
					<td width="75%" align="left" valign="top" colspan="2"><span class="detail"><xsl:value-of select="../../detail"/></span></td>
				</tr>
			</table>
			</td>
		</tr>
		
		
</xsl:template>

</xsl:stylesheet>
