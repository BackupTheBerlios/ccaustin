<?xml version="1.0"?>
    
<!--
     This is a stylesheet that includes the appropriate template, layout, and renderer to compose
     a complete XSL that will transform the page to the proper HTML page.

     Ant is used to copy this file to a temporary location and subsitute the appropriate template,
     layout, and renderer that is found in the sitemap.xml
-->   

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <!--
 The start of the processing for a page begins here. 
 -->
 <xsl:template match="/">
  <!-- 
  By calling the layout template from here, we can override this template using
  standard XSL import and override rules, doing special work before the layout 
  is started.
  -->
  <xsl:call-template name="page"/>
 </xsl:template>

 <xsl:template name="perform-layout">
  <xsl:call-template name="page-layout"/>
 </xsl:template>

 <xsl:template name="perform-render">
  <xsl:call-template name="page-render"/>
 </xsl:template>

  <!-- Include the Template -->
  <xsl:include href="@page.template@"/> <!--../general-left-image.xsl-->
  <!-- Include the Layout -->
  <xsl:include href="@page.layout@"/><!-- ../general-html.xsl -->
  <!-- Include the Renderer -->
  <xsl:include href="@page.renderer@"/><!-- ../general-html.xsl -->

</xsl:stylesheet>
