<?xml version="1.0"?>
    
<!-- 

	Calendar Page
	
	Processes the calendar tag and its children tags.
	
	$Id: calendar.xsl,v 1.2 2003/05/27 22:36:26 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="html.xsl"/>

<xsl:template match="calendar">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
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
  <xsl:choose>
    <xsl:when test="@date &gt;= $DATE">
         <tr>
           <a name="{@id}"/>
           <td width="25%" class="heading" align="left" valign="top" nowrap="true"><xsl:value-of select="date"/></td>
           <td width="65%" class="heading" align="left" valign="top" nowrap="true" colspan="2"><xsl:value-of select="title"/></td>
           <td width="10%" class="heading" align="left" valign="top" nowrap="true" colspan="2"><br/></td>
         </tr>
         <xsl:choose>
           <xsl:when test="(location != '') and (time != '')">
             <tr>
               <td width="25%" align="left" valign="top"><xsl:value-of select="time"/></td>
               <td width="75%" align="left" valign="top" colspan="2">
               <xsl:choose>
                 <xsl:when test="location != '' ">
                   Location: <xsl:value-of select="location"/>
               </xsl:when>
               <xsl:otherwise>
                 <br/>
               </xsl:otherwise>
             </xsl:choose>
           </td>
         </tr>
       </xsl:when>
       <xsl:otherwise>
       </xsl:otherwise>
     </xsl:choose>
     <tr>
       <td width="75%" align="left" valign="top" colspan="3"><p><xsl:apply-templates select="detail"/></p></td>
     </tr>
     <tr colspan="3">
       <td><br/></td>
     </tr>
     
  </xsl:when>
  <xsl:otherwise>
  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
