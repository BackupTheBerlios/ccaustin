<?xml version="1.0"?>
    
<!-- 

	Staff Template
	
	Uses the servants.xml, finding only those servants who are flagged as staff members and generates a second 
	xml file.
	
	$Id: staff.xsl,v 1.6 2004/07/07 18:03:39 premav Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>

<xsl:include href="html.xsl"/>
<!--xsl:template name="horizontaline">
<xsl:param name="endof"/>
</xsl:template-->

<xsl:template match="stafflist">
<xsl:variable name="total" select="count(servant)"/>
<!--xsl:value-of select="$totalfulltime"/-->
	<table width="100%">
		<tr>
			<td colspan="4"  class="tableheader">
				Meet Our Staff
			</td>
		</tr>
		<tr>
			<td colspan="4" >
				<br/>
			</td>
		</tr>
		<xsl:for-each select="servant">
			<!--xsl:call-template name="horizontaline">
			<xsl:with-param name="endof" select="1"/>
			</xsl:call-template-->
		<tr>

			<xsl:if test="position()=1" >
  		        <xsl:variable name="curr">
				<xsl:value-of select="position()"/>
			</xsl:variable>
			<td colspan="1" width="30%">
				<xsl:text> </xsl:text>
			</td>
			<td colspan="1" width="30%" class="textsubtitle">
			    <xsl:element name="img">
  	                	    <xsl:attribute name="src">
					<xsl:value-of select="thumbnail/@href"/>
				    </xsl:attribute>
  	                    	    <xsl:attribute name="alt">
					<xsl:value-of select="fullname"/>
				    </xsl:attribute>
  	                    </xsl:element>
	                    <br/>
			    <A HREF="{first-name}.html">
				    <xsl:value-of select="first-name"/>
				    <xsl:text> </xsl:text>
				    <xsl:value-of select="last-name"/>
			    </A>
			    <br/>
			    <xsl:apply-templates select="role/@title"/>
			    <br/>
			</td>
			<td colspan="1" width="30%" class="textsubtitle">
				<img src="{../servant[($curr+1)]/thumbnail/@href}" alt="{../servant[($curr+1)]/fullname}"/>
  	                    	<br/>
				<A HREF="{../servant[($curr+1)]/first-name}.html">
					<xsl:apply-templates select="../servant[($curr+1)]/first-name"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates select="../servant[($curr+1)]/last-name"/>
				</A>
				<br/>
				<xsl:value-of select="../servant[($curr+1)]/role/@title"/>
				<br/>
			</td>
			<td colspan="1" width="30%">
				<xsl:text> </xsl:text>
			</td>
			<!--xsl:call-template name="horizontaline">
			<xsl:with-param name="endof" select="0"/>
			</xsl:call-template-->
		</xsl:if>
		<!--xsl:choose-->
		 <!--from 2nd row onwards-->
		 <xsl:if test="position() mod 2 = 1 and position() mod 4 = 3">
        	 	<xsl:variable name="curr">
 				<xsl:value-of select="position()"/>
			</xsl:variable>
			 <td colspan="1" width="30%" class="textsubtitle">
			 	<!--image of the 1st staff member in column 1 -->
			 	<xsl:element name="img">
  	        			 <xsl:attribute name="src">
						<xsl:value-of select="thumbnail/@href"/>
					 </xsl:attribute>
  			                 <xsl:attribute name="alt">
						<xsl:value-of select="fullname"/>
					 </xsl:attribute>
		  	        </xsl:element>
				<br/>
				<A HREF="{first-name}.html">
					<xsl:value-of select="first-name"/>
						<xsl:text> </xsl:text>
					<xsl:value-of select="last-name"/>
				</A>
				<br/>
				<xsl:apply-templates select="role/@title"/>
				<br/>
	        	</td>
			<td colspan="1" width="30%" class="textsubtitle">
				<!--xsl:value-of select="$curr+1"/>
				<xsl:value-of select="$total"/-->

				<xsl:variable name="actualcurr" select="$curr+1"/>
				<xsl:if test="$actualcurr &lt;= $total">
				 <img src="{../servant[($curr+1)]/thumbnail/@href}" alt="{../servant[($curr+1)]/fullname}"/>
				 <br/>
                                 <A HREF="{../servant[($curr+1)]/first-name}.html">
					<xsl:apply-templates select="../servant[($curr+1)]/first-name"/>
						<xsl:text> </xsl:text>
					<xsl:apply-templates select="../servant[($curr+1)]/last-name"/>
				 </A>
				 <br/>
				 <xsl:value-of select="../servant[($curr+1)]/role/@title"/>
				 <br/>
				</xsl:if>
			</td>
			<td colspan="1" width="30%" class="textsubtitle">
				<xsl:variable name="actualcurr" select="$curr+2"/>
				<xsl:if test="$actualcurr &lt;= $total">
				 <img src="{../servant[($curr+2)]/thumbnail/@href}" alt="{../servant[($curr+2)]/fullname}"/>
				 <br/>
                                 <A HREF="{../servant[($curr+2)]/first-name}.html">
					<xsl:apply-templates select="../servant[($curr+2)]/first-name"/>
						<xsl:text> </xsl:text>
					<xsl:apply-templates select="../servant[($curr+2)]/last-name"/>
				 </A>
				 <br/>
				 <xsl:value-of select="../servant[($curr+2)]/role/@title"/>
				 <br/>
				</xsl:if>
			</td>
			<td colspan="1" width="30%" class="textsubtitle">
				<xsl:variable name="actualcurr" select="$curr+3"/>
				<xsl:if test="$actualcurr &lt;= $total">
				 <img src="{../servant[($curr+3)]/thumbnail/@href}" alt="{../servant[($curr+3)]/fullname}"/>
				 <br/>
                                 <A HREF="{../servant[($curr+3)]/first-name}.html">
					<xsl:apply-templates select="../servant[($curr+3)]/first-name"/>
						<xsl:text> </xsl:text>
					<xsl:apply-templates select="../servant[($curr+3)]/last-name"/>
				 </A>
				 <br/>
				 <xsl:value-of select="../servant[($curr+3)]/role/@title"/>
				 <br/>
				</xsl:if>
			</td>
			<!--xsl:value-of select="$curr = $curr + 2"/-->
			<!--xsl:call-template name="horizontaline">
			<xsl:with-param name="endof" select="0"/>
			</xsl:call-template-->
		</xsl:if>

		<!--xsl:otherwise>
		</xsl:otherwise>

		</xsl:choose-->
	<!--xsl:call-template name="horizontaline"-->
	<!--xsl:value-of select="4444"/-->
	<!--/xsl:call-template-->
	</tr>
	<!--xsl:call-template name="horizontaline">
	<xsl:if test="$endof=0">	
	<tr><td colspan="4" width="100%"><hr/></td></tr>
	</xsl:if>
	</xsl:call-template-->
	</xsl:for-each>

	</table>
</xsl:template>

</xsl:stylesheet>
