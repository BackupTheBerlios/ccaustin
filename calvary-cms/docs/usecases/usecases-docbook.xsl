<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl
  ="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes"/>
    
    
    <!-- General Header setup to match to root node -->
    <xsl:template match="/">
      <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Matches on the USECASE node -->
    <xsl:template match="usecase">
      <sect1>
        <title><xsl:value-of select="name"/></title>

        <para><emphasis role="bold">Use Case ID:</emphasis><xsl:text> </xsl:text><xsl:value-of select="@id"/></para>
        <para><emphasis role="bold">Use Cases Name:</emphasis><xsl:text> </xsl:text><xsl:value-of select="name"/></para>
        <para><emphasis role="bold">Actor:</emphasis><xsl:text> </xsl:text> <xsl:value-of select="actor"/></para>
        <para><emphasis role="bold">Goal:</emphasis><xsl:text> </xsl:text><xsl:value-of select="goal"/></para>
        <para><emphasis role="bold">Description:</emphasis><xsl:text> </xsl:text><xsl:value-of select="description"/></para>
        <para><emphasis role="bold">Priority:</emphasis><xsl:text> </xsl:text><xsl:value-of select="priority"/></para>
        
        <xsl:apply-templates select="preconditions"/>
        <xsl:apply-templates select="postconditions"/>
        <xsl:apply-templates select="related-usecases"/>
        <xsl:apply-templates select="notes"/>
        <xsl:apply-templates select="event-flow"/>
        
        <para><emphasis role="bold">Alternate Flows:</emphasis></para> 
        
        <xsl:if test="count(alternate-flow) = 0">
          <para>None.</para>
        </xsl:if>
        <xsl:if test="count(alternate-flow) > 0">
          <xsl:apply-templates select="alternate-flow"/>
        </xsl:if>
  
        <xsl:apply-templates select="history"/>
        
      </sect1>

</xsl:template>

<!-- Matches on the PRECONDITION node -->
<xsl:template match="preconditions">
  
  <para><emphasis role="bold">Preconditions:</emphasis>
  <xsl:if test="count(precondition) = 0">
    <para>None.</para>
  </xsl:if>
    <orderedlist>
      <xsl:for-each select="precondition">
        <listitem><xsl:value-of select="."/></listitem>
      </xsl:for-each>
    </orderedlist>
  </para> 

</xsl:template>

<!-- Matches on the POSTCONDITION node -->
<xsl:template match="postconditions">
  
  <emphasis role="bold">Post conditions:</emphasis> 
  <xsl:if test="count(postcondition) = 0">
    <para>None.</para>
  </xsl:if>
  <orderedlist>
    <xsl:for-each select="postcondition">
      <listitem><xsl:value-of select="."/></listitem>
    </xsl:for-each>
  </orderedlist>
  
</xsl:template>

<!-- Matches on the RELATED USE CASES node -->
<xsl:template match="related-usecases">
</xsl:template>

<!-- Matches on the NOTES node -->
<xsl:template match="notes">
</xsl:template>

<!-- Matches on the EVENT FLOW node -->
<xsl:template match="event-flow">
  
  <para><emphasis role="bold">Event Flow:</emphasis> 
  <xsl:if test="count(event) = 0">
    <para>None.</para>
  </xsl:if>
  <orderedlist>
    <xsl:for-each select="event">
      <listitem><xsl:value-of select="."/></listitem>
    </xsl:for-each>
  </orderedlist>
</para>

</xsl:template>

<!-- Matches on the ALTERNATE FLOW node -->
<xsl:template match="alternate-flow">
  <xsl:if test="count(event) = 0">
    <para>None.</para>
  </xsl:if>
  <para><emphasis role="bold">
  <!-- The next step takes the id in the format UCxxx.0 and strips the .0, then -->
  <!-- appends the position number to compute the alternate flow ID -->
  <xsl:number value="position()" format="1"/>:      
  <xsl:value-of select="@name"/></emphasis>
  <orderedlist>
    <xsl:for-each select="event">
      <listitem><xsl:value-of select="."/></listitem>
    </xsl:for-each>
  </orderedlist>
</para>

</xsl:template>

<!-- Matches on the HISTORY node -->
<xsl:template match="history">
</xsl:template>
  
</xsl:stylesheet>

