<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="msgCatList.xsl"/>

<xsl:template match="messagecatalog">
    <xsl:call-template name="msgCatHead">
        <xsl:with-param name="pcategorytitle" select="'Book Study'"/>
    </xsl:call-template>
    <xsl:call-template name="msgCatAudioSwitcher">
        <xsl:with-param name="pcategorytitle" select="'Book Study'"/>
        <xsl:with-param name="pcategory" select="'book studies'"/>
        <xsl:with-param name="pneedfirstaudio" select="1"/>
    </xsl:call-template>
    <xsl:call-template name="msgCatAudioSeries">
        <xsl:with-param name="pcategorytitle" select="'Book Study'"/>
        <xsl:with-param name="pcategory" select="'book studies'"/>
        <xsl:with-param name="pneedfirstaudio" select="1"/>
    </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
