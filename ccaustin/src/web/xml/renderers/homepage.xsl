<?xml version="1.0"?>
    
<!--
     
     Homepage custom renderer

     $Id: homepage.xsl,v 1.9 2003/05/27 20:41:20 javajames27 Exp $
     
-->       

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

  <!-- Include the HTML Renderer, since we are really just extending it  -->
  <xsl:include href="html.xsl"/>

<xsl:template match="home">
  <!-- Content layout table -->
      <table width="100%" cellpadding="0" cellspacing="0"  border="0">
          <tr>
            <td>
              <!-- xsl:apply-templates select="featured-item"/ -->
              <xsl:apply-templates select="document('../../src/web/xml/blogs/allen.xml')/content/blog/entry[last()]"/>
            </td>
          </tr>
          <xsl:if test="banner">
			<tr>
				<td width="100%" align="left" valign="top"><br/></td>
			</tr>
	          <tr>
	            <td align="center">
	              <xsl:apply-templates select="banner/event"/>
	            </td>
	          </tr>
          </xsl:if>
		<tr>
			<td width="100%" align="left" valign="top"><br/></td>
		</tr>
          <tr>
            <td valign="top">
              <!-- Outer table for news and events -->
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="2%"><br/></td>
                    <td width="46%" valign="top" height="250">
                    <!-- News Table -->
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" height="250">
                      <tr class="tablecellnews"> 
                      <td width="8" height="14" valign="top" align="left" class="tableheadernews"><img src="../images/homepage/im_tablefttop.gif" width="8" height="17" border="0"/></td>
                      <td width="99%" height="14" align="center" class="tableheadernews">Communique</td>
                      <td width="8" height="14" valign="top" align="right" class="tableheadernews"><img src="../images/homepage/im_tablerighttop.gif" width="8" height="17" border="0"/></td>
                    </tr>
                    <tr class="tablecellnews">
                      <td colspan="3" valign="top">
                        <!-- News Content Table -->
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                          <tr>
                            <td valign="top">
                              <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <xsl:apply-templates select="document('../../src/web/xml/news/whatsnew.xml')/content/news/news-item[@showOnHomepage='true']"><xsl:sort select="@date"/></xsl:apply-templates>
                                <tr>
                                  <td colspan="2" class="newstitle" align="left" valign="top"><hr height="1" size="1" color="#2544a9" noshade="true"/></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                          <!-- END: News Content Table -->
                        </table>
                      </td>
                    </tr>
                    <tr class="tablecellnews"> 
                    <td valign="bottom" align="left" width="8" height="17"><img src="../images/homepage/im_tableleftbottom.gif" width="8" height="17" border="0"/></td>
                    <td><br/></td>
                    <td valign="bottom" align="right" width="8" height="17"><img src="../images/homepage/im_tablerightbottom.gif" width="8" height="17" border="0"/></td>
                  </tr>
                  <!-- END: News Table -->
                </table>
              </td>
              <td width="4%"><br/></td>
              <td width="46%" valign="top" height="250">
                <!-- Events Table -->
                <table width="100%" border="0" cellspacing="0" cellpadding="0" height="250">
                  <tr>
                    <td>
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr class="tablecellevent"> 
                              <td width="8" height="14" valign="top" align="left" class="tableheaderevent"><img src="../images/homepage/im_tablefttop.gif" width="8" height="17" border="0"/></td>
                              <td width="99%" height="14" align="center" class="tableheaderevent">Upcoming Events</td>
                              <td width="8" height="14" valign="top" align="right" class="tableheaderevent"><img src="../images/homepage/im_tablerighttop.gif" width="8" height="17" border="0"/></td>
                            </tr>
                            <tr class="tablecellevent">
                              <td colspan="3" valign="top">
                                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                  <tr>
                                    <td>
                                      <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                        <xsl:apply-templates
                                          select="document('../../src/web/xml/calendar/calendar.xml')/content/calendar/event[@showOnHomepage='true']">
                                          <xsl:sort select="@date"/>
                                        </xsl:apply-templates>
                                        <tr>
                                          <td colspan="2" class="eventtitle" align="left" valign="top"><hr height="1" size="1" color="#2544a9" noshade="true"/></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr class="tablecellevent"> 
                            <td valign="bottom" align="left" width="8" height="17"><img src="../images/homepage/im_tableleftbottom.gif" width="8" height="17" border="0"/></td>
                            <td><br/></td>
                            <td valign="bottom" align="right" width="8" height="17"><img src="../images/homepage/im_tablerightbottom.gif" width="8" height="17" border="0"/></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                    </td>
                    <td width="2%"><br/></td>
                  </tr>
                  <!-- END: Outer table for news and events -->
         	</table>
            </td>
          </tr>
          <!-- END: Content layout table -->
        </table>
</xsl:template>

<xsl:template match="news-item">
  <!-- Debugging <p><xsl:value-of select="@expires"/> > <xsl:value-of select="$DATE"/></p> -->
  <!-- First, make sure that the event date is still current -->
  <xsl:choose>
    <xsl:when test="@expires &gt;= $DATE">
  <tr>
    <td colspan="2" class="newstitle" align="left" valign="top"><hr height="1" size="1" color="#2544a9" noshade="true"/><xsl:value-of select="title"/></td>
  </tr>
  <xsl:choose>
    <xsl:when test="date/text()">
      <tr>
        <td colspan="2" class="newssubtitle" align="left" valign="top"><xsl:value-of select="date"/></td>
      </tr>
      
    </xsl:when>
  </xsl:choose>
  <xsl:choose>
    <xsl:when test="logo">
	  <tr>
	    <td colspan="2" class="newsitem" align="left" valign="top"><p><img src="{logo/@img}" alt="{logo/@alt}" align="{logo/@align}"/><xsl:apply-templates select="detail"/></p></td>
	  </tr>
    </xsl:when>
    <xsl:otherwise>
	  <tr>
	    <td colspan="2" class="newsitem" align="left" valign="top"><p><xsl:apply-templates select="detail"/></p></td>
	  </tr>
    </xsl:otherwise>
  </xsl:choose>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="event">
  <!-- First, make sure that the event date is still current -->
  <xsl:choose>
    <xsl:when test="@date &gt;= $DATE">
      <tr>
        <td colspan="2" class="eventtitle" align="left" valign="top"><hr height="1" size="1" color="#2544a9" noshade="true"/><xsl:value-of select="title"/></td>
      </tr>
      <!-- Now, see if we have a date string -->
      <xsl:choose>
        <xsl:when test="date/text()">
          <tr>
            <td colspan="2" class="eventsubtitle" align="left" valign="top"><xsl:value-of select="date"/></td>
          </tr>
          
        </xsl:when>
      </xsl:choose>
      <!-- Now, see if we have an intro string -->
      <xsl:choose>
        <xsl:when test="intro/text()">
          <tr>
            <td colspan="2" class="eventitem" align="left" valign="top"><xsl:value-of select="intro"/>
            <xsl:text> </xsl:text><br/><span class="readmore">[<a href="../calendar/calendar.html#{@id}" class="readmore">Learn more...</a>]</span></td>
          </tr>
        </xsl:when>
        <xsl:otherwise>
	      <xsl:choose>
	         <!-- Next, see if we have a logo -->
		    <xsl:when test="logo">
			  <tr>
			    <td colspan="2" class="eventitem" align="left" valign="top"><p><img src="{logo/@img}" 		alt="{logo/@alt}" align="{logo/@align}"/><xsl:apply-templates select="detail"/></p></td>
			  </tr>
		    </xsl:when>
		    <xsl:otherwise>
	          <tr>
	            <td colspan="2" class="eventitem" align="left" valign="top"><p><xsl:apply-templates 	select="detail"/></p></td>
	          </tr>
		    </xsl:otherwise>
	      </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="featured-item">
  <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <xsl:apply-templates select="article"/>
  </table>
</xsl:template>

<xsl:template match="article">
  <xsl:variable name="doc">../../src/web/xml/articles/<xsl:value-of select="@id"/>.xml</xsl:variable>
  <xsl:for-each select="document($doc)/content/article">
    <tr class="featuredarticlebox">
      <td width="225"><img width="125" height="125" src="../images/{@image}" alt="Featured Article"/></td>
      <td width="2%"><br/></td>
      <td width="99%" valign="center"><p><span class="featureheading"><xsl:value-of select="heading"/></span></p><p class="featureintro"><span class="subheading"><xsl:value-of select="title"/></span><br/><xsl:value-of select="intro"/><xsl:text> </xsl:text><span class="readmore"><br/>[<a href="../articles/{@id}.html" class="readmore">Read More...</a>]</span></p></td>
    </tr>
	</xsl:for-each>
    <tr>
      <td colspan="3"><br/></td>
    </tr>
</xsl:template>

<xsl:template match="entry">
	<table border="0" cellspacing="0" cellpadding="0" width="100%">
	    <tr class="featuredarticlebox">
		      <td width="225"><img width="125" height="125" src="../images/homepage/pastors_pen.jpg" alt="Featured Article"/></td>
		      <td width="2%"><br/></td>
		      <td width="99%" valign="center"><p><span class="featureheading">Pastor Allen's Blog</span><br/><xsl:value-of select="@date"/></p><xsl:if test="count(p) &gt; 3"><xsl:apply-templates select="p[1]"/><span class="readmore">[<a href="../blogs/allen.html" class="readmore">Read the complete weblog...</a>]	</span></xsl:if><xsl:if test="count(p) &lt; 4"><xsl:apply-templates/><span class="readmore">[<a href="../blogs/allen.html" class="readmore">Read Past Weblogs...</a>]	</span></xsl:if></td>
	    </tr>
	</table>
</xsl:template>

<xsl:template match="banner/event">
	<a href="{@href}"><img src="{@img}" alt="{text()} - click to learn more" border="0"/></a><br/>
	<a href="{@href}" class="readmore">Learn more about the <xsl:value-of select="text()"/></a>
</xsl:template>

</xsl:stylesheet>
