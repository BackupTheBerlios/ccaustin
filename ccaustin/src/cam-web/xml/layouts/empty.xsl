<?xml version="1.0"?>
    
<!--
     Default Layout

     A default XSL stylesheet that lays out the page in a single full column, processing all tags in
     a default manner

     To use this layout with a page, simply point a page entry in the sitemap.xml file to this layout
     as its stylesheet

-->   

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes" />

  <xsl:template name="page-layout">
    <!-- No special layout requirements -->
    <xsl:call-template name="perform-render"/>
  </xsl:template>

</xsl:stylesheet>
