<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld"      prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld"      prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld"     prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-template.tld"  prefix="template" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld"     prefix="tiles" %>
<%@ taglib uri="/WEB-INF/slide-struts.tld"     prefix="slide" %>

<html:html locale='true'>
<head>

<link rel="stylesheet" type="text/css" href='<html:rewrite page="/style.css"/>'>
<title><tiles:getAsString name="title"/> - Calvary Chapel of Austin</title>
</head>

<body marginheight=0 marginwidth=0 topmargin=0 leftmargin=0>

<!-- Outer table to make it fill the browser screen -->
<table width="100%" height="100%" cellpadding=0 cellspacing=0>

<!-- outer table row begin -->  
<tr>
<td valign="top" align="left" height="1">
  
<!-- =============================== BEGIN TITLEBAR ================================ -->
<table width=100% border=0 cellpadding=0 cellspacing=0>
<tr class="header"><td width="125" align="left">
<img src='<html:rewrite page="/images/CCLogo-xsmall.jpg"/>' width="125" height="101"/></td>
<td width="5%%">&nbsp;</td>
<td width="89%"><p>Control Panel</p></td>
<td width="5%">&nbsp;</td></tr>
</table>

</td>
</tr>
<!-- outer table row end -->  
<!-- outer table row begin -->  
<tr>
<td valign="top" align="left" height="1">

<!-- =============================== BEGIN NAVBAR ================================ -->
<table border=0 width=100% cellpadding=0 cellspacing=0>
<tr class="navButtonBar" valign="center">
<!-- LINK 1 -->
<td class="navButtonBorder" nowrap="true">
<html:link action="/dashboard" styleClass="navButtonLink">My Dashboard</html:link>
</td>
<!-- LINK 2 -->
<td class="navButtonBorder" nowrap="true">
<html:link action="/browser" styleClass="navButtonLink">Manage Web Site</html:link>
</td>
<!-- LINK 3 -->
<td class="navButtonBorder" nowrap="true">
<a href="link3.html" class="navButtonLink">LINK 3</a>
</td>
<!-- LINK 4 -->
<td class="navButtonBorder" nowrap="true">
<a href="link4.html" class="navButtonLink">LINK 4</a>
</td>
<!-- LINK 5 -->
<td class="navButtonBorder" nowrap="true">
<a href="link5.html" class="navButtonLink">LINK 5</a>
</td>
<!-- LINK 6 -->
<td class="navButtonBorder" nowrap="true">
<a href="link6.html" class="navButtonLink">LINK 6</a>
</td>
</td>
<td class="navButtonBorder" width=90%></td></tr></table>
<!-- =============================== END NAVBAR ================================ -->

</td>
</tr>
<!-- outer table row end -->  
<!-- outer table row begin -->  
<tr>
<td valign="top" align="left" height="99%">

<table width=100% cellpadding=0 cellspacing=0>
<tr>
<!-- =============================== BEGIN LEFT COLUMN ================================ -->
<td class="tableLayout" height=20 width=30% valign=top>
<center>
<br><br>
<table width=80% cellpadding=0 cellspacing=0 class="tableFloating">
<!-- SUBHEADING BREAK
<tr class="tableFloatingHeader"><td width=100% height=10>&nbsp;</td></tr> -->
<!-- SUBHEADING 2 -->
<tr><td width=100% class="tableFloatingHeader">How do I....?</td></tr>
<!-- LINK 5 -->
<tr><a href="link5.html"><td width=100% height=20 class="tableFloatingLink" onmouseover="this.className='tableFloatingLinkSelect';" onmouseout="this.className='tableFloatingLink';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/bullet.gif"/>' height="9" width="9"/>&nbsp;&nbsp;
LINK 5
</td></a></tr>
<!-- LINK 6 -->
<tr><a href="link6.html"><td width=100% height=20 class="tableFloatingLink" onmouseover="this.className='tableFloatingLinkSelect';" onmouseout="this.className='tableFloatingLink';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/bullet.gif"/>' height="9" width="9"/>&nbsp;&nbsp;
LINK 6
</td></a></tr>
<!-- LINK 7 -->
<tr><a href="link7.html"><td width=100% height=20 class="tableFloatingLink" onmouseover="this.className='tableFloatingLinkSelect';" onmouseout="this.className='tableFloatingLink';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/bullet.gif"/>' height="9" width="9"/>&nbsp;&nbsp;
LINK 7
</td></a></tr>
<!-- LINK 8 -->
<tr><a href="link8.html"><td width=100% height=20 class="tableFloatingLink" onmouseover="this.className='tableFloatingLinkSelect';" onmouseout="this.className='tableFloatingLink';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/bullet.gif"/>' height="9" width="9"/>&nbsp;&nbsp;
LINK 8
</td></a></tr>
<!-- LINK 9 -->
<tr><a href="link9.html"><td width=100% height=20 class="tableFloatingLink" onmouseover="this.className='tableFloatingLinkSelect';" onmouseout="this.className='tableFloatingLink';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/bullet.gif"/>' height="9" width="9"/>&nbsp;&nbsp;
LINK 9
</td></a></tr>
<!-- LINK 10-->
<tr><a href="link10.html"><td width=100% height=20 class="tableFloatingLink" onmouseover="this.className='tableFloatingLinkSelect';" onmouseout="this.className='tableFloatingLink';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/bullet.gif"/>' height="9" width="9"/>&nbsp;&nbsp;
LINK 10
</td></a></tr>
<!-- SUBHEADING BREAK -->
<tr class="tableLayout"><td width=100% height=10>
</td></tr>
</table>
</center>
</td>
<!-- =============================== END LINKS ================================ -->

    <td width=70% class="contentarea"> <table width=100% cellpadding=0 cellspacing=0>
        <tr> 
          <td class="tableLayout" valign=top><div class="contentHead1"><tiles:getAsString name="title"/></div></td>          
          <td class="contentarea"></td>
        </tr>
        <td width=80% class="tableLayout" valign=top>  <br/>
            <!-- =============================== BEGIN CONTENT ================================ -->
			<tiles:insert attribute="body"/>	
            <!-- =============================== END CONTENT ================================ -->
          </td>
        <td width=10% class="contentarea"></td>
        </tr>
      </table>
</td>
</table>

</td>
</tr>
<!-- outer table row end -->  
<!-- outer table row begin -->  
<tr>
<td valign="top" align="left" height="1">

<table width=100% cellpadding=0 cellspacing=0 class="tableLayout">
    <tr><td class="footer"><a href="http://www.calvaryaustin.org" class="navExternalLink">Calvary Chapel of Austin</a></td></tr>
</table>

</td>
</tr>
<!-- outer table row end -->  
<!-- outer table end -->  
</table>

</body>
</html:html>