<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template name="page-render">
  <xsl:apply-templates select="messagecatagories"/>
</xsl:template>

<xsl:template match="messagecatagories">
    <TABLE cellspacing="3" cellpadding="2" BORDER="0" WIDTH="100%">
	<TR>The following categories of tapes are found in our tape catalog.  Click on the category
        to view individual tapes in that category.
        Should a tape or two interest you, please see the <A HREF="tapeorder.html">Order Form</A> for information on getting copies for your personal study. 
	</TR>
	<TR>
	  <TD COLSPAN="2" ALIGN="right"><IMG SRC="../images/underbar.gif" border="0"/><BR/></TD>
	</TR>
    </TABLE>

	<table>
		<xsl:for-each select="category">
  		    <xsl:if test="@tapepage!= ''">
			  <tr>
		  	    <td width="25%" nowrap="true" align="right" valign="top"><a><xsl:attribute name="href"><xsl:value-of select="@tapepage"/></xsl:attribute><xsl:value-of 	select="@title"/></a></td>
		  	    <td width="5%" align="left"><br/></td>
		  	    <td width="70%" align="left"><xsl:value-of select="background"/></td>
			  </tr>
		    </xsl:if>
		</xsl:for-each>
	</table>

    
</xsl:template>

</xsl:stylesheet>
