<?xml version="1.0"?>
    
<!-- 

	Schedule Calendar Page
	
	Processes the events  tag and its children tags.
	
	$Id: schedule.xsl,v 1.2 2002/07/10 15:41:46 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="events">
	<table>
		<xsl:if test="count(event[contains(@reoccur,'Sun')]) > 0">
			<tr>
				<td class="tableheader" colspan="3" align="left">Sunday</td>
			</tr>
			<xsl:for-each select="event[contains(@reoccur,'Sun')]">
			  <xsl:call-template name="event"/>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="count(event[contains(@reoccur,'Mon')]) > 0">
			<tr>
				<td class="tableheader" colspan="3" align="left">Monday</td>
			</tr>
			<xsl:for-each select="event[contains(@reoccur,'Mon')]">
			  <xsl:call-template name="event"/>
			</xsl:for-each>
		</xsl:if>


		<xsl:if test="count(event[contains(@reoccur,'Tue')]) > 0">
			<tr>
				<td class="tableheader" colspan="3" align="left">Tuesday</td>
			</tr>
			<xsl:for-each select="event[contains(@reoccur,'Tue')]">
			  <xsl:call-template name="event"/>
			</xsl:for-each>
		</xsl:if>


		<xsl:if test="count(event[contains(@reoccur,'Wed')]) > 0">
			<tr>
				<td class="tableheader" colspan="3" align="left">Wednesday</td>
			</tr>
			<xsl:for-each select="event[contains(@reoccur,'Wed')]">
			  <xsl:call-template name="event"/>
			</xsl:for-each>
		</xsl:if>


		<xsl:if test="count(event[contains(@reoccur,'Thu')]) > 0">
			<tr>
				<td class="tableheader" colspan="3" align="left">Thursday</td>
			</tr>
			<xsl:for-each select="event[contains(@reoccur,'Thu')]">
			  <xsl:call-template name="event"/>
			</xsl:for-each>
		</xsl:if>


		<xsl:if test="count(event[contains(@reoccur,'Fri')]) > 0">
			<tr>
				<td class="tableheader" colspan="3" align="left">Friday</td>
			</tr>
			<xsl:for-each select="event[contains(@reoccur,'Fri')]">
			  <xsl:call-template name="event"/>
			</xsl:for-each>
		</xsl:if>


		<xsl:if test="count(event[contains(@reoccur,'Sat')]) > 0">
			<tr>
				<td class="tableheader" colspan="3" align="left">Saturday</td>
			</tr>
			<xsl:for-each select="event[contains(@reoccur,'Sat')]">
			  <xsl:call-template name="event"/>
			</xsl:for-each>
		</xsl:if>

	</table>
</xsl:template>

<xsl:template name="event">
		<tr>
			<td width="20%" align="left" valign="top"><xsl:value-of select="@time"/></td>
			<td width="60%" align="left" valign="top"><div class="textbold"><xsl:value-of select="title"/></div><xsl:if test="@childCare = 'yes'"><div class="textemphasis">Childcare provided</div></xsl:if><xsl:if test="@childMinistry = 'yes'"><div class="textemphasis">Child care provided</div></xsl:if></td>
			<td width="20%" align="right" valign="top"><xsl:value-of select="@location"/></td>
		</tr>
		<tr colspan="3">
			<td><br/></td>
		</tr>
</xsl:template>

<xsl:template match="intro">
	<xsl:apply-templates select="*|@*|text()"/>
</xsl:template>

</xsl:stylesheet>
