<?xml version="1.0"?>

<!-- 
  Empty Template - no HTML, no images - useful for redirecting users to another page or executing Javascript
-->    

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output indent="yes" 
            doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
            doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

 <xsl:template name="page">
   <xsl:call-template name="perform-layout"/>
 </xsl:template>

</xsl:stylesheet>
