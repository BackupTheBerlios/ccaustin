<?xml version="1.0"?>
    
<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<!-- General Header setup to match to stylesheet root node -->
<xsl:template match="/">
	   <xsl:apply-templates/>
</xsl:template>

<!-- Matches on the DOMAIN root node -->
<xsl:template match="domain">

<html>
<head>
<title><xsl:value-of select="title"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<link rel="stylesheet" href="domain.css" type="text/css"/>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<h2><xsl:value-of select="title"/></h2>
<p><xsl:value-of select="overview"/></p>

	<xsl:apply-templates select="class"/>

</body>
</html>

</xsl:template>

<!-- Matches on the CLASS node -->
<xsl:template match="class">

       <xsl:variable name="THISID" select="@id" />
       <xsl:variable name="EXTENDSID" select="@extends" />

	<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Class BEGIN -->]]></xsl:text>
	<p><a name="{@id}"></a>
	<table width="90%" border="1" cellspacing="0" cellpadding="0" bordercolor="#000000">
	  <tr> 
	    <td class=".titlebg"> 
	      <table width="100%" border="0">
	        <tr> 
	          <td colspan="2" class="classname"><xsl:value-of select="name"/></td>
	        </tr>
	        <tr> 
	          <td colspan="2"><b>Description: </b>
			<xsl:if test="not(description)">N/A</xsl:if>
			<xsl:if test="description = ''">N/A</xsl:if>
			<xsl:value-of select="description"/>
		   </td>
	        </tr>
	        <tr> 
	          <td><b>Superclasses: </b>
			  <xsl:if test="not(@extends)">None.</xsl:if>
			<a href="#{$EXTENDSID}"><xsl:value-of select="../class[@id=$EXTENDSID]/name"/></a>
		   </td>
	        </tr>
	        <tr> 
	          <td colspan="2"><b>Subclasses: </b>
			<xsl:if test="count(../class[@extends=$THISID]) = 0">None.</xsl:if>
			<xsl:for-each select="../class[@extends=$THISID]">
			  <a href="#{@id}"><xsl:value-of select="name"/></a>
			 <xsl:if test="position() != last()">, </xsl:if>
			</xsl:for-each>		   
		   </td>
	        </tr>
	        <tr> 
	          <td colspan="2"><b>Created/Destroyed By: </b>
			<xsl:if test="not(create-destroy)">N/A</xsl:if>
			<xsl:value-of select="create-destroy"/>
	          </td>
	        </tr>
	      </table>
	    </td>
	  </tr>

	<xsl:text disable-output-escaping="yes"><![CDATA[<!-- BEGIN Relations -->]]></xsl:text>
	  <tr> 
	    <td valign="top">
	      <table width="100%" border="0">
	        <tr> 
	          <td colspan="2"><b>Relationships</b></td>
	        </tr>
			<xsl:if test="count(relations) > 0">
			        <!-- tr> 
			          <td width="5%" nowrap="true">Cardinality</td>
			          <td width="95%">Class</td>
			        </tr -->
		      </xsl:if>
			<xsl:if test="count(relations) = 0">
  		  	      <tr><td>None.</td></tr>
		      </xsl:if>
  	  		<xsl:apply-templates select="relations"/>

	      </table>
	    </td>
	  </tr>
	<xsl:text disable-output-escaping="yes"><![CDATA[<!--END Relations -->]]></xsl:text>

	
	<xsl:text disable-output-escaping="yes"><![CDATA[<!-- BEGIN Properties -->]]></xsl:text>
	  <tr> 
	    <td width="100%" valign="top"> 
	      <table width="100%" border="0">
	        <tr> 
	          <td colspan="3"><b>Properties</b></td>
	        </tr>
			<xsl:if test="count(properties) > 0">
			        <!-- tr> 
			          <td width="20%">Name</td>
			          <td width="20%">Type</td>
			          <td width="60%">Description</td>
			        </tr -->
		      </xsl:if>

			<xsl:if test="count(properties) = 0">
  		  	      <tr><td colspan="2">None.</td></tr>
		      </xsl:if>
  	  		<xsl:apply-templates select="properties"/>
	      </table>
	    </td>
	  </tr> 
	<xsl:text disable-output-escaping="yes"><![CDATA[<!-- END Properties -->]]></xsl:text>

	<xsl:text disable-output-escaping="yes"><![CDATA[<!-- BEGIN Operations -->]]></xsl:text>
	  <tr> 
	    <td width="100%" valign="top"> 
	      <table width="100%" border="0">
	        <tr> 
	          <td colspan="4"><b>Operations</b></td>
	        </tr>
			<xsl:if test="count(operations) = 0">
  		  	      <tr><td colspan="4">None.</td></tr>
		      </xsl:if>
		  	  <xsl:apply-templates select="operations"/>
	      </table>
	    </td>
	  </tr> 
  	 <xsl:text disable-output-escaping="yes"><![CDATA[<!-- END Operations -->]]></xsl:text>

	</table>
	</p>
	<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Class END -->]]></xsl:text>
	
</xsl:template>

<!-- Matches on the RELATIONS node of a class -->
<xsl:template match="relations">

	<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Relations BEGIN-->]]></xsl:text>

	<xsl:if test="count(relation) = 0">
	     <p>None.</p>
      </xsl:if>

	  <xsl:for-each select="relation">
		 <xsl:variable name="TOCLASSID" select="@toClass" />
	        <tr> 
	          <td width="5%" NOWRAP="true" align="right"><xsl:value-of select="@type"/></td>
	          <td width="5%" NOWRAP="true" align="right"><xsl:value-of select="@role"/></td>
	          <td width="90%"><a href="#{$TOCLASSID}"><xsl:value-of select="../../../class[@id=$TOCLASSID]/name"/></a></td>
	        </tr>
	  </xsl:for-each>
	<xsl:text disable-output-escaping="yes"><![CDATA[<!-- Relations END -->]]></xsl:text>

</xsl:template>


<!-- Matches on the PROPERTIES node of a class -->
<xsl:template match="properties">

	  <xsl:for-each select="property">
	        <tr> 
	          <td width="20%"><xsl:value-of select="name"/></td>
	          <td width="20%"><xsl:value-of select="type"/></td>
	          <td width="60%"><xsl:value-of select="description"/></td>
	        </tr>
	  </xsl:for-each>

</xsl:template>

<!-- Matches on the OPERATIONS node of a class -->
<xsl:template match="operations">

	  <xsl:for-each select="operation">
	        <tr> 
	          <td width="20%"><xsl:value-of select="name"/></td>
	          <td width="20%">
				<xsl:if test="count(params) = 0">N/A</xsl:if>
				<xsl:if test="params= ''">None.</xsl:if>
				<xsl:value-of select="params"/>
		   </td>
	          <td width="20%">
				<xsl:if test="count(return-type) = 0">N/A</xsl:if>
				<xsl:if test="return-type= ''">N/A</xsl:if>
				<xsl:value-of select="return-type"/>
		   </td>
	          <td width="40%">
				<xsl:if test="count(description) = 0">N/A</xsl:if>
				<xsl:if test="description= ''">N/A</xsl:if>
				<xsl:value-of select="description"/>
		   </td>
	        </tr>
	  </xsl:for-each>

</xsl:template>


</xsl:stylesheet>
