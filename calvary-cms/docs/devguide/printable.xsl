<?xml version="1.0"?>

<!-- $Id: printable.xsl,v 1.1 2003/02/12 22:06:48 javajames27 Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

   <xsl:import href="../../thirdparty/oasis/docbook-xsl/html/docbook.xsl"/>
   <xsl:param name="html.stylesheet">styles.css</xsl:param>
   <xsl:param name="chapter.autolabel" select="1"/>
   <xsl:param name="section.autolabel" select="1"/>
   <xsl:param name="section.label.includes.component.label" select="1"/>

<xsl:template match="*" mode="process.root">
  <xsl:variable name="doc" select="self::*"/>
  <html>
  <head>
    <xsl:call-template name="head.content">
      <xsl:with-param name="node" select="$doc"/>
    </xsl:call-template>
    <xsl:call-template name="user.head.content">
      <xsl:with-param name="node" select="$doc"/>
    </xsl:call-template>
  </head>
  <body>
      <table CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
        <tr> 
          <!-- CONTENT CELL -->
          <td VALIGN="TOP" class="VersionTitle"> 
            <table BORDER="0" width="100%" CELLPADDING="0">
             <tr> 
               <td BGCOLOR="#000000" VALIGN="TOP"> 
                 <table BORDER="0" WIDTH="100%" CELLSPACING="1" CELLPADDING="5">
                   <tr> 
                    <td class="ContentCellSmall"> 
                     <div align="left">
                       <xsl:call-template name="body.attributes"/>
                       <xsl:call-template name="user.header.content">
                         <xsl:with-param name="node" select="$doc"/>
                       </xsl:call-template>
                       <xsl:apply-templates select="."/>
                       <xsl:call-template name="user.footer.content">
                         <xsl:with-param name="node" select="$doc"/>
                       </xsl:call-template>
                     </div>
                   </td>
                 </tr>
               </table>
             </td>
           </tr>
         </table>
       </td>
     </tr>
   </table>
 </body>
</html>
</xsl:template>
</xsl:stylesheet>


