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
<!-- =============================== BEGIN TITLEBAR ================================ -->
<table width=100% border=0 cellpadding=0 cellspacing=0 background='<html:rewrite page="/images/background.jpg"/>'>
<tr><td width=5%></td><td width=85% height=75 align=left>
<img src='<html:rewrite page="/images/logo.jpg"/>' width="252" height="58"/>
<td width=5%>
</td></tr>
</table>

<table border=0 width=100% cellpadding=0 cellspacing=0>
<tr>
<!-- =============================== BEGIN NAVBAR ================================ -->
<td class=c2 width=5%></td>
<!-- LINK 1 -->
<td width=15% class=c2>
<a href="link2.html" class=l2>LINK 1</a>
</td>
<!-- LINK 2 -->
<td width=15% class=c2>
<a href="link2.html" class=l2>LINK 2</a>
</td>
<!-- LINK 3 -->
<td width=15% class=c2>
<a href="link3.html" class=l2>LINK 3</a>
</td>
<!-- LINK 4 -->
<td width=15% class=c2>
<a href="link4.html" class=l2>LINK 4</a>
</td>
<!-- LINK 5 -->
<td width=15% class=c2>
<a href="link5.html" class=l2>LINK 5</a>
</td>
<!-- LINK 6 -->
<td width=15% class=c2>
<a href="link6.html" class=l2>LINK 6</a>
</td>
<!-- =============================== END NAVBAR ================================ -->
</td><td class=c2 width=5%></td></tr></table>

<table width=100% cellpadding=0 cellspacing=0>
<tr>
<!-- =============================== BEGIN LEFT COLUMN ================================ -->
<td class=c6 height=20 width=30% valign=top>
<center>
<br><br>
<table width=80% cellpadding=0 cellspacing=0 class=c3>
<tr><td width=100% class=c4>
<img src='<html:rewrite page="/images/subhead1.jpg"/>' width="184" height="20"/>
</td></tr>
<!-- LINK 1 -->
<tr><a href="browse.do?site=www.calvaryaustin.org%path=/"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
Browse Web Pages
</td></a></tr>
<!-- LINK 2 -->
<tr><a href="link2.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 2
</td></a></tr>
<!-- LINK 3 -->
<tr><a href="link3.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 3
</td></a></tr>
<!-- LINK 4 -->
<tr><a href="link4.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 4
</td></a></tr>
<!-- SUBHEADING BREAK -->
<tr><td width=100% height=10>
</td></tr>
<!-- SUBHEADING 2 -->
<tr><td width=100% class=c4>
<img src='<html:rewrite page="/images/subhead2.jpg"/>' width="184" height="20"/>
</td></tr>
<!-- LINK 5 -->
<tr><a href="link5.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 5
</td></a></tr>
<!-- LINK 6 -->
<tr><a href="link6.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 6
</td></a></tr>
<!-- LINK 7 -->
<tr><a href="link7.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 7
</td></a></tr>
<!-- LINK 8 -->
<tr><a href="link8.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 8
</td></a></tr>
<!-- LINK 9 -->
<tr><a href="link9.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 9
</td></a></tr>
<!-- LINK 10-->
<tr><a href="link10.html"><td width=100% height=20 class=l1a onmouseover="this.className='l1b';" onmouseout="this.className='l1a';">
&nbsp;&nbsp;&nbsp;<img src='<html:rewrite page="/images/dot.jpg"/>' height="10" width="10"/>&nbsp;&nbsp;
LINK 10
</td></a></tr>
<!-- SUBHEADING BREAK -->
<tr><td width=100% height=10>
</td></tr>
<tr>
<td class=c1 height=5></tr>
<tr>
<td  height=10 class=c2></td></tr>
</table>
</center>
</td>
<!-- =============================== END LINKS ================================ -->

    <td width=70% class="contentarea"> <table width=100% cellpadding=0 cellspacing=0>
        <tr> 
          <td class=c6 valign=top><div class=h3><tiles:getAsString name="title"/></div></td>          
          <td class="contentarea"></td>
        </tr>
        <td width=80% class=c6 valign=top>  <br/>
            <!-- =============================== BEGIN CONTENT ================================ -->
			<tiles:insert attribute="body"/>	
            <!-- =============================== END CONTENT ================================ -->
          </td>
        <td width=10% class="contentarea"></td>
        </tr>
      </table>
</td>
</table>

<table width=100% cellpadding=0 cellspacing=0>
<tr>
<td height=1 class=c4><br/></td></tr>
<tr>
<td height=10 class=c1></td></tr>
<tr><td  height=100 class=c2>
<center><a href="www.calvarychapel.org" class=l4>Calvary Chapel of Austin</center>
<center><a href="http://www.calvarychapel.org" class=l4>www.calvarychapel.org</center>
</td></tr>
</table>
</body>
</html:html>