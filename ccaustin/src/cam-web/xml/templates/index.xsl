<?xml version="1.0"?>
<!--
 This XSL handles the majority of the UI layout and look and feel. It uses
 Javascript to generate dynamic menus and other page features. This provides
 a more "current browser version" feel.

 Other variants of this file may offer more search engine or accessibility-friendly
 navigation and less Javascript features for older browsers. 
 
 $Id: index.xsl,v 1.2 2004/01/30 21:59:12 javajames27 Exp $
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

<html><!-- InstanceBegin template="/Templates/HomeTemplate.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<!-- InstanceBeginEditable name="doctitle" -->
<title>Calvary Austin Music / <xsl:value-of select="/html/head/title"/></title>
<!-- InstanceEndEditable --> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
<link href="css/cam-splash.css" rel="stylesheet" type="text/css"/>
</head>

<body bgcolor="#000000">
<table width="100%" height="100%" border="0" align="center">
  <tr> 
    <td align="center" valign="middle"><xsl:call-template name="perform-layout"/>
    </td>
  </tr>
</table>
</body>
<!-- InstanceEnd --></html>
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
