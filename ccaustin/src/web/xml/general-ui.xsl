<?xml version="1.0"?>
<!--
	This XSL handles the majority of the UI layout and look and feel. It uses
	Javascript to generate dynamic menus and other page features. This provides
	a more "current browser version" feel.

	Import this into your sheet by inserting the following after the xsl:stylesheet 
	tag to activate these templates:

	<xsl:include href="../general-ui.xsl"/>

	
	A variant of this file may offer more search engine or accessibility-friendly
	navigation and less Javascript features for older browsers. 
	
	$Id: general-ui.xsl,v 1.11 2002/06/27 03:08:11 javajames27 Exp $
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
	<!--
	The start of the processing for a page begins here. 
-->
	<xsl:template match="/">
		<!-- 
		By calling the layout template from here, we can override this template using
		standard XSL import and override rules, doing special work before the layout 
		is started.
	-->
		<xsl:call-template name="layout"/>
	</xsl:template>
	<!--
	The HTML layout template. This section is where the look and feel of the site can
	be changed. It handles to header, footer, and placement of the page content. 
	The content is then further processed by the other XSL templates based on the 
	appropriate XML tags.
-->
	<xsl:template name="layout">
		<html>
			<head>
				<title>Calvary Austin / <xsl:value-of select="./content/@title"/>
				</title>
				<link REL="STYLESHEET" href="../css/ca.css"/>
				<meta content="text/html; charset=windows-1252" http-equiv="Content-Type"/>
				<script language="JavaScript1.2" src="../js/mm_menu.js"/>
				<script language="JavaScript" src="../js/main_menu.js"/>
				<script language="JavaScript1.2" src="../js/win.js"/>
				<script language="JavaScript1.2">mmLoadMenus();</script>
				<xsl:apply-templates select="content/script"/>
				<!-- allow our pages to include custom scripting -->
			</head>
			<body bgColor="white" leftMargin="0" text="#2544a9" topMargin="0" vLink="#758ee1">
				<xsl:if test="content/@onUnload != '' ">
					<xsl:attribute name="onUnload"><xsl:value-of select="content/@onUnload"/></xsl:attribute>
				</xsl:if>
				<!-- Header
					The entire page is enclosed in a table that forces the
					width to 800.
				-->
				<table border="0" cellspacing="0" cellpadding="0" width="800">
				  <tr> 
				    <td background="../images/homepage/sidebar_gold.jpg" valign="top" width="131"><a href="../homepage/index.html"><img src="../images/homepage/cal_logo.jpg" border="0" width="131" height="84"/></a></td>
				    <td valign="top" width="99%"><a href="../homepage/index.html"><img src="../images/homepage/cal_austin.jpg" border="0" width="145" height="65"/></a> 
				      <!-- navigation -->
				      <table border="0" cellspacing="0" cellpadding="0">
				        <tr> 
				          <td><a onmouseover="MM_showMenu(window.mm_menu_0610133358_0,0,17,null,'about_us');" onmouseout="MM_startTimeout();" href="../about/about.html">
<img name="about_us" src="../images/homepage/about_us.jpg" border="0" width="72" height="19"/></a></td>
				          <td><a onmouseover="MM_showMenu(window.mm_menu_0610133533_1,0,17,null,'whats_new');" onmouseout="MM_startTimeout();" href="../news/whatsnew.html">
<img name="whats_new" src="../images/homepage/whats_new.jpg" border="0" width="83" height="19"/></a></td>
				          <td><a onmouseover="MM_showMenu(window.mm_menu_0610133621_2,0,17,null,'events');" onmouseout="MM_startTimeout();" href="../calendar/calendar.html">
<img name="events" src="../images/homepage/events.jpg"  border="0" width="46" height="19"/></a></td>
				          <td><a onmouseover="MM_showMenu(window.mm_menu_0610133816_3,0,17,null,'ministries');" onmouseout="MM_startTimeout();" href="../ministries/index.html">
<img name="ministries" src="../images/homepage/ministries_1.jpg" border="0" width="63" height="19"/></a></td>
				          <td><a onmouseover="MM_showMenu(window.mm_menu_0610133833_4,0,17,null,'media');" onmouseout="MM_startTimeout();" href="../media/index.html">
<img name="media" src="../images/homepage/media.jpg" border="0" width="44" height="19"/></a></td>
				          <td><img src="../images/homepage/clear.gif" border="0" width="10" height="10"/></td>
				        </tr>
				      </table>
				      <!-- end navigation -->
				    </td>
				  </tr>
				  <tr> 
				    <td background="../images/homepage/sidebar_gold.jpg" valign="top" align="left" width="131"><img src="../images/homepage/sidebar_gold.jpg" border="0" width="131" height="13"/></td>
				    <td background="../images/homepage/goldbar.jpg" width="400"><img src="../images/homepage/clear.gif" border="0" width="400" height="10"/> 
				      <!-- decrease this image to decrease overall page size -->
				    </td>
				  </tr>
				  <tr> 
				    <td colspan="2" valign="top"> 
				      <table border="0" width="100%" cellspacing="0" cellpadding="0">
				        <tr> 
				          <td width="10" background="../images/homepage/sidebar.jpg"><img src="../images/homepage/clear.gif" border="0" width="10" height="10"/></td>
				          <td width="99%"> 
				            <table width="100%" cellspacing="10">
				              <tr>
				              	<td><!-- BEGIN CONTENT --><xsl:apply-templates/><!-- END CONTENT --></td>
				              </tr>
				              <tr>
				                <td><!-- FOOTER -->
						            <table border="0" cellpadding="0" cellspacing="0">
						              <tbody>
						              <tr>
						                <td align="left" colspan="7"><br/></td>
							      </tr>
						              <tr>
						                <td align="left" colspan="7"><img border="0" src="../images/arcupper.jpg"></img></td>
							      </tr>
						              <tr>
						                <td align="center" colspan="7">
								  <font size="1">
								  Copyright © 1999-2002 Calvary Chapel of Austin<br/>
								  For Website problems or comments, send mail to
								  <a href="mailto:webservant-austin@calvarychapel.org"><img border="0" src="../images/email.gif"></img> webservant-austin@calvarychapel.org</a><br/>
								  Latest update: May 18, 2001<br/>
								  </font>
								</td>
							      </tr>
						              <tr>
						                <td align="left" colspan="7"><img border="0" src="../images/arclower.jpg"></img></td>
							      </tr>
							      </tbody>
							    </table>
				                </td>
				              </tr>
				            </table>
				            
				          </td>
				        </tr>
				      </table>
				    </td>
				  </tr>
				</table>
			</body>
		</html>
	</xsl:template>
	<!--
	Any XML tag that is <text></text> gets processed as-is. This is useful for pages 
	that are only text and no other special data. It can be processed as-is, just like
	standard HTML without any work by the XSL writer.
-->
	<xsl:template match="text">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="script">
		<script language="JavaScript1.2">
			<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
		</script>
	</xsl:template>
</xsl:stylesheet>
