<?xml version="1.0"?>
    
<!-- 

	About Beliefs Page
	
	Processes the beliefs tag and its children tags.
	
	$Id: beliefs.xsl,v 1.2 2002/05/23 17:57:38 javajames27 Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="../general-ui.xsl"/>
<xsl:include href="../general-html.xsl"/>

<xsl:template match="beliefs">

     <table>
     	<tr>
     		<td align="left">
				<p><xsl:value-of select="intro"></xsl:value-of></p>
				
				 <xsl:for-each select="belief">
					<p><b>We believe</b><br/><xsl:apply-templates select="*|@*|text()"/></p>
				 </xsl:for-each>
     		</td>
     	</tr>
     </table> 
</xsl:template>
  
</xsl:stylesheet>
