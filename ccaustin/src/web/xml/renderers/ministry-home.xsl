<?xml version="1.0"?>
    
<!-- 

	Ministry Home Page
	
	Processes the ministry tag and its children tags
	
	$Id: ministry-home.xsl,v 1.1 2002/12/13 20:04:06 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="html.xsl"/>

<xsl:variable name="ministryid"><xsl:value-of select="content/ministry/@id"/></xsl:variable>

<xsl:template match="ministry">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<xsl:apply-templates/>
	</table>
</xsl:template>

<xsl:template match="name">
      <xsl:variable name="logo"><xsl:value-of select="../ministry-logo"/></xsl:variable>
          <xsl:choose>
		  <xsl:when test="$logo != '' ">
			<tr>
                          <td width="100%" align="left"><table border="0"><tr><td class="ministrytitle"><p><xsl:value-of select="text()"/></p></td><td width="1%" nowrap="true"><img src="{$logo}"/></td></tr></table></td>
			</tr>
			<tr>
			     <td width="100%" align="left"><br/></td>
			</tr>
		  </xsl:when>
		  <xsl:otherwise>
			<tr>
                          <td width="100%" align="left"><table border="0"><tr><td class="ministrytitle"><p><xsl:value-of select="text()"/></p></td><td width="1%" nowrap="true"><img src="../images/ministries/generic.gif"/></td></tr></table></td>
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
                  <td width="100%" class="tablecell" align="left" valign="top"><p><xsl:value-of select="text()"/></p></td>
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
                  <td width="100%" class="tablecell" align="left" valign="top"><p><xsl:apply-templates/></p></td>
		</tr>
		<tr>
			<td><br/></td>
		</tr>
</xsl:template>

<xsl:template match="contacts">
  <xsl:if test="count(document('../../xml/calendar/calendar.xml')/content/calendar/event/ministries/ministry[@id=$ministryid]) > 0">
          <tr>
            <td>
              <table border="0" cellpadding="0" cellspacing="0" width="75%">
		<tr>
			<td width="100%" class="tableheader" align="left" valign="top" nowrap="true" colspan="2">On the Horizon...</td>
		</tr>
                
                <xsl:for-each select="document('../../src/web/xml/calendar/calendar.xml')/content/calendar/event/ministries/ministry[@id=$ministryid]">
                  <xsl:sort select="../../@date"/>
                  <xsl:call-template name="event"/>
		</xsl:for-each>		
              </table>
            </td>
          </tr>
		
		</xsl:if>
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
                          <td width="100%" class="tablecell" align="left" valign="top"><p><xsl:value-of select="."/> : <xsl:value-of select="@phone"/></p> 
                     </td>
			</tr>
</xsl:template>

<xsl:template match="contact-email">
  			<tr>
				<td width="100%" class="tablecell" align="left" valign="top"><p>Contact: 
				  <a>
				    <xsl:attribute name="href">mailto:<xsl:value-of select="@email"/></xsl:attribute>
                         <xsl:value-of select="."/>
                       </a>
                     </p></td>
			</tr>
</xsl:template>

<xsl:template match="contact-web">
  			<tr>
				<td width="100%" class="tablecell" align="left" valign="top"><p>More Info: 
				  <a>
				    <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
                         <xsl:value-of select="."/>
                       </a>
                     </p></td>
			</tr>
</xsl:template>

<xsl:template name="event">
  <xsl:choose>
    <xsl:when test="../../@date &gt;= $DATE">
         <tr>
           <td width="25%" class="heading" align="left" valign="top" nowrap="true"><xsl:value-of select="../../date"/></td>
           <td width="65%" class="heading" align="left" valign="top" nowrap="true" colspan="2"><xsl:value-of select="../../title"/></td>
           <td width="10%" class="heading" align="left" valign="top" nowrap="true" colspan="2"><br/></td>
         </tr>
         <xsl:choose>
           <xsl:when test="(../../location != '') and (../../time != '')">
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
       </xsl:when>
       <xsl:otherwise>
       </xsl:otherwise>
     </xsl:choose>
     <tr>
       <td width="75%" align="left" valign="top" colspan="3"><xsl:value-of select="../../detail"/></td>
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
