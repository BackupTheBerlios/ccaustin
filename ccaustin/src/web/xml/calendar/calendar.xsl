<?xml version="1.0"?>
    
<!-- 

	Calendar Page
	
	Processes the calendar tag and its children tags.
	
	$Id: calendar.xsl,v 1.3 2002/07/07 23:25:38 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:param name="DATE">00000000</xsl:param>

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
  <xsl:choose>
    <xsl:when test="@date &gt;= $DATE">
         <tr>
           <td width="25%" class="tableheader" align="left" valign="top" nowrap="true"><p><xsl:value-of select="date"/></p></td>
           <td width="65%" class="tableheader" align="left" valign="top" nowrap="true" colspan="2"><p><xsl:value-of select="title"/></p></td>
           <td width="10%" class="tableheader" align="left" valign="top" nowrap="true" colspan="2"><br/></td>
         </tr>
         <xsl:choose>
           <xsl:when test="(location != '') and (time != '')">
             <tr>
               <td width="25%" align="left" valign="top"><p><xsl:value-of select="time"/></p></td>
               <td width="75%" align="left" valign="top" colspan="2"><p>
               <xsl:choose>
                 <xsl:when test="location != '' ">
                   Location: <xsl:value-of select="location"/>
               </xsl:when>
               <xsl:otherwise>
                 <br/>
               </xsl:otherwise>
             </xsl:choose>
           </p></td>
         </tr>
       </xsl:when>
       <xsl:otherwise>
       </xsl:otherwise>
     </xsl:choose>
     <tr>
       <td width="75%" align="left" valign="top" colspan="3"><p><xsl:value-of select="detail"/></p></td>
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
