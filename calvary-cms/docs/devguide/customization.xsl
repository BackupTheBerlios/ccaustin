<?xml version="1.0" encoding="UTF-8"?>

<!-- $Id: customization.xsl,v 1.1 2003/02/12 22:06:48 javajames27 Exp $ -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:saxon="http://icl.com/saxon"
   xmlns:lxslt="http://xml.apache.org/xslt"
   xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
   xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
   version="1.0"
   exclude-result-prefixes="doc"
   extension-element-prefixes="saxon xalanredirect lxslt">

   <xsl:template match="listing">
     <pre><xsl:value-of select="text()"/></pre>
   </xsl:template>
</xsl:stylesheet>
