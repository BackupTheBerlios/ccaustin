<?xml version="1.0"?>
    
<!-- 

	Events Calendar Page
	
	Processes the calendar tag and its children tags.
	
	$Id: events.xsl,v 1.1 2002/01/31 03:25:34 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="calendar">
	<table border="0" cellspacing="0">
		<xsl:apply-templates select="calendarEvent"/>
	</table>
</xsl:template>

<xsl:template match="calendarEvent">
		<tr>
			<td width="10%" class="tableheader" align="left" valign="top" nowrap="true"><xsl:value-of select="@day"/></td>
			<td width="80%" class="tableheader" align="left" valign="top"><br/></td>
			<td width="10%" class="tableheader" align="right" valign="top" nowrap="true"><xsl:value-of select="@date"/></td>
		</tr>
		<xsl:apply-templates select="event"/>
		<tr colspan="3">
			<td><br/></td>
		</tr>
</xsl:template>

<xsl:template match="event">
	<!-- if scheduleRefId exists, load in the reference -->
	<xsl:choose>
	<xsl:when test="@scheduleRefId != '' ">
	
	    <!-- 
	      This is the ugly part - each field needs to be checked for a local override. 
	       If found in the events.xml, use that value rather than the value found in schedule.xml 
		
		We want to store the current values in variables, since once we enter the document('') scope,
		we lose context to our old variables. There may be a way to get back, but not sure.. So, here we
		go....
	    -->
	  <xsl:variable name="refid" select="@scheduleRefId"/>
	  <xsl:variable name="overridetitle" select="title"/>
	  <xsl:variable name="overridedetail" select="detail"/>
	  <xsl:variable name="overridetime" select="@time"/>
	  <xsl:variable name="overridelocation" select="@location"/>
	  
	    <xsl:for-each select="document('schedule.xml')//*[@id=$refid]">
		<tr>
			<td width="10%" align="left" valign="top">
				  <xsl:choose>
					<xsl:when test="$overridetime!= '' ">
					  <xsl:value-of select="$overridetime"/>
					</xsl:when>
					<xsl:otherwise>
					  <xsl:value-of select="@time"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td width="80%" align="left" valign="top">

				  <xsl:choose>
					<xsl:when test="$overridetitle != '' ">
					  <br/><span class="title"><xsl:value-of select="$overridetitle"/></span>
					</xsl:when>
					<xsl:otherwise>
					  <span class="title"><xsl:apply-templates select="title"/></span>
					</xsl:otherwise>
				</xsl:choose>

     		      </td>
			<td width="10%" align="right" valign="top">
				  <xsl:choose>
					<xsl:when test="$overridelocation != '' ">
					  <br/><span class="title"><xsl:value-of select="$overridelocation"/></span>
					</xsl:when>
					<xsl:otherwise>
					  <span class="title"><xsl:apply-templates select="@location"/></span>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		<tr>
			<td width="10%" align="left" valign="top"><br/></td>
			<td width="90%" colspan="2" align="left" valign="top">

				  <xsl:choose>
					<xsl:when test="$overridedetail != '' ">
					  <p/><span class="detail"><xsl:value-of select="$overridedetail"/></span>
					</xsl:when>
					<xsl:otherwise>
					  <span class="detail"><xsl:apply-templates select="detail"/></span>
					</xsl:otherwise>
				</xsl:choose>
				
			   </td>
		</tr>
		<tr colspan="3">
			<td><br/></td>
		</tr>
	    </xsl:for-each>
	</xsl:when>

	<!-- else, process what is provided in the current XML file -->
	<xsl:otherwise>
		<tr>
			<td width="10%" align="left" valign="top"><xsl:value-of select="@time"/></td>
			<td width="80%" align="left" valign="top"><span class="title"><xsl:apply-templates select="title"/></span></td>
			<td width="10%" align="right" valign="top"><span class="title"><xsl:value-of select="@location"/></span></td>
		</tr>
		<tr>
			<td width="10%" align="left" valign="top"><br/></td>
			<td width="90%" align="left" valign="top" colspan="2"><span class="detail"><xsl:apply-templates select="detail"/></span></td>
		</tr>
	</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<xsl:template match="detail">
	<xsl:apply-templates select="text"/>
</xsl:template>

</xsl:stylesheet>
