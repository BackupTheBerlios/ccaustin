<?xml version="1.0"?>
    
<!-- 

	Calvary View Live Template
	
	$Id: viewlive.xsl,v 1.3 2004/05/14 18:29:11 gregk Exp $
	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:include href="html.xsl"/>

<xsl:template match="live-feed">
	    <table width="640" cellspacing="0" cellpadding="0" border="0" marginwidth="0" marginheight="0">
	      <tr>
	        <td align="center"><br/></td>
	      </tr>
	      <tr>
	        <td align="center"><br/></td>
	      </tr>
	      <tr>
	        <td align="center"><br/></td>
	      </tr>
	      <tr>
	        <td align="center"><br/></td>
	      </tr>
	      <tr>
	        <td align="center"><img src="../images/vidallen.jpg" alt="View the Calvary Live service"/></td>
	      </tr>
	      <tr>
	        <td align="center"><img src="../images/homepage/livmsg.jpg"/></td>
	      </tr>
	      <tr>
	        <td align="center"><br/></td>
	      </tr>
	      <tr>
	        <td align="center"><br/></td>
	      </tr>
	      <tr>
	        <td align="center"><br/></td>
	      </tr>
	      <tr>
	        <td align="center"><br/></td>
	      </tr>
<!--
	      <tr>
	        <td colspan="6" align="center"><br/></td>
	      </tr>
	      <tr>
		<td width="25"  height="20"><img src="../images/viewlive/bgli000.jpg" width="25"  height="20" border="0"/></td>
		<td width="19"  height="20"><img src="../images/viewlive/bgli001.jpg" width="19"  height="20" border="0"/></td>
		<td width="44"  height="20"><img src="../images/viewlive/bgli002.jpg" width="44"  height="20" border="0"/></td>
		<td width="198" height="20"><img src="../images/viewlive/bgli003.jpg" width="198" height="20" border="0"/></td>
		<td width="44"  height="20"><img src="../images/viewlive/bgli004.jpg" width="44"  height="20" border="0"/></td>
		<td width="21"  height="20"><img src="../images/viewlive/bgli005.jpg" width="21"  height="20" border="0"/></td>
		<td width="19"  height="20"><img src="../images/viewlive/bgli006.jpg" width="19"  height="20" border="0"/></td>
	      </tr>
	      <tr>
		<td width="25" height="36"><img src="../images/viewlive/bgli007.jpg" width="25" height="36" border="0"/></td>
		<td width="19" height="36"><img src="../images/viewlive/bgli008.jpg" width="19" height="36" border="0"/></td>
		<td width="286" height="36" colspan="3" align="center" valign="top" background="../images/viewlive/bgtac.jpg">
		  <object id="video1" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" height="30" width="280">
		  <param name="controls" value="TACCtrl"/>
		  <param name="console" value="Live"/>
		  <embed type="audio/x-pn-realaudio-plugin"
		    console="Live" controls="TACCtrl" height="29" width="280" autostart="false"/>
		  </object>
		</td>
		<td width="21" height="36"><img src="../images/viewlive/bgli012.jpg" width="21" height="36" border="0"/></td>
		<td width="19" height="36"><img src="../images/viewlive/bgli013.jpg" width="19" height="36" border="0"/></td>
	      </tr>
	      <tr>
		<td width="25" height="12"><img src="../images/viewlive/bgli014.jpg" width="25" height="12"/></td>
		<td width="19" height="12"><img src="../images/viewlive/bgli015.jpg" width="19" height="12"/></td>
		<td width="44" height="12"><img src="../images/viewlive/bgli016.jpg" width="44" height="12"/></td>
		<td width="198" height="12"><img src="../images/viewlive/bgli017.jpg" width="198" height="12"/></td>
		<td width="44" height="12"><img src="../images/viewlive/bgli018.jpg" width="44" height="12"/></td>
		<td width="21" height="12"><img src="../images/viewlive/bgli019.jpg" width="21" height="12"/></td>
		<td width="19" height="12"><img src="../images/viewlive/bgli020.jpg" width="19" height="12"/></td>
	      </tr>
	      <tr>
		<td width="25" height="150" ><img src="../images/viewlive/bgli021.jpg" width="25" height="150"/></td>
		<td width="19" height="150" ><img src="../images/viewlive/bgli022.jpg" width="19" height="150"/></td>
		<td width="44" height="150" ><img src="../images/viewlive/bgli023.jpg" width="44" height="150"/></td>
		<td width="198" height="150" background="../images/viewlive/bgli024.jpg">
		  <object id="video1" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" height="144" width="192">
		  <param name="controls" value="ImageWindow"/>
		  <param name="console" value="Live"/>
		  <param name="autostart" value="false"/>
		  <xsl:element name="param">
		  	<xsl:attribute name="name">src</xsl:attribute>
		  	<xsl:attribute name="value"><xsl:value-of select="embedded/@href"/></xsl:attribute>
		  </xsl:element>
		  <xsl:element name="embed">
		  	<xsl:attribute name="src"><xsl:value-of select="embedded/@href"/></xsl:attribute>
		  	<xsl:attribute name="type">audio/x-pn-realaudio-plugin</xsl:attribute>
		  	<xsl:attribute name="console">Live</xsl:attribute>
		  	<xsl:attribute name="controls">ImageWindow</xsl:attribute>
		  	<xsl:attribute name="height">144</xsl:attribute>
		  	<xsl:attribute name="width">192</xsl:attribute>
		  	<xsl:attribute name="autostart">false</xsl:attribute>
		  </xsl:element>
		  </object>
		</td>
		<td width="44" height="150" ><img src="../images/viewlive/bgli025.jpg" width="44" height="150"/></td>
		<td width="21" height="150" ><img src="../images/viewlive/bgli026.jpg" width="21" height="150"/></td>
		<td width="19" height="150" ><img src="../images/viewlive/bgli027.jpg" width="19" height="150"/></td>
	      </tr>
	      <tr>
		<td width="25" height="11"><img src="../images/viewlive/bgli028.jpg" width="25" height="11"/></td>
		<td width="19" height="11"><img src="../images/viewlive/bgli029.jpg" width="19" height="11"/></td>
		<td width="44" height="11"><img src="../images/viewlive/bgli030.jpg" width="44" height="11"/></td>
		<td width="198" height="11"><img src="../images/viewlive/bgli031.jpg" width="198" height="11"/></td>
		<td width="44" height="11"><img src="../images/viewlive/bgli032.jpg" width="44" height="11"/></td>
		<td width="21" height="11"><img src="../images/viewlive/bgli033.jpg" width="21" height="11"/></td>
		<td width="19" height="11"><img src="../images/viewlive/bgli034.jpg" width="19" height="11"/></td>
	      </tr>
	      <tr>
		<td width="25" height="66"><img src="../images/viewlive/bgli035.jpg" width="24" height="66"/></td>
		<td width="326" height="66" colspan="5" background="../images/viewlive/bgpnl.jpg">
		  <object id="video1" classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" height="60" width="320">
		  <param name="controls" value="All"/>
		  <param name="console" value="Live"/>
		  <embed type="audio/x-pn-realaudio-plugin"
		    console="Live" controls="ControlPanel,StatusPanel" height="60" width="320" autostart="false"/>
		  </object>
		</td>
		<td width="19" height="66"><img src="../images/viewlive/bgli041.jpg" width="19" height="66"/></td>
	      </tr>
	      <tr>
		<td width="25" height="15"><img src="../images/viewlive/bgli042.jpg" width="25" height="15"/></td>
		<td width="19" height="15"><img src="../images/viewlive/bgli043.jpg" width="19" height="15"/></td>
		<td width="44" height="15"><img src="../images/viewlive/bgli044.jpg" width="44" height="15"/></td>
		<td width="198" height="15"><img src="../images/viewlive/bgli045.jpg" width="198" height="15"/></td>
		<td width="44" height="15"><img src="../images/viewlive/bgli046.jpg" width="44" height="15"/></td>
		<td width="21" height="15"><img src="../images/viewlive/bgli047.jpg" width="21" height="15"/></td>
		<td width="19" height="15"><img src="../images/viewlive/bgli048.jpg" width="19" height="15"/></td>
	      </tr>
-->
	    </table>
	    
	    <p>To view using Windows Media Player,
	  <xsl:element name="a">
	    <xsl:attribute name="href"><xsl:value-of select="external/@href"/></xsl:attribute>
	    click here
	  </xsl:element>.  Our webcast requires Windows Media Player Series 9 or later.</p>
</xsl:template>

</xsl:stylesheet>
