<?xml version="1.0"?>
    
<!-- 

	Staff Template
	
	Uses the servants.xml, finding only those servants who are flagged as staff members and generates a second 
	xml file.
	
	$Id: staff.xsl,v 1.4 2004/07/02 20:57:33 premav Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>

<xsl:include href="html.xsl"/>

<xsl:template match="stafflist">
	<table width="100%">
		<tr>
			<td colspan="10" class="tableheader">Meet Our Staff</td>
		</tr>
		<tr><td><br/></td></tr>
		<xsl:for-each select="servant">
		<tr>
		<xsl:choose>
			<!-- 
				The hardest part of the template: put Pastor Allen in the center top, the even number on the left, 
				odd number on the right. When the foreach loop comes around for the odd, ignore it since the 
				even number processes even and even +1.
			-->
			<xsl:when test="position()=1" >
  		         <xsl:variable name="curr"><xsl:value-of select="position()"/></xsl:variable>
				<td colspan="2"><br/></td>
				<td colspan="2" width="40%" align="center" class="textsubtitle">
			    <xsl:element name="img">
  	                    <xsl:attribute name="src"><xsl:value-of select="thumbnail/@href"/></xsl:attribute>
  	                    <xsl:attribute name="alt"><xsl:value-of select="fullname"/></xsl:attribute>
  	                    </xsl:element>

  	                    <br/>
			    <A HREF="{first-name}.html">
				    <xsl:value-of select="first-name"/><xsl:text> </xsl:text>
				    <xsl:value-of select="last-name"/>
			    </A>
			    <br/>

			    <xsl:apply-templates select="role/@title"/><br/></td>
				<td colspan="2"><br/></td>
				<td colspan="2" width="10%" class="textsubtitle"><img src="{../servant[($curr+1)]/thumbnail/@href}" alt="{../servant[($curr+1)]/fullname}"/>

  	                    <br/>
					<A HREF="{../servant[($curr+1)]/first-name}.html">
					<xsl:apply-templates select="../servant[($curr+1)]/first-name"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="../servant[($curr+1)]/last-name"/></A>
					<br/>
					<xsl:value-of select="../servant[($curr+1)]/role/@title"/><br/></td>
				<td colspan="2"><br/></td>
			</xsl:when>

		<!--from 2nd row onwards-->
			<xsl:when test="position() mod 2 = 1">
  		         <xsl:variable name="curr"><xsl:value-of select="position()"/></xsl:variable>
				<td colspan="1" width="10%">
			<!--image of the 1st staff member in column 1 -->
				  <xsl:element name="img">
  	                    <xsl:attribute name="src"><xsl:value-of select="thumbnail/@href"/></xsl:attribute>
  	                    <xsl:attribute name="alt"><xsl:value-of select="fullname"/></xsl:attribute>
  	                    </xsl:element>
				</td>
			<!--first and last name in 2nd and 3rd columns of the 1st staff member-->
				<td colspan="2" align="left" class="textsubtitle">
					<A HREF="{first-name}.html">
						<xsl:value-of select="first-name"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="last-name"/></A>
				   <br/>
				   <xsl:apply-templates select="role/@title"/>
				   <br/>
			   </td>
<!--
			<td colspan="2" align="left" class="textsubtitle"><xsl:apply-templates select="fullname"/><br/><xsl:apply-templates select="role/@title"/><br/></td>
-->
			<!-- br in 4th,5th,6th,7th columns -->
				<td colspan="4" class="textsubtitle"><br/></td>
			<!-- first and last name in 8th, 9th columns of the 2nd staff member-->
				<td colspan="2" align="right" class="textsubtitle">
					<A HREF="{../servant[($curr+1)]/first-name}.html">
					<xsl:apply-templates select="../servant[($curr+1)]/first-name"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="../servant[($curr+1)]/last-name"/></A>
					<br/>
					<xsl:value-of select="../servant[($curr+1)]/role/@title"/><br/>
				</td>
<!--
					<xsl:apply-templates select="../servant[($curr+1)]/fullname"/><br/><xsl:value-of select="../servant[($curr+1)]/@title"/><br/></td>
-->
			<!--image in 10th column of the 2nd staff member-->
				<td colspan="1" width="10%"><img src="{../servant[($curr+1)]/thumbnail/@href}" alt="{../servant[($curr+1)]/fullname}"/></td>
			</xsl:when>

			<xsl:otherwise>
			</xsl:otherwise>
			
		</xsl:choose>
		
		</tr>
		</xsl:for-each>
	</table>
</xsl:template>


</xsl:stylesheet>
