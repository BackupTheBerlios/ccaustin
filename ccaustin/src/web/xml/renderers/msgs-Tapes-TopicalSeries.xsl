<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="msgCatList.xsl"/>

<xsl:template match="messagecatalog">
    <TABLE cellspacing="3" cellpadding="2" BACKGROUND="../images/bgts.gif" BORDER="0" WIDTH="100%">
    <TR>
    <TD>
        <TABLE WIDTH="40" BORDER="0" CELLPADDING="0" CELLSPACING="0">
            <TR><TD ALIGN="center"> </TD></TR>
        </TABLE>
    </TD>
    <TD BACKGROUND="">
        The Topical Series tapes are multi-message series on various topics.
        Click below on a topic title to go to the listing of available tapes.
    </TD>
    </TR>
    <TR><TD HEIGHT="10"></TD></TR>
    <TR>
        <TD COLSPAN="2" ALIGN="right"><IMG SRC="../images/underbar.gif" border="0"/><BR/></TD>
    </TR>
    <TR>
        <TD>
            <TABLE WIDTH="40" BORDER="0" CELLPADDING="0" CELLSPACING="0">
                <TR><TD ALIGN="center"> </TD></TR>
            </TABLE>
        </TD>
        <TD>
        <xsl:call-template name="msgCatTapeSwitcher">
            <xsl:with-param name="pcategorytitle" select="'Topical Series'"/>
            <xsl:with-param name="pcategory" select = "'topical series'"/>
            <xsl:with-param name="pneedfirsttape" select="1"/>
        </xsl:call-template>
        </TD>
    </TR>
    <TR>
        <TD>
            <TABLE WIDTH="40" BORDER="0" CELLPADDING="0" CELLSPACING="0">
                <TR><TD ALIGN="center"> </TD></TR>
            </TABLE>
        </TD>
        <TD>
        <xsl:call-template name="msgCatTapeList">
            <xsl:with-param name="pcategorytitle" select="'Topical Series'"/>
            <xsl:with-param name="pcategory" select = "'topical series'"/>
            <xsl:with-param name="ppartnum" select="1"/>
            <xsl:with-param name="pneedfirsttape" select="1"/>
        </xsl:call-template>
        </TD>
    </TR>
    </TABLE>
</xsl:template>

</xsl:stylesheet>
