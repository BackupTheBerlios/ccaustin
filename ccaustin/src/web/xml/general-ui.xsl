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
	
	$Id: general-ui.xsl,v 1.9 2002/06/25 17:13:49 javajames27 Exp $
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
				<script language="JavaScript" src="../js/main_menu.js"/>
				<script language="JavaScript1.2" src="../js/mm_menu.js"/>
				<script language="JavaScript1.2" src="../js/win.js"/>
				<script type="text/javascript" language="JavaScript1.2">mmLoadMenus();</script>
				<xsl:apply-templates select="content/script"/>
				<!-- allow our pages to include custom scripting -->
			</head>
			<body bgColor="white" leftMargin="0" text="#2544a9" topMargin="0" vLink="#758ee1">
				<xsl:if test="content/@onUnload != '' ">
					<xsl:attribute name="onUnload"><xsl:value-of select="content/@onUnload"/></xsl:attribute>
				</xsl:if>
				<!--
	The main page structure is the header followed by body.
	The header contains 2 regions: logo + menus, and variable
	content, separated as 2 table cells.  The right cell can
	contain page-specific images, titles, whatever.
	The entire page is enclosed in a table that forces the
	width to 640.
-->
				<table width="800" cellspacing="0" cellpadding="0" border="1" bgcolor="#ffffff">
					<tr>
						<td width="131" height="65" valign="top" align="left" colspan="2" rowspan="2"><img alt="" border="0" height="84" width="131" src="../images/header/proto-12_r1_c1.jpg" name="proto12_r1_c1"/>
						</td>
						<td width="145" height="65" valign="top" align="left" colspan="2"><img alt="" border="0" height="65" width="145" src="../images/header/proto-12_r1_c3.jpg" name="proto12_r1_c3"/>
						</td>
						<td width="224" height="65" valign="top" align="left" bgcolor="#ffffff" colspan="5"><img alt="" border="0" height="65" width="224" src="../images/header/spacer.gif"/>
						</td>
						<td width="1" height="65" valign="top" align="left"><img alt="" border="0" height="65" width="1" src="../images/header/spacer.gif"/>
						</td>
					</tr>
					<tr>
						<td height="19" valign="top" align="left" width="800"><a onmouseover="MM_showMenu(window.mm_menu_0610133358_0,0,17,null,'proto12_r2_c3');" onmouseout="MM_startTimeout();" href="#">
								<img alt="" border="0" height="19" width="72" src="../images/header/proto-12_r2_c3.jpg" name="proto12_r2_c3"/>
							</a><a onmouseover="MM_showMenu(window.mm_menu_0610133533_1,0,17,null,'proto12_r2_c4');" onmouseout="MM_startTimeout();" href="#">
								<img alt="" border="0" height="19" width="83" src="../images/header/proto-12_r2_c4.jpg" name="proto12_r2_c4"/>
							</a><a onmouseover="MM_showMenu(window.mm_menu_0610133621_2,0,17,null,'proto12_r2_c6');" onmouseout="MM_startTimeout();" href="#">
								<img alt="" border="0" height="19" width="46" src="../images/header/proto-12_r2_c6.jpg" name="proto12_r2_c6"/>
							</a><a onmouseover="MM_showMenu(window.mm_menu_0610133816_3,0,17,null,'proto12_r2_c7');" onmouseout="MM_startTimeout();" href="#">
								<img alt="" border="0" height="19" width="63" src="../images/header/proto-12_r2_c7.jpg" name="proto12_r2_c7"/>
							</a><a onmouseover="MM_showMenu(window.mm_menu_0610133833_4,0,17,null,'proto12_r2_c8');" onmouseout="MM_startTimeout();" href="#">
								<img alt="" border="0" height="19" width="44" src="../images/header/proto-12_r2_c8.jpg" name="proto12_r2_c8"/>
							</a><img alt="" border="0" height="19" width="61" src="../images/header/proto-12_r2_c9.jpg" name="proto12_r2_c9"/><img alt="" border="0" height="19" width="1" src="../images/header/spacer.gif"/>
						</td>
					</tr>
					<tr>
						<td width="800" valign="top" align="left" colspan="10"><img alt="" border="0" height="13" width="10" src="../images/header/proto-12_r3_c1.jpg" name="proto12_r3_c1"/>							<img alt="" border="0" height="13" width="490" src="../images/header/proto-12_r3_c2.jpg" name="proto12_r3_c2"/>
						</td>
					</tr>
					<tr>
						<td width="800" background="../images/header/proto-12_r4_c1.jpg" bgcolor="#ffffff" colspan="10">
							<table>
								<tr>
									<td width="25">
										<br/>
									</td>
									<td valign="top" align="left">
										<xsl:apply-templates/>
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
