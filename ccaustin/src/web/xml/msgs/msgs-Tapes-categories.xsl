<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="messagecatagories">
    <TABLE cellspacing="3" cellpadding="2" BORDER="0" WIDTH="100%">
	<TR>The following categories of tapes are found in our tape catalog.  Click on the category
        to view individual tapes in that category.
        Should a tape or two interest you, please see the <A HREF="tapeorder.html">Order Form</A> for information on getting copies for your personal study. 
	</TR>
	<TR>
	  <TD COLSPAN="2" ALIGN="right"><IMG SRC="../images/underbar.gif" border="0"/><BR/></TD>
	</TR>
    </TABLE>

    <UL>
	<xsl:for-each select="category">
        <LI><A><xsl:attribute name="href"><xsl:value-of select="@tapepage"/></xsl:attribute><xsl:value-of select="@title"/></A>
        <xsl:text> - </xsl:text>
        <xsl:value-of select="background"/>
        </LI>
	</xsl:for-each>
    </UL>

</xsl:template>

</xsl:stylesheet>
