<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="messagecatagories">
    <TABLE cellspacing="3" cellpadding="2" BORDER="0" WIDTH="100%">
	<TR>
	  <TD ALIGN="left"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA">
	    To hear our archive teachings via RealAudio<SUP>(R)</SUP> 
	    for a 28.8 modem then select the category hyperlink below.  If you don't have a 
	    player, click on the download icon to the right to visit the Real Networks 
	    site.
	  </FONT></TD>
	  <TD ALIGN="right"><A HREF="http://www.real.com"><IMG SRC="../images/freeplayer_g2.gif" BORDER="0"/></A></TD>
	</TR>
	<TR>
	  <TD COLSPAN="2" ALIGN="right"><IMG SRC="../images/underbar.gif" border="0"/><BR/></TD>
	</TR>
    </TABLE>

    <UL>
	<xsl:for-each select="category">
        <LI><A><xsl:attribute name="href"><xsl:value-of select="@audiopage"/></xsl:attribute><xsl:value-of select="@title"/></A>
        <xsl:text> - </xsl:text>
        <xsl:value-of select="background"/>
        </LI>
	</xsl:for-each>
    </UL>

</xsl:template>

</xsl:stylesheet>
