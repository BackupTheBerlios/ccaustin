<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl
  ="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />
    
    
    <!-- General Header setup to match to root node -->
    <xsl:template match="/">
      <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Matches on the USECASE node -->
    <xsl:template match="usecase">
      
      <html>
        <head>
          <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
          <meta name="GENERATOR" content="Emacs 20.7; Dreamweaver 4.0"/>
          <title><xsl:value-of select="name"/></title>
          <link rel="stylesheet" href="style.css" type="text/css"/>
        </head>
        <body text="#000000" bgcolor="#FFFFFF" link="#0000EF" vlink="#51188E" alink="#FF0000">
          <table BORDER="1" CELLSPACING="0" CELLPADDING="1" WIDTH="80%" NOSAVE="true" bordercolor="#666666" >
            <tr NOSAVE="true"> 
            <td VALIGN="TOP" WIDTH="35%" bgcolor="#EEEEEE"><b>Use Case ID:</b></td>
            <td VALIGN="TOP" WIDTH="65%"><xsl:value-of select="@id"/></td>
          </tr>
          <tr> 
          <td VALIGN="TOP" WIDTH="35%" bgcolor="#EEEEEE"><b>Use Case Name:</b></td>
          <td VALIGN="TOP" WIDTH="65%"><xsl:value-of select="name"/></td>
        </tr>
        <tr> 
        <td VALIGN="TOP" WIDTH="35%" bgcolor="#EEEEEE"><b>Created by:</b></td>
        <td VALIGN="TOP" WIDTH="65%"><xsl:value-of select="created-by"/></td>
      </tr>
      <tr> 
      <td VALIGN="TOP" WIDTH="35%" bgcolor="#EEEEEE"><b>Date Created:</b></td>
      <td VALIGN="TOP" WIDTH="65%"><xsl:value-of select="created-on"/></td>
    </tr>
  </table>
  <p><b>Actor:</b> <xsl:value-of select="actor"/></p>
  <p><b>Feature:</b> <xsl:value-of select="feature"/></p>
  <p><b>Goal:</b> <xsl:value-of select="goal"/></p>
  <p><b>Description:</b> <xsl:value-of select="description"/></p>
  <p><b>Priority:</b> <xsl:value-of select="priority"/></p>
  
  <xsl:apply-templates select="preconditions"/>
  <xsl:apply-templates select="postconditions"/>
  <xsl:apply-templates select="related-usecases"/>
  <xsl:apply-templates select="notes"/>
  <xsl:apply-templates select="event-flow"/>
  
  <p><b>Alternate Flows:</b></p> 
  
  <xsl:if test="count(alternate-flow) = 0">
    <p>None.</p>
  </xsl:if>
  <xsl:if test="count(alternate-flow) > 0">
    <xsl:apply-templates select="alternate-flow"/>
  </xsl:if>
  
  
  <xsl:apply-templates select="history"/>
  
</body>
</html>

</xsl:template>

<!-- Matches on the PRECONDITION node -->
<xsl:template match="preconditions">
  
  <p><b>Preconditions:</b>
  <xsl:if test="count(precondition) = 0">
    <p>None.</p>
  </xsl:if>
  <ol>
    <xsl:for-each select="precondition">
      <li><xsl:value-of select="."/></li>
    </xsl:for-each>
  </ol>
</p>

</xsl:template>

<!-- Matches on the POSTCONDITION node -->
<xsl:template match="postconditions">
  
  <b>Post conditions:</b> 
  <xsl:if test="count(postcondition) = 0">
    <p>None.</p>
  </xsl:if>
  <ol>
    <xsl:for-each select="postcondition">
      <li><xsl:value-of select="."/></li>
    </xsl:for-each>
  </ol>
  
</xsl:template>

<!-- Matches on the RELATED USE CASES node -->
<xsl:template match="related-usecases">
  
  <p><b>Related Use Cases:</b>
  <xsl:if test="count(related-usecase) = 0">
    <p>None.</p>
  </xsl:if>
  <ul>
    <xsl:for-each select="related-usecase">
      <xsl:variable name="id"><xsl:value-of select="."/></xsl:variable>
      <li><a href="{$id}.html"><xsl:value-of select="."/></a></li>
    </xsl:for-each>
  </ul>
</p>
</xsl:template>

<!-- Matches on the NOTES node -->
<xsl:template match="notes">
  
  <p><b>Notes and Issues: </b>
  <xsl:if test="count(note) = 0">
    <p>None.</p>
  </xsl:if>
  <ol>
    <xsl:for-each select="note">
      <li><xsl:value-of select="."/></li>
    </xsl:for-each>
  </ol>
</p>

</xsl:template>

<!-- Matches on the EVENT FLOW node -->
<xsl:template match="event-flow">
  
  <p><b>Event Flow:</b> 
  <xsl:if test="count(event) = 0">
    <p>None.</p>
  </xsl:if>
  <ol>
    <xsl:for-each select="event">
      <li><xsl:value-of select="."/></li>
    </xsl:for-each>
  </ol>
</p>

</xsl:template>

<!-- Matches on the ALTERNATE FLOW node -->
<xsl:template match="alternate-flow">
  <xsl:if test="count(event) = 0">
    <p>None.</p>
  </xsl:if>
  <p><b>
  <!-- The next step takes the id in the format UCxxx.0 and strips the .0, then -->
  <!-- appends the position number to compute the alternate flow ID -->
  <xsl:number value="position()" format="1"/>:      
  <xsl:value-of select="@name"/></b>
  <ol>
    <xsl:for-each select="event">
      <li><xsl:value-of select="."/></li>
    </xsl:for-each>
  </ol>
</p>

</xsl:template>

<!-- Matches on the HISTORY node -->
<xsl:template match="history">
  
  <p></p>
  <b>Revision History</b>
  <br></br>
  <table BORDER="true" CELLSPACING="0" CELLPADDING="1" WIDTH="100%" align="center" bordercolor="#666666" >
    <tr> 
    <td VALIGN="TOP" WIDTH="10%" bgcolor="#EEEEEE"><b>Name</b></td>
    <td VALIGN="TOP" WIDTH="20%" bgcolor="#EEEEEE"><b>Date</b></td>
    <td VALIGN="TOP" WIDTH="60%" bgcolor="#EEEEEE"><b>Reason for Change</b></td>
    <td VALIGN="TOP" WIDTH="10%" bgcolor="#EEEEEE"><b>Version</b></td>
  </tr>
  
  <xsl:if test="count(revision) = 0">
    <tr> 
    <td VALIGN="TOP" WIDTH="10%">
      <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
      <td VALIGN="TOP" WIDTH="20%">
        <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
        <td VALIGN="TOP" WIDTH="60%">
          <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
          <td VALIGN="TOP" WIDTH="10%">
            <xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
          </tr>
        </xsl:if>
        <xsl:for-each select="revision">
          <tr> 
          <td VALIGN="TOP" WIDTH="10%"><xsl:value-of select="@editor"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
          <td VALIGN="TOP" WIDTH="20%"><xsl:value-of select="@date"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
          <td VALIGN="TOP" WIDTH="60%"><xsl:value-of select="@version"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
          <td VALIGN="TOP" WIDTH="10%"><xsl:value-of select="@revision"/><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td>
        </tr>
      </xsl:for-each>
      
    </table>
    
  </xsl:template>
  
</xsl:stylesheet>

