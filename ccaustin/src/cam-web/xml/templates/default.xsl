<?xml version="1.0"?>
<!--
 This XSL handles the majority of the UI layout and look and feel. It uses
 Javascript to generate dynamic menus and other page features. This provides
 a more "current browser version" feel.

 Other variants of this file may offer more search engine or accessibility-friendly
 navigation and less Javascript features for older browsers. 
 
 $Id: default.xsl,v 1.1 2004/01/30 21:51:15 javajames27 Exp $
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="html" indent="yes"/>
 
 <xsl:param name="TODAY">N/A</xsl:param>
 <xsl:param name="VERSION">0.00</xsl:param>
 <xsl:param name="DATE">00000000</xsl:param>

<!--
 The HTML layout template. This section is where the look and feel of the site can
 be changed. It handles to header, footer, and placement of the page content. 
 The content is then further processed by the other XSL templates based on the 
 appropriate XML tags.
 -->
 <xsl:template name="page">
  <html>
   <head>
     <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
     <title>Calvary Austin Music / <xsl:value-of select="/html/head/title"/>
    </title>
    <link REL="STYLESHEET" href="css/cam.css"/>
    <meta content="text/html" http-equiv="Content-Type"/>
    <xsl:apply-templates select="/html/head/script"/>
    <!-- allow our pages to include custom scripting -->
   </head>

    <body bgcolor="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
    <table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr valign="top"> 
        <td width="50"><img name="standardtemplate_r1_c2" src="images/standardtemplate_r1_c2.jpg" width="50" height="219" border="0" alt=""/></td>
        <td><a href="homepage.html"><img name="standardtemplate_r1_c3" src="images/standardtemplate_r1_c3.jpg" width="702" height="219" border="0" alt=""/></a></td>
        <td width="48"><img name="standardtemplate_r1_c4" src="images/standardtemplate_r1_c4.jpg" width="48" height="219" border="0" alt=""/></td>
      </tr>
      <tr valign="top"> 
        <td width="50"><img name="standardtemplate_r2_c2" src="images/standardtemplate_r2_c2.jpg" width="50" height="22" border="0" alt=""/></td>
        <td><img name="standardtemplate_r2_c3" src="images/standardtemplate_r2_c3.jpg" width="702" height="22" border="0" alt=""/></td>
        <td width="48"><img name="standardtemplate_r2_c4" src="images/standardtemplate_r2_c4.jpg" width="48" height="22" border="0" alt=""/></td>
      </tr>
      <tr valign="top"> 
        <td background="images/standardtemplate_r2_c2.jpg" class="menu"><!--<p><a href="homepage.html">Home</a></p>
          <p><a href="listen.html">Listen</a></p>
          <p><a href="resources.html">Play</a></p>
          <p><a href="behind.html">Learn</a></p>--></td>
        <!-- TemplateBeginEditable name="Body" --> 
        <td bgcolor="#FFFFFF" class="body">
          <!-- BEGIN LAYOUT --><xsl:call-template name="perform-layout"/><!-- END LAYOUT -->
        </td>
        <!-- TemplateEndEditable --> 
        <td background="images/standardtemplate_r2_c4.jpg"><nbsp/></td>
      </tr>
      <tr valign="top"> 
        <td height="20" colspan="3" background="images/standardtemplate_r2_c2.jpg" class="address"><p>Copyright 
            2004 <a href="http://www.calvaryaustin.org">Calvary Chapel of Austin</a><br/>
         Version: <xsl:value-of select="$VERSION"/>, Latest update: <xsl:value-of select="$TODAY"/><br/></p>
          </td>
      </tr>
    </table>
    <p><nbsp/></p>
    <p><nbsp/></p>
    </body>
    </html>
 </xsl:template>
 <!--
 Any XML tag that is <text></text> gets processed as-is. This is useful for pages 
 that are only text and no other special data. It can be processed as-is, just like
 standard HTML without any work by the XSL writer.
-->
 <xsl:template match="text">
  <xsl:apply-templates/>
 </xsl:template>
 <xsl:template match="script">
  <script language="JavaScript1.2">
   <xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
  </script>
 </xsl:template>
</xsl:stylesheet>
