<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>
<!--xsl:template match="/">
<xsl:apply-templates/>
</xsl:template-->
<xsl:include href="html.xsl"/>
<xsl:template match="staffulltime">
<table width="100%">
<tr>
	<td colspan="3" align="center" class="tableheader">
                Meet Our Staff<br/><br/>
        </td>
	<td colspan="1">
		Click here for - <br/>	
		<a href="#parttime">Part-time Staff Members</a><br/>
		<a href="#elder">Elders</a><br/>
        </td>
</tr>
<tr>
        <td colspan="4" >
               <br/><hr/>
        </td>
</tr>
<tr><td colspan="4" class="tableheader">Full-time Staff Members<br/></td></tr>
<tr>
	<xsl:for-each select="servant">
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
	</xsl:if>
	</xsl:for-each>
</tr>
<xsl:for-each select="servant">
<xsl:if test="position() mod 4 =3">
<xsl:variable name="curr" select="position()"/>
<xsl:variable name="total" select="9"/>
<tr>
 <td colspan="1" width="30%" class="textsubtitle">
                        <!--xsl:value-of select="$curr"/-->
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

                                <xsl:variable name="actualcurr" select="$curr+1"/>
                                <!--xsl:value-of select="$actualcurr"/-->
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
                                <!--xsl:value-of select="$actualcurr"/-->
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
                                <!--xsl:value-of select="$actualcurr"/-->
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
</tr>
</xsl:if>
</xsl:for-each>
<tr>
	<td colspan="4">
		<hr/>
	</td>
</tr>
</table>
</xsl:template>



<xsl:template match="staffparttime">
<a name="#parttime"></a> 
<table width="100%">
<tr><td colspan="4" class="tableheader">Part-time Staff Members<br/></td></tr>
<xsl:for-each select="servant">
<xsl:if test="position() mod 4 =1">
<xsl:variable name="curr" select="position()"/>
<xsl:variable name="total" select="2"/>
<tr>
 <td colspan="1" width="30%" class="textsubtitle">
                        <!--xsl:value-of select="$curr"/-->
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

                                <xsl:variable name="actualcurr" select="$curr+1"/>
	                        <!--xsl:value-of select="$actualcurr"/-->
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
                                <!--xsl:value-of select="$actualcurr"/-->
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
                                <!--xsl:value-of select="$actualcurr"/-->
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

</tr>
</xsl:if>
</xsl:for-each>
<tr><td colspan="4"><hr/></td></tr>
</table>
</xsl:template>

<xsl:template match="elder">
<a name="#elder"></a>
<table width="100%">
<tr><td colspan="4" class="tableheader">Elders<br/></td></tr>
<xsl:for-each select="servant">
<xsl:if test="position() mod 4 =1">
<xsl:variable name="curr" select="position()"/>
<xsl:variable name="total" select="6"/>
<tr>
 <td colspan="1" width="30%" class="textsubtitle">
                        <!--xsl:value-of select="$curr"/-->
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

                                <xsl:variable name="actualcurr" select="$curr+1"/>
                                <!--xsl:value-of select="$actualcurr"/-->
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
                                <!--xsl:value-of select="$actualcurr"/-->
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
                                <!--xsl:value-of select="$actualcurr"/-->
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

</tr>
</xsl:if>
</xsl:for-each>
</table>
</xsl:template>



</xsl:stylesheet>
