<?xml version="1.0"?>
    
<!-- 

	Calendar Page
	
	Processes the calendar tag and its children tags.
	
	$Id: calendar.xsl,v 1.1 2002/05/24 00:03:07 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="calendar">
	<table border="0" cellspacing="0" width="100%">
		<tr>
			<td width="100%" class="heading" align="left" valign="top" nowrap="true" colspan="3">Upcoming Events</td>
		</tr>
		<tr>
			<td width="100%" class="tablecell" align="left" valign="top" nowrap="true" colspan="3"><br/></td>
		</tr>
		<xsl:apply-templates>
			<xsl:sort select="@date"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template match="event">
		<tr>
			<td width="20%" class="tableheader" align="left" valign="top" nowrap="true"><xsl:value-of select="date"/></td>
			<td width="80%" class="tableheader" align="left" valign="top" nowrap="true" colspan="2"><xsl:value-of select="title"/></td>
		</tr>
		<tr>
			<td width="20%" align="left" valign="top"><xsl:value-of select="time"/></td>
			<td width="80%" align="left" valign="top" colspan="2"><span class="title">
				<xsl:choose>
					<xsl:when test="location != '' ">
		  			  Location: <xsl:value-of select="location"/>
					</xsl:when>
					<xsl:otherwise>
					   <br/>
					</xsl:otherwise>
				</xsl:choose>
		     </span></td>
		</tr>
		<tr>
			<td width="20%" align="left" valign="top"><br/></td>
			<td width="80%" align="left" valign="top" colspan="2"><span class="detail"><xsl:value-of select="detail"/></span></td>
		</tr>
		<tr colspan="3">
			<td><br/></td>
		</tr>
</xsl:template>

</xsl:stylesheet>
