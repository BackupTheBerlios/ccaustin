<?xml version="1.0"?>
    
<!--
     This XSL handles the generic needs of text transformation. It will properly render paragraphs, images, links, 
     tables, lists, etc. 
     
     Import this if your sheet requires HTML tags and include the following
     after the xsl:stylesheet tag to activate these templates:

     <xsl:include href="../general-html.xsl"/>
     
     Place all tag processing templates in here that are HTML-based or text-processing based.
     
     When a new tag is needed, consider using its HTML equivalent if its name and format is common english. 
     (e.g. <a/> is not really anything meaningful for the average person, but <link/> is)
     
     $Id: html.xsl,v 1.1 2004/01/30 21:51:15 javajames27 Exp $
     -->


<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template name="page-render">
  <xsl:apply-templates select="html/body"/>
</xsl:template>

<!-- 
     ============================
     HTML tags
     ============================ 
-->

<!-- Map and area tags for the image map in the home fellowship page. May want to clean this up later -->
<xsl:template match="map">
      <xsl:element name="map">
        <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
        <xsl:apply-templates select="area"/>
      </xsl:element>
</xsl:template>
<xsl:template match="area">
      <xsl:element name="area">
        <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
        <xsl:attribute name="shape"><xsl:value-of select="@shape"/></xsl:attribute>
        <xsl:attribute name="coords"><xsl:value-of select="@coords"/></xsl:attribute>
        <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
        <xsl:attribute name="alt"><xsl:value-of select="@alt"/></xsl:attribute>
      </xsl:element>
</xsl:template>

<!-- 
     ============================
     Custom tags
     ============================ 
-->

<!--
     <verse/> verse tag
     
     Renders verse 
     
     Body: The text of the verse
     
     Attributes:
     
     ref - the reference text being quoted
     
     Processes Subtags: Yes
-->
<xsl:template match="verse">
  <span class="verseref"><xsl:value-of select="@ref"/></span><xsl:text> </xsl:text><span class="verse"> <xsl:apply-templates select="*|text()"/></span>
</xsl:template>

<xsl:template match="html">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="h1">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="h2">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="h3">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="h4">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="table">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="tr">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="th">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="td">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="p">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="br">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="a">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="img">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="span">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="div">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="nbsp">
  <xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="amp">
  <xsl:text><![CDATA[&amp;]]> </xsl:text>
</xsl:template>

</xsl:stylesheet>
