<?xml version="1.0"?>
    
<!-- 

	Dynamic Javascript Menus

	$Id: globalmenu.xsl,v 1.2 2002/07/11 00:15:54 javajames27 Exp $	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template match="website">
 function mmLoadMenus() {
	<xsl:apply-templates select="section"/>
 }
</xsl:template>

<xsl:template match="section">
	<xsl:variable name="menu_name">menu_<xsl:value-of select="@name"/></xsl:variable>
      <xsl:if test="position() = 1">if (window.<xsl:value-of select="$menu_name"/>) return;</xsl:if>
	window.<xsl:value-of select="$menu_name"/> = new Menu("root",243,20,"Verdana, Arial, Helvetica, sans-serif",14,"#000000","#ffffff","#ffffff","#000084","left","middle",3,0,1000,-5,7,true,true,true,0,true,true);
	  <xsl:for-each select="page[not(@hidden = 'true') and not(@exclude = 'true')]">
	    <xsl:value-of select="$menu_name"/>.addMenuItem("<xsl:value-of select="title"/>","location='..<xsl:value-of select="@html"/>'");
	  </xsl:for-each>
         <xsl:value-of select="$menu_name"/>.hideOnMouseOut=true;
         <xsl:value-of select="$menu_name"/>.menuBorder=1;
         <xsl:value-of select="$menu_name"/>.menuLiteBgColor='#ffffff';
         <xsl:value-of select="$menu_name"/>.menuBorderBgColor='#555555';
         <xsl:value-of select="$menu_name"/>.bgColor='#555555';

	  <xsl:if test="position() = last()"><xsl:value-of select="$menu_name"/>.writeMenus();</xsl:if>
</xsl:template>

</xsl:stylesheet>
