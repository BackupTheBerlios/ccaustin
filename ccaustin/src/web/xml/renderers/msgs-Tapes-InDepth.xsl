<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="msgCatList.xsl"/>

<xsl:template match="messagecatalog">
    <TABLE cellspacing="3" cellpadding="2" BACKGROUND="" BORDER="0" WIDTH="100%">
    <TR>
    <TD>
        <TABLE WIDTH="40" BORDER="0" CELLPADDING="0" CELLSPACING="0">
            <TR><TD ALIGN="center"> </TD></TR>
        </TABLE>
    </TD>
    <TD BACKGROUND="">
        The In-Depth tapes are a long-term detailed study of a book of the Bible.
        Click below on a book of the Bible to go to the listing of available tapes.
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
            <xsl:with-param name="pcategorytitle" select="'In-Depth'"/>
            <xsl:with-param name="pcategory" select = "'in depth'"/>
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
            <xsl:with-param name="pcategorytitle" select="'In-Depth'"/>
            <xsl:with-param name="pcategory" select = "'in depth'"/>
            <xsl:with-param name="ppartnum" select="0"/>
        </xsl:call-template>
        </TD>
    </TR>
    </TABLE>
</xsl:template>

</xsl:stylesheet>
