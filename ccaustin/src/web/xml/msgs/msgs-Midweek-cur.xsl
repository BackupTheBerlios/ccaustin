<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:include href="msgCatList.xsl"/>

<xsl:template match="messagecatalog">
    <xsl:call-template name="msgCatCurrent">
        <xsl:with-param name="pservicetitle" select="'Mid-Week'"/>
        <xsl:with-param name="pservice" select="'midweek'"/>
    </xsl:call-template>
</xsl:template>


</xsl:stylesheet>
