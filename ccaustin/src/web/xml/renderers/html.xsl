<?xml version="1.0"?>
    
<!--
	This XSL handles the generic needs of text transformation. It will properly render paragraphs, images, links, 
	tables, lists, etc. 
	
	Import this if your sheet requires HTML tags and include the following
	after the xsl:stylesheet tag to activate these templates:

	<xsl:include href="../general-html.xsl"/>
	
	Place all tag processing templates in here that are HTML-based or text-processing based.
	
	When a new tag is needed, consider using its HTML equivalent if its name and format is common english. 
	(e.g. <a/> is not really anything meaningful for the average person, but <link/> is)
	
	$Id: html.xsl,v 1.2 2002/12/17 01:02:35 javajames27 Exp $
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
	 ============================
  	 HTML tags
      ============================ 
-->

<!-- Map and area tags for the image map in the home fellowship page. May want to clean this up later -->
<xsl:template match="map">
      <xsl:element name="map">
        <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
        <xsl:apply-templates select="area"/>
      </xsl:element>
</xsl:template>
<xsl:template match="area">
      <xsl:element name="area">
        <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
        <xsl:attribute name="shape"><xsl:value-of select="@shape"/></xsl:attribute>
        <xsl:attribute name="coords"><xsl:value-of select="@coords"/></xsl:attribute>
        <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
        <xsl:attribute name="alt"><xsl:value-of select="@alt"/></xsl:attribute>
      </xsl:element>
</xsl:template>

<!-- 
	 ============================
  	 Custom tags
      ============================ 
-->

<!--
	<p/> Paragraph Tag
	
	Groups a paragraph of text together. All text to be shown on a page should be wrapped with this tag. 
	
	Body: The text to display

	Attributes: 
	
		align - left, right, center alignment

	Processes Subtags: yes

-->
 <xsl:template match="p">
    <p> 
	<xsl:attribute name="align">
          <xsl:value-of select="@align"/>
       </xsl:attribute>
	<xsl:apply-templates select="*|text()"/>
   </p>
  </xsl:template>

<!--
	<br/> Line Break tag
	
	Inserts a line break (i.e. a carriage return) into the HTML. Use this tag if you want to force text to the next 
	line rather than word wrap within a paragraph tag.

	Body: No

	Attributes:
	
		NONE. 
		
	Processes Subtags: No
	
-->
 <xsl:template match="br">
    <br/> 
  </xsl:template>

<!--
	<img/> Image tag
	
	Inserts an image into the page. It is suggested to use relative paths (e.g. ../images/myimage.jpg) whenever
	possible. 
	
	Body: No

	Attributes:
	
		src - the path to the image
		* - all others copied verbatim
		
	Processes Subtags: No
	
-->
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

<!--
	<link/> Link tag
	
	Inserts a hyperlink into the page, following the <a/> tag format. 
	
	Body: the body of the tag is used to produce the text of the link itself.
	
	Attributes:
	
		href - the relative or absolute link (e.g. ../my/page.html or http://www.mysite.com/my/page.html)
		
	Processes Subtags: No
-->
<xsl:template match="link">
	  <xsl:element name="a">
	    <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
	    <xsl:value-of select="text()"/>
	  </xsl:element>
</xsl:template>

<!-- 
	<table/> Table tag
	
	Defines a table (75% of the current layout area) to be included within the page. The goal is to use this and its 
	child tags, <row/> and <data/> to 	produce a table without worrying about the HTML code needed behind 
	the scenes. 
	
	Body: Should contain at least 1 <row/> tagset
	
	Attributes:
	
		border - true if there should be a border. If not specified, the default is no border.
		heading - the table heading. If not specified, no table heading is rendered
		
	Processes Subtags: Yes - <row/>
-->
<xsl:template match="table">
	<table width="75%" cellspacing="2">
		<xsl:attribute name="border">
			 <xsl:choose>
			     <xsl:when test="@border = 'true' ">1</xsl:when>
			     <xsl:otherwise>0</xsl:otherwise>
		      </xsl:choose>
		</xsl:attribute>
		<xsl:if test="@heading != ''">
  		  <tr><td colspan="2" class="tableheader"><xsl:value-of select="@heading"/></td></tr>
		</xsl:if>
		<xsl:apply-templates select="row"/>
	</table>
</xsl:template>

<!--
	<row/> Row tag
	
	Declares a new table row. 
	
	Body: Should contain at least 1 <data/> tagset
	
	Attributes:
	
		NONE.

	Processes Subtags: Yes - <data/>
-->
<xsl:template match="row">
	<tr><xsl:apply-templates/></tr>
</xsl:template>

<!--
	<data/> Data tag
	
	Declares a new table cell of data. 
	
	Body: The text for the cell
	
	Attributes:
	
		label - make the cell render as a labeled cell (bolder text and nowrap)
                NOTE: You should now use the <label> tag instead 

	Processes Subtags: No.
-->
<xsl:template match="data">
	<td>
	<xsl:if test="@label = 'true' ">
 		  <xsl:attribute name="class">heading</xsl:attribute>
 		  <xsl:attribute name="nowrap">true</xsl:attribute>
	</xsl:if>
	<xsl:if test="@align != '' ">
 		  <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
	</xsl:if>
        <xsl:attribute name="valign">top</xsl:attribute>
	<xsl:apply-templates select="*|text()"/></td>
</xsl:template>

<!--
	<label/> Label tag
	
	Declares a new table cell of data that is larger and bold for labeling a row or column. 
	
	Body: The text for the label
	
	Attributes: N/A

	Processes Subtags: Yes.
-->
<xsl:template match="label">
	<td>
          <xsl:attribute name="class">heading</xsl:attribute>
          <xsl:attribute name="nowrap">true</xsl:attribute>
          <xsl:if test="@align != '' ">
            <xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
          </xsl:if>
          <xsl:attribute name="valign">top</xsl:attribute>
          <xsl:apply-templates select="*|text()"/></td>
</xsl:template>

<!--
	<note/> Note tag
	
	Renders text with a special style for "Note: xxx" text
	
	Body: The text of the note, including "Note:" 
	
	Attributes:
	
		NONE
		
	Processes Subtags: Yes
-->
<xsl:template match="note">
	<div class="note"><xsl:apply-templates select="text()"/></div>
</xsl:template>

<!--
	<emphasis/> Emphasis tag
	
	Renders text with a special style for "emphasis" text (italic text)
	
	Body: The text of the emphasis 
	
	Attributes:
	
		NONE
		
	Processes Subtags: Yes
-->
<xsl:template match="emphasis">
	<div class="emphasis"><xsl:apply-templates select="text()"/></div>
</xsl:template>

<!--
	<heading/> Heading tag
	
	Renders text with a special style for section headings (considered heading level 2).
	
	Body: The text of the heading
	
	Attributes:
	
		NONE
		
	Processes Subtags: Yes
-->
<xsl:template match="heading">
	<p class="heading"><xsl:apply-templates select="text()"/></p>
</xsl:template>

<!--
	<subheading/> Subheading tag
	
	Renders text with a special style for section sub headings (considered heading level 3).
	
	Body: The text of the subheading
	
	Attributes:
	
		NONE
		
	Processes Subtags: Yes
-->
<xsl:template match="subheading">
	<p class="subheading"><xsl:apply-templates select="text()"/></p>
</xsl:template>

<!--
	<subtext/> Subtext tag
	
	Renders text with a special style for subtexts (fineprint, small notifications).
	
	Body: The text of the subtext
	
	Attributes:
	
		NONE
		
	Processes Subtags: Yes
-->
<xsl:template match="subtext">
	<p class="subtext"><xsl:apply-templates select="text()"/></p>
</xsl:template>

<!--
	<sidetext/> Sidetext tag
	
	Renders text with a special style for sidetexts (small notifications with smaller text).
	
	Body: The text of the sidetext
	
	Attributes:
	
		NONE
		
	Processes Subtags: Yes
-->
<xsl:template match="sidetext">
	<p class="sidetext"><xsl:apply-templates select="text()"/></p>
</xsl:template>


<!--
	<list/> List tag
	
	Renders a list that may be ordered (numbered) or unordered (bulleted).
	
	Body: Yes - <item/> tags
	
	Attributes:
	
		ordered - (optional) if true, then generates an ordered list
		
	Processes Subtags: <item/> tags
-->
<xsl:template match="list">
	 <xsl:choose>
	     <xsl:when test="@ordered = 'true' "><xsl:element name="ol"><xsl:if test="@letter = 'true'"><xsl:attribute name="type">A</xsl:attribute></xsl:if><xsl:apply-templates select="item"/></xsl:element></xsl:when>
	     <xsl:otherwise><xsl:element name="ul"><xsl:if test="@letter = 'true'"><xsl:attribute name="type">A</xsl:attribute></xsl:if><xsl:apply-templates select="item"/></xsl:element></xsl:otherwise>
      </xsl:choose>
</xsl:template>

<!--
	<item/> Item tag
	
	Renders a list item 
	
	Body: The text of the item
	
	Attributes:
	
		NONE
		
	Processes Subtags: Yes
-->
<xsl:template match="item">
	<li><xsl:apply-templates select="*|text()"/></li>
</xsl:template>

<!--
	<verse/> verse tag
	
	Renders verse 
	
	Body: The text of the verse
	
	Attributes:
	
		ref - the reference text being quoted
		
	Processes Subtags: Yes
-->
<xsl:template match="verse">
	<span class="verseref"><xsl:value-of select="@ref"/></span><xsl:text> </xsl:text><span class="verse"> <xsl:apply-templates select="*|text()"/></span>
</xsl:template>

<xsl:template match="footnote-ref">
  [<a href="#footnote_{@ref}"><xsl:value-of select="@ref"/></a>]
</xsl:template>

<xsl:template match="footnotes">
  <hr width="50%"/>
  <xsl:apply-templates select="footnote"/>
</xsl:template>

<xsl:template match="footnote">
  <a name="footnote_{@id}"/><span class="footnote">[<xsl:value-of select="@id"/>]<xsl:text> </xsl:text><xsl:value-of select="text()"/></span><br></br>
</xsl:template>

<xsl:template match="script">
  <script language="{@language}" type="{@type}" src="{@src}"></script>
</xsl:template>

<xsl:template match="html">
  <!-- copy all child tags verbatim to the target page -->
  <xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
