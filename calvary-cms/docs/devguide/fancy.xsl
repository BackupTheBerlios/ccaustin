<?xml version="1.0" encoding="UTF-8"?>

<!-- $Id: fancy.xsl,v 1.1 2003/02/12 22:06:48 javajames27 Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:saxon="http://icl.com/saxon"
   xmlns:lxslt="http://xml.apache.org/xslt"
   xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
   xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
   version="1.0"
   exclude-result-prefixes="doc"
   extension-element-prefixes="saxon xalanredirect lxslt">

   <xsl:import href="../../thirdparty/oasis/docbook-xsl/html/chunk.xsl"/>
   <xsl:import href="customization.xsl"/>

   <xsl:param name="html.stylesheet">styles.css</xsl:param>
   <xsl:param name="toc.section.depth">1</xsl:param>
   <xsl:param name="generate.component.toc">1</xsl:param>
   <xsl:param name="chapter.autolabel" select="1"/>
   <xsl:param name="section.autolabel" select="1"/>
   <xsl:param name="section.label.includes.component.label" select="1"/>

   <!-- Override the callout images location -->
   <xsl:param name="callout.graphics.path" select="'images/callouts/'"/>

   <!-- 
      | Override the graphics.xsl imageobjectco to correctly process 
      | the calloutlist child element 
    -->
   <xsl:template match="imageobjectco">
      <xsl:apply-templates select="imageobject"/>
      <xsl:apply-templates select="calloutlist"/>
   </xsl:template>

   <!-- Override the footnote.xml footnote as it just was not working -->
   <xsl:template match="footnote">
      <xsl:choose>
         <xsl:when test="ancestor::table|ancestor::informaltable">
            <xsl:apply-templates select="." mode="table.footnote.mode"/>
         </xsl:when>
      <xsl:otherwise>
         <xsl:apply-templates select="." mode="process.footnote.mode"/>
      </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

<!-- ==================================================================== -->

<xsl:template name="chunk-element-content">
  <xsl:param name="prev"></xsl:param>
  <xsl:param name="next"></xsl:param>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <html>
    <xsl:call-template name="html.head">
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>

    <body>
      <xsl:call-template name="body.attributes"/>
      <table CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
        <tr> 
        <!-- IMAGE CELL -->
        <!-- CONTENT CELL -->
          <td VALIGN="TOP" class="VersionTitle"> 
            <table BORDER="0" width="100%" CELLPADDING="0">
              <tr> 
                <td BGCOLOR="#000000" VALIGN="TOP"> 
                  <table BORDER="0" WIDTH="100%" CELLSPACING="1" CELLPADDING="5">
                    <tr> 
                      <td class="TitleCell" bgcolor="grey">
                        <xsl:call-template name="my.header.content"/>
                      </td>
                    </tr>
                    <tr> 
                    <td class="ContentCellSmall" bgcolor="grey"> 
                    <div align="right">
                      <xsl:call-template name="header.navigation">
                        <xsl:with-param name="prev" select="$prev"/>
                        <xsl:with-param name="next" select="$next"/>
                      </xsl:call-template>
                    </div>
                  </td>
                </tr>
                    <tr> 
                    <td class="ContentCellSmall" bgcolor="grey"> 
                    <div align="left">
                      <xsl:apply-imports/>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td class="ContentCell" bgcolor="white" valign="top">
                    <div align="right">
                      <xsl:call-template name="user.footer.content"/>
                      <xsl:call-template name="footer.navigation">
                        <xsl:with-param name="prev" select="$prev"/>
                        <xsl:with-param name="next" select="$next"/>
                      </xsl:call-template>
                      
                      <xsl:call-template name="user.footer.navigation"/>
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

<!-- ==================================================================== -->

<xsl:template name="header.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:if test="$suppress.navigation = '0'">
    <div class="navheader">
      <table width="100%" summary="Navigation header">
        <tr>
          <td width="20%" align="left">
            <xsl:if test="count($prev)>0">
              <a accesskey="p">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>
                <!--
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">nav-prev</xsl:with-param>
                </xsl:call-template>
                -->
                <img src="images/prev.gif" border="0"/>
              </a>
            </xsl:if>
            <xsl:text>&#160;</xsl:text>
          </td>
          <th width="60%" align="center">
              <xsl:text>&#160;</xsl:text>
          </th>
          <td width="20%" align="right">
            <xsl:text>&#160;</xsl:text>
            <xsl:if test="count($next)>0">
              <a accesskey="n">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>
                <img src="images/next.gif" border="0"/>
                <!--
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">nav-next</xsl:with-param>
                </xsl:call-template>
                -->
              </a>
            </xsl:if>
          </td>
        </tr>
      </table>
    </div>
  </xsl:if>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template name="footer.navigation">
  <xsl:param name="prev" select="/foo"/>
  <xsl:param name="next" select="/foo"/>
  <xsl:variable name="home" select="/*[1]"/>
  <xsl:variable name="up" select="parent::*"/>

  <xsl:if test="$suppress.navigation = '0'">
    <div class="navfooter">
      <table width="100%" summary="Navigation footer">
        <tr>
          <td width="40%" align="left" class="navfooter">
            <xsl:if test="count($prev)>0">
              <a accesskey="p">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$prev"/>
                  </xsl:call-template>
                </xsl:attribute>
                <img src="images/prev.gif" border="0"/>
                <!--
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">nav-prev</xsl:with-param>
                </xsl:call-template>
                -->
              </a>
            </xsl:if>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center" class="navfooter">
            <xsl:choose>
              <xsl:when test="$home != .">
                <a accesskey="h">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$home"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <img src="images/toc.gif" border="0"/>
                  <!--
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">nav-home</xsl:with-param>
                  </xsl:call-template>
                  -->
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
          </td>
          <td width="40%" align="right" class="navfooter">
            <xsl:text>&#160;</xsl:text>
            <xsl:if test="count($next)>0">
              <a accesskey="n">
                <xsl:attribute name="href">
                  <xsl:call-template name="href.target">
                    <xsl:with-param name="object" select="$next"/>
                  </xsl:call-template>
                </xsl:attribute>
                <img src="images/next.gif" border="0"/>
                <!--
                <xsl:call-template name="gentext">
                  <xsl:with-param name="key">nav-next</xsl:with-param>
                </xsl:call-template>
                -->
              </a>
            </xsl:if>
          </td>
        </tr>

        <tr>
          <td width="40%" align="left" class="navfooter">
            <xsl:apply-templates select="$prev" mode="object.title.markup"/>
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="20%" align="center" class="navfooter">
            <!--
            <xsl:choose>
              <xsl:when test="count($up)>0">
                <a accesskey="u">
                  <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                      <xsl:with-param name="object" select="$up"/>
                    </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="gentext">
                    <xsl:with-param name="key">nav-up</xsl:with-param>
                  </xsl:call-template>
                </a>
              </xsl:when>
              <xsl:otherwise>&#160;</xsl:otherwise>
            </xsl:choose>
            -->
            <xsl:text>&#160;</xsl:text>
          </td>
          <td width="40%" align="right" class="navfooter">
            <xsl:text>&#160;</xsl:text>
            <xsl:apply-templates select="$next" mode="object.title.markup"/>
          </td>
        </tr>
      </table>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template name="my.header.content">
  <xsl:text>Dotw Vision Document v1.0</xsl:text>
</xsl:template>

<xsl:template match="mylisting">
     <pre><xsl:value-of select="text()"/></pre>
   </xsl:template>
</xsl:stylesheet>
