<?xml version="1.0"?>
    
<!--
	This XSL handles the needs of directives, such as redirects
	
	$Id: directives.xsl,v 1.1 2002/12/13 20:04:06 javajames27 Exp $
-->


<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template name="page-render">
	<xsl:apply-templates select="content"/>
</xsl:template>

<!-- 
    <redirect/>  Redirect Tag
    
    Sends a redirect javascript code block to the client with the new redirect location.

    Body: None

    Attributes:
      href - the new location to go to        

    Processes Subtags: No
-->
  <xsl:template match="redirect">
    <script>
      <![CDATA[document.location="]]><xsl:value-of select="@href"/><![CDATA[";]]>
    </script>
  </xsl:template>

</xsl:stylesheet>
