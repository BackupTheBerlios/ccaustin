<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:months="Lookup table for months">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<months:name sequence="01">Jan</months:name>
<months:name sequence="02">Feb</months:name>
<months:name sequence="03">Mar</months:name>
<months:name sequence="04">Apr</months:name>
<months:name sequence="05">May</months:name>
<months:name sequence="06">Jun</months:name>
<months:name sequence="07">Jul</months:name>
<months:name sequence="08">Aug</months:name>
<months:name sequence="09">Sep</months:name>
<months:name sequence="10">Oct</months:name>
<months:name sequence="11">Nov</months:name>
<months:name sequence="12">Dec</months:name>

<xsl:template name="msgCatHead">
    <xsl:param name="pcategorytitle"/>
    <TABLE cellspacing="3" cellpadding="2" BORDER="0" WIDTH="100%">
	<TR>
	  <TD ALIGN="left"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA">
	    To hear Allen's <xsl:value-of select="$pcategorytitle"/> archive teachings via RealAudio<SUP>(R)</SUP> 
	    for a 28.8 modem then click on the message title hyperlink.  If you don't have a 
	    player, click on the download icon to the right to visit the Real Networks 
	    site.
	  </FONT></TD>
	  <TD ALIGN="right"><A HREF="http://www.real.com"><IMG SRC="../images/freeplayer_g2.gif" BORDER="0"/></A></TD>
	</TR>
	<TR>
	  <TD COLSPAN="2" ALIGN="right"><IMG SRC="../images/underbar.gif" border="0"/><BR/></TD>
	</TR>
    </TABLE>
</xsl:template>

<xsl:template name="msgCatAudioSwitcher">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pcategory"/>
    <xsl:param name="pneedfirstaudio"/>

    <!--  Book list  -->
    <BR/><xsl:value-of select="$pcategorytitle"/><xsl:text> - </xsl:text>
	<xsl:for-each select="message[@category=$pcategory]">
	    <xsl:sort select="seriestitle" order="ascending"/>
	    <xsl:sort select="@date" data-type="number" order="ascending"/>
        <xsl:variable name="lastSeries" select="seriestitle"/>
        <xsl:if test="seriestitle != preceding-sibling::message[1]/seriestitle">
            <xsl:if test="$pneedfirstaudio = 1">
                <xsl:if test="string(audio) != ''">
                    <xsl:if test="position() != 1">
                        <xsl:text> | </xsl:text>
                    </xsl:if>
                    <A><xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="seriestitle"/></xsl:attribute><xsl:value-of select="seriestitle"/>
                    </A>
                </xsl:if>
            </xsl:if>
            <xsl:if test="$pneedfirstaudio != 1">
                <xsl:if test="position() != 1">
                    <xsl:text> | </xsl:text>
                </xsl:if>
                <A><xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="seriestitle"/></xsl:attribute><xsl:value-of select="seriestitle"/>
                </A>
            </xsl:if>
        </xsl:if>
	</xsl:for-each>
    <BR/>
</xsl:template>

<xsl:template name="msgCatTapeSwitcher">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pcategory"/>
    <xsl:param name="pneedfirsttape"/>

    <!--  Book list  -->
    <BR/><xsl:value-of select="$pcategorytitle"/><xsl:text> - </xsl:text>
	<xsl:for-each select="message[@category=$pcategory]">
	    <xsl:sort select="seriestitle" order="ascending"/>
	    <xsl:sort select="@date" data-type="number" order="ascending"/>
        <xsl:variable name="lastSeries" select="seriestitle"/>
        <xsl:if test="seriestitle != preceding-sibling::message[1]/seriestitle">
            <xsl:if test="$pneedfirsttape = 1">
                <xsl:if test="string(tape) != ''">
                    <xsl:if test="position() != 1">
                        <xsl:text> | </xsl:text>
                    </xsl:if>
                    <A><xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="seriestitle"/></xsl:attribute><xsl:value-of select="seriestitle"/>
                    </A>
                </xsl:if>
            </xsl:if>
            <xsl:if test="$pneedfirsttape != 1">
                <xsl:if test="position() != 1">
                    <xsl:text> | </xsl:text>
                </xsl:if>
                <A><xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="seriestitle"/></xsl:attribute><xsl:value-of select="seriestitle"/>
                </A>
            </xsl:if>
        </xsl:if>
	</xsl:for-each>
    <BR/>
</xsl:template>

<xsl:template name="msgCatSwitcherNS">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pcategory"/>

    <!--  Book list  -->
    <BR/><xsl:value-of select="$pcategorytitle"/><xsl:text> - </xsl:text>
	<xsl:for-each select="message[@category=$pcategory]">
	    <xsl:sort select="@date" data-type="number" order="ascending"/>
        <xsl:variable name="lastSeries" select="seriestitle"/>
        <xsl:if test="seriestitle != preceding-sibling::message[1]/seriestitle">
            <xsl:if test="position() != 1">
                <xsl:text> | </xsl:text>
            </xsl:if>
            <A><xsl:attribute name="href"><xsl:text>#</xsl:text><xsl:value-of select="seriestitle"/></xsl:attribute><xsl:value-of select="seriestitle"/>
            </A>
        </xsl:if>
	</xsl:for-each>
    <BR/>
</xsl:template>

<xsl:template name="msgCatAudioEntry">
    <xsl:if test="string(audio) != ''">
        <A><xsl:attribute name="href">http://www.calvarychapel.org/austin/audio/<xsl:value-of select="audio"/></xsl:attribute>
        <xsl:if test="string(passage) != ''">
            <xsl:value-of select="passage"/>
            <xsl:if test="string(title) != ''">
                <xsl:text> - </xsl:text><xsl:value-of select="title"/>
            </xsl:if>
        </xsl:if>
        <xsl:if test="string(passage) = ''">
            <xsl:value-of select="title"/>
        </xsl:if>
        </A>
    </xsl:if>
    <xsl:if test="string(audio) = ''">
        <xsl:if test="string(passage) != ''">
            <xsl:value-of select="passage"/>
            <xsl:if test="string(title) != ''">
                <xsl:text> - </xsl:text><xsl:value-of select="title"/>
            </xsl:if>
        </xsl:if>
        <xsl:if test="string(passage) = ''">
            <xsl:value-of select="title"/>
        </xsl:if>
        <xsl:text> *</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template name="msgCatAudioGroup">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pneedaudio"/>
    <xsl:param name="lastSeries"/>
    <xsl:param name="pcategory"/>
    <BR/><HR/>
    <A><xsl:attribute name="name"><xsl:value-of select="seriestitle"/></xsl:attribute><B><xsl:value-of select="seriestitle"/><xsl:text> - </xsl:text><xsl:value-of select="$pcategorytitle"/></B></A>
    <BR/><BR/>
    <UL>
	<xsl:for-each select="/messagecatalog/message[seriestitle=$lastSeries]">
	<xsl:sort select="@date" data-type="number" order="ascending"/>
        <xsl:if test="$pcategory = @category">
            <xsl:if test="$pneedaudio != 1">
                <li>
                    <xsl:call-template name="msgCatAudioEntry">
                    </xsl:call-template>
                </li>
            </xsl:if>
            <xsl:if test="$pneedaudio = 1">
                <xsl:if test="string(audio) != ''">
                    <li>
                        <xsl:call-template name="msgCatAudioEntry">
                        </xsl:call-template>
                    </li>
                </xsl:if>
            </xsl:if>
        </xsl:if>
	</xsl:for-each>
    </UL>
</xsl:template>

<xsl:template name="msgCatAudioSeries">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pcategory"/>
    <xsl:param name="pneedaudio"/>
    <xsl:param name="pneedfirstaudio"/>
    <!--  For each of the book studies  -->
	<xsl:for-each select="message[@category=$pcategory]">
	    <xsl:sort select="seriestitle" order="ascending"/>
        <xsl:variable name="lastSeries" select="seriestitle"/>
        <xsl:if test="seriestitle != preceding-sibling::message[1]/seriestitle">
            <xsl:if test="$pneedfirstaudio = 1">
                <xsl:if test="string(audio) != ''">
                    <xsl:call-template name="msgCatAudioGroup">
                        <xsl:with-param name="pcategorytitle" select="$pcategorytitle"/>
                        <xsl:with-param name="pcategory" select="$pcategory"/>
                        <xsl:with-param name="pneedaudio" select="$pneedaudio"/>
                        <xsl:with-param name="lastSeries" select="$lastSeries"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:if>
            <xsl:if test="$pneedfirstaudio != 1">
                <xsl:call-template name="msgCatAudioGroup">
                    <xsl:with-param name="pcategorytitle" select="$pcategorytitle"/>
                    <xsl:with-param name="pcategory" select="$pcategory"/>
                    <xsl:with-param name="pneedaudio" select="$pneedaudio"/>
                    <xsl:with-param name="lastSeries" select="$lastSeries"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
	</xsl:for-each>
    <BR/>
    <BR/>
    <xsl:text>* - Messages not available</xsl:text>
</xsl:template>

<xsl:template name="msgCatAudioSeriesNS">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pcategory"/>
    <xsl:param name="pneedaudio"/>
    <!--  For each of the book studies  -->
	<xsl:for-each select="message[@category=$pcategory]">
        <xsl:variable name="lastSeries" select="seriestitle"/>
        <xsl:if test="seriestitle != preceding-sibling::message[1]/seriestitle">
            <xsl:call-template name="msgCatAudioGroup">
                <xsl:with-param name="pcategorytitle" select="$pcategorytitle"/>
                <xsl:with-param name="pcategory" select="$pcategory"/>
                <xsl:with-param name="pneedaudio" select="$pneedaudio"/>
                <xsl:with-param name="lastSeries" select="$lastSeries"/>
            </xsl:call-template>
        </xsl:if>
	</xsl:for-each>
    <BR/>
    <BR/>
    <xsl:text>* - Messages not available</xsl:text>
</xsl:template>

<xsl:template name="msgCatTapeGroup">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pcategory"/>
    <xsl:param name="lastSeries"/>
    <xsl:param name="ppartnum"/>
    <xsl:param name="ppassage"/>
    <table border="0" background="" cellpadding="0" width="100%">
    <tr><td align="center">
        <BR/><IMG SRC="../images/bluebar1.gif"/><BR/>
        <BR/>
        <A><xsl:attribute name="name"><xsl:value-of select="seriestitle"/></xsl:attribute><B><xsl:value-of select="seriestitle"/><xsl:text> - </xsl:text><xsl:value-of select="$pcategorytitle"/></B></A>
        <BR/><BR/>
    </td></tr>
    <tr>
    <td>
    <TABLE BORDER="1" BACKGROUND="" CELLPADDING="0" WIDTH="100%">
    <TR>
        <TH ALIGN="center">Tape Catalog Number</TH>
        <xsl:if test="$ppartnum = 1">
            <TH align="center">Message Number</TH>
        </xsl:if>
        <xsl:if test="$ppassage = 1">
            <TH align="center">Passage</TH>
        </xsl:if>
        <TH ALIGN="center"><xsl:value-of select="$pcategorytitle"/><xsl:text> Title</xsl:text></TH>
    </TR>
	<xsl:for-each select="/messagecatalog/message[seriestitle=$lastSeries]">
	<xsl:sort select="@date" data-type="number" order="ascending"/>
        <xsl:if test="$pcategory = @category">
            <xsl:if test="string(tape) != ''">
                <tr>
                    <td align="center"><xsl:value-of select="tape"/></td>
                    <xsl:if test="$ppartnum = 1">
                        <td align="center"><xsl:text>Part </xsl:text><xsl:value-of select="position()"/></td>
                    </xsl:if>
                    <xsl:if test="$ppassage = 1">
                        <td align="center"><xsl:value-of select="passage"/></td>
                    </xsl:if>
                    <td align="center">
                        <xsl:if test="$ppartnum = 0">
                            <xsl:if test="$ppassage != 1">
                                <xsl:if test="string(passage) != ''">
                                    <xsl:value-of select="passage"/>
                                </xsl:if>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="string(title) != ''">
                            <xsl:if test="$ppartnum = 0">
                                <xsl:if test="$ppassage != 1">
                                    <xsl:if test="string(passage) != ''">
                                        <xsl:text> - </xsl:text>
                                    </xsl:if>
                                </xsl:if>
                            </xsl:if>
                            <xsl:value-of select="title"/>
                        </xsl:if>
                        <xsl:if test="string(title) = ''">
                            <xsl:if test="$ppartnum = 1">
                                <xsl:value-of select="passage"/>
                            </xsl:if>
                        </xsl:if>
                    </td>
                </tr>
            </xsl:if>
        </xsl:if>
	</xsl:for-each>
    </TABLE>
    </td>
    </tr>
    </table>
</xsl:template>

<xsl:template name="msgCatTapeList">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pcategory"/>
    <xsl:param name="ppartnum"/>
    <xsl:param name="ppassage"/>
    <xsl:param name="pneedfirsttape"/>
    <!--  For each of the book studies  -->
	<xsl:for-each select="message[@category=$pcategory]">
	<xsl:sort select="seriestitle" order="ascending"/>
        <xsl:variable name="lastSeries" select="seriestitle"/>
        <xsl:if test="seriestitle != preceding-sibling::message[1]/seriestitle">
            <xsl:if test="$pneedfirsttape = 1">
                <xsl:if test="string(tape) != ''">
                    <xsl:call-template name="msgCatTapeGroup">
                        <xsl:with-param name="pcategorytitle" select="$pcategorytitle"/>
                        <xsl:with-param name="pcategory" select="$pcategory"/>
                        <xsl:with-param name="lastSeries" select="$lastSeries"/>
                        <xsl:with-param name="ppartnum" select="$ppartnum"/>
                        <xsl:with-param name="ppassage" select="$ppassage"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:if>
            <xsl:if test="$pneedfirsttape != 1">
                <xsl:call-template name="msgCatTapeGroup">
                    <xsl:with-param name="pcategorytitle" select="$pcategorytitle"/>
                    <xsl:with-param name="pcategory" select="$pcategory"/>
                    <xsl:with-param name="lastSeries" select="$lastSeries"/>
                    <xsl:with-param name="ppartnum" select="$ppartnum"/>
                    <xsl:with-param name="ppassage" select="$ppassage"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template name="msgCatTapeListNS">
    <xsl:param name="pcategorytitle"/>
    <xsl:param name="pcategory"/>
    <xsl:param name="ppartnum"/>
    <xsl:param name="ppassage"/>
    <!--  For each of the book studies  -->
	<xsl:for-each select="message[@category=$pcategory]">
        <xsl:variable name="lastSeries" select="seriestitle"/>
        <xsl:if test="seriestitle != preceding-sibling::message[1]/seriestitle">
            <xsl:call-template name="msgCatTapeGroup">
                <xsl:with-param name="pcategorytitle" select="$pcategorytitle"/>
                <xsl:with-param name="pcategory" select="$pcategory"/>
                <xsl:with-param name="lastSeries" select="$lastSeries"/>
                <xsl:with-param name="ppartnum" select="$ppartnum"/>
                <xsl:with-param name="ppassage" select="$ppassage"/>
            </xsl:call-template>
        </xsl:if>
	</xsl:for-each>
</xsl:template>

<xsl:template name="msgCatCurrent">
    <xsl:param name="pservicetitle"/>
    <xsl:param name="pservice"/>
    <TABLE cellspacing="3" cellpadding="2" BORDER="0" WIDTH="100%">
	<TR>
	  <TD COLSPAN="2" ALIGN="left"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA">
	    To hear Allen's most recent <xsl:value-of select="$pservicetitle"/> teachings via RealAudio<SUP>(R)</SUP>
	    click on one of the icons below.  Note that all audio messages
	    are encoded for a 28.8k modem.
	    The highlighted scripture takes you to the Blue Letter Bible
	    which is an excellent online Bible resource.
	  </FONT></TD>
	</TR>
	<TR>
	  <TD ALIGN="right" VALIGN="middle"><A HREF="../msgs/tapeorder.html"><IMG SRC="../images/cassette.jpg" ALT="View the Calvary Continuum Audio Tape catalog" BORDER="0"/></A></TD>
	  <TD ALIGN="left"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA" SIZE="-1">
	    Go to the <A HREF="../msgs/tapeorder.html">Calvary Continuum Audio Tape</A> catalog.
	  </FONT>
	  </TD>
	</TR>
	<TR>
	  <TD ALIGN="right" VALIGN="middle"><A HREF="../msgs/msgsAudioArchive.html"><IMG SRC="../images/filecab.jpg" ALT="View the online audio message archive" BORDER="0"/></A></TD>
	  <TD ALIGN="left"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA" SIZE="-1">
	    Go to Pastor Allen's <A HREF="../msgs/msgsAudioArchive.html">RealAudio online message archive</A>.
	    </FONT>
	  </TD>
	</TR>
	<TR>
	  <TD COLSPAN="2" ALIGN="right"><IMG SRC="../images/underbar.gif" border="0"/><BR/></TD>
	</TR>
    </TABLE>

    <TABLE cellspacing="0" cellpadding="0" BORDER="0" WIDTH="100%">
	<xsl:for-each select="message[@service=$pservice]">
	<xsl:sort select="@date" data-type="number" order="descending"/>
	<xsl:if test="position() &lt; 24">
	<TR>
	  <TD WIDTH="48" ROWSPAN="2" ALIGN="center" VALIGN="middle"><A><xsl:attribute name="href">http://www.calvarychapel.org/austin/audio/<xsl:value-of select="audio"/></xsl:attribute><IMG SRC="../images/rnicon.gif" ALT="Listen with RealAudio" BORDER="0"/></A></TD>
	  <TD ALIGN="left"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA"><A TARGET="_blank"><xsl:attribute name="href"><xsl:value-of select="passageref"/></xsl:attribute><B><xsl:value-of select="passage"/></B></A></FONT></TD>
	  <TD ALIGN="right"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA"><xsl:value-of select="document('')/*/months:name[@sequence=substring(current()/@date,5,2)]"/><xsl:text> </xsl:text><xsl:value-of select="number(substring(@date,7,2))"/>, <xsl:value-of select="number(substring(@date,1,4))"/></FONT></TD>
	</TR>
	<TR>
	  <TD ALIGN="left"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA"><EM><xsl:value-of select="title"/> </EM></FONT></TD>
	  <TD ALIGN="right"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA"><EM>Tape Catalog #<xsl:value-of select="tape"/></EM></FONT></TD>
	</TR>
	<TR><TD HEIGHT="20"></TD></TR>

	</xsl:if>
	</xsl:for-each>
    </TABLE>

</xsl:template>

</xsl:stylesheet>

