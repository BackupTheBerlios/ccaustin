<?xml version="1.0"?>
    
<!--
	This XSL handles the generic HTML needs of transformation. It will properly render table cells, 
	ordered/unordered lists, etc. Import this if your sheet requires HTML tags and include the following
	after the xsl:stylesheet tag to activate these templates:

	<xsl:include href="../general-html.xsl"/>
	
	Place all tag processing templates in here that are HTML-based or text-processing based 
	(using the <text></text> tag set).
	
	$Id: general-html.xsl,v 1.1 2002/01/31 03:25:33 javajames27 Exp $
-->


<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

 <xsl:template match="p">
    <p> 
	<xsl:attribute name="align">
          <xsl:value-of select="@align"/>
       </xsl:attribute>
	<xsl:apply-templates select="*|text()"/>
   </p>
  </xsl:template>

 <xsl:template match="br">
    <br/> 
  </xsl:template>

  <xsl:template match="a">
    <a>
      <xsl:if test="@href">
        <xsl:attribute name="href">
          <xsl:value-of select="@href"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:for-each select="@*[not(name(.)='href')]">
        <xsl:copy-of select="."/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="img">
    <img>
      <xsl:if test="@src">
        <xsl:attribute name="src">
          <xsl:value-of select="@src"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:for-each select="@*[not(name(.)=src)]">
        <xsl:copy-of select="."/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </img>
  </xsl:template>


  <xsl:template match="td">
    <td>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="*|@*|text()"/>
    </td>
  </xsl:template>

  <xsl:template match="ul">
      <ul><xsl:apply-templates/></ul>
  </xsl:template>

<xsl:template match="ol">
	<ol>
		<xsl:apply-templates select="li"/>
	</ol>
</xsl:template>

<xsl:template match="li">
	<li><xsl:apply-templates select="*|@*|text()"/></li>
</xsl:template>


<!-- 
	Custom HTML extensions 
-->
<xsl:template match="note">
	<div class="note"><xsl:apply-templates select="text()"/></div>
</xsl:template>


</xsl:stylesheet>
