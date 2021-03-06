<?xml version="1.0"?>
<!--
 This XSL handles the majority of the UI layout and look and feel. It uses
 Javascript to generate dynamic menus and other page features. This provides
 a more "current browser version" feel.

 Other variants of this file may offer more search engine or accessibility-friendly
 navigation and less Javascript features for older browsers. 
 
 $Id: default.xsl,v 1.8 2004/03/18 08:13:42 gregk Exp $
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="html" indent="yes"/>
 
 <xsl:param name="TODAY">N/A</xsl:param>
 <xsl:param name="VERSION">0.00</xsl:param>
 <xsl:param name="DATE">00000000</xsl:param>

<!--
 The HTML layout template. This section is where the look and feel of the site can
 be changed. It handles to header, footer, and placement of the page content. 
 The content is then further processed by the other XSL templates based on the 
 appropriate XML tags.
 -->
 <xsl:template name="page">
  <html>
   <head>
    <!--meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/ -->
    <title>Calvary Austin / <xsl:value-of select="./content/@title"/>
    </title>
    <link REL="STYLESHEET" href="../css/ca.css"/>
    <meta content="text/html" http-equiv="Content-Type"/>
    <xsl:apply-templates select="content/script"/>
    <!-- allow our pages to include custom scripting -->
   </head>
   <body onload="runSlideShow()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" text="#2544a9" bgcolor="#FFFFFF">
    <script language="JavaScript1.2" src="../js/mm_menu.js"/>
    <script language="JavaScript1.2" src="../js/main_menu.js"/>
    <script language="JavaScript1.2" src="../js/win.js"/>
    <script language="JavaScript1.2" src="../js/events/slideshow.js"/>
    <script language="JavaScript1.2">
      var onWindows = navigator.platform ? navigator.platform == "Win32" : false;
      var macIE = document.all &amp;&amp; !onWindows;
      if( !macIE )
      {
        mmLoadMenus();
      }
    </script>
    <xsl:if test="content/@onUnload != '' ">
     <xsl:attribute name="onUnload"><xsl:value-of select="content/@onUnload"/></xsl:attribute>
    </xsl:if>
    <!-- 
           Header
    -->
    <table border="0" cellspacing="0" cellpadding="0" width="100%">
      <tr> 
        <td background="../images/homepage/sidebar_gold.jpg" valign="top" width="131"><a href="../homepage/index.html"><img src="../images/homepage/cal_logo.jpg" border="0" width="131" height="84"/></a></td>
        <td background="../images/homepage/clouds.jpg" valign="top" align="left" width="99%"><a href="../homepage/index.html"><img src="../images/homepage/cal_austin.jpg" border="0" width="145" height="65"/></a> 
          <!-- navigation -->
          <table border="0" cellspacing="0" cellpadding="0" width="100%">
            <tr> 
              <td align="left" width="460" background="../images/homepage/blue.jpg"><a onmouseover="MM_showMenu(window.menu_about,0,17,null,'about_us');" onmouseout="MM_startTimeout();" href="../about/about.html">
<img name="about_us" src="../images/homepage/about_us.jpg" border="0" width="72" height="19"/></a>
              <a onmouseover="MM_showMenu(window.menu_news,0,17,null,'whats_new');" onmouseout="MM_startTimeout();" href="../news/index.html">
<img name="whats_new" src="../images/homepage/whats_new.jpg" border="0" width="83" height="19"/></a>
              <a onmouseover="MM_showMenu(window.menu_calendar,0,17,null,'events');" onmouseout="MM_startTimeout();" href="../calendar/calendar.html">
<img name="events" src="../images/homepage/events.jpg"  border="0" width="46" height="19"/></a>
              <a onmouseover="MM_showMenu(window.menu_ministries,0,17,null,'ministries');" onmouseout="MM_startTimeout();" href="../ministries/index.html">
<img name="ministries" src="../images/homepage/ministries_1.jpg" border="0" width="63" height="19"/></a>
              <a onmouseover="MM_showMenu(window.menu_media,0,17,null,'media');" onmouseout="MM_startTimeout();" href="../media/index.html">
<img name="media" src="../images/homepage/media.jpg" border="0" width="44" height="19"/></a>     
              <a href="../about/contact.html" alt="Get directions">
<img name="directions" src="../images/homepage/directions.jpg" border="0" width="61" height="19"/></a>

              <a href="../calendar/schedule.html" alt="Find service times">
<img name="servicetimes" src="../images/homepage/servicetimes.jpg" border="0" width="81" height="19"/></a></td>

            </tr>
          </table>
          <!-- end navigation -->
        </td>
      </tr>
      <tr> 
        <td background="../images/homepage/sidebar_gold.jpg" valign="top" align="left" width="131"><img src="../images/homepage/sidebar_gold.jpg" border="0" width="131" height="13"/></td>
        <td background="../images/homepage/goldbar.gif" bgcolor="#BFA31B" width="99%"><br/>
          <!-- decrease this image to decrease overall page size -->
        </td>
      </tr>
    </table>
    <!-- bottom table (content and footer) -->
         <table border="0" width="100%" cellspacing="0" cellpadding="0">
           <tr>
                                  <td width="2%"><br/></td>
             <td width="98%" valign="top"> 
               <table width="100%" cellspacing="0">
                 <tr>
                  <td valign="top"><!-- BEGIN LAYOUT --><xsl:call-template name="perform-layout"/><!-- END LAYOUT --></td>
                 </tr>
                 <tr>
                   <td align="center"><!-- FOOTER -->
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
         Copyright © 1999-2004 Calvary Chapel of Austin<br/>
                                                          For Website problems or comments, send mail to
         <a href="mailto:webservant@calvaryaustin.org"><img border="0" src="../images/email.gif"></img>webservant@calvaryaustin.org</a><br/>
         Version: <xsl:value-of select="$VERSION"/>, Latest update: <xsl:value-of select="$TODAY"/><br/>
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
