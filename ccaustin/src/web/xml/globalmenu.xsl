<?xml version="1.0"?>
    
<!-- 

	Dynamic Javascript Menus

	$Id: globalmenu.xsl,v 1.1 2002/01/31 03:25:33 javajames27 Exp $	
-->	

<xsl:stylesheet version="1.0" xmlns:xsl
="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:template match="menus">
<![CDATA[
function onLoad()
{
  window.onResize = onLoad;
  buildMenus();
}

function buildMenus()
{
]]>
<xsl:comment>Begin: Generated Menus</xsl:comment>
<xsl:apply-templates select="menu"/>
<xsl:comment>End: Generated Menus</xsl:comment>
<![CDATA[

}

function titleOn( name )
{
  if ( document.images
      && ((browser=="Netscape" && versionnum>=3.0)
	|| (browser=="Microsoft Internet Explorer" && versionnum >= 3.0)) )
  {
    document[name].src = eval( name + "on.src" );
  }
}

function titleOff( name )
{
  if ( document.images
      && ((browser=="Netscape" && versionnum>=3.0)
	|| (browser=="Microsoft Internet Explorer" && versionnum >= 3.0)) )
  {
    document[name].src = eval( name + ".src" );
  }
}

function flipImage( image, graphic)
{
  if ( (browser=="Netscape" && versionnum>=3.0)
      || (browser=="Microsoft Internet Explorer" && versionnum >= 3.0))
  {
    document.images[image].src = graphic;
  }
}


var browser=navigator.appName;
var version=navigator.appVersion;
var versionnum=parseInt(version.substring(0,2));

if ( document.images )
{
  CAlogo = new Image;
  CAlogo.src = "images/CAlogo.jpg";
  CAlogoon = new Image;
  CAlogoon.src = "images/CAlogoon.jpg";

  mitem1 = new Image;
  mitem1.src = "images/mitem1.jpg";
  mitem1on = new Image;
  mitem1on.src = "images/mitem1on.jpg";

  mitem2 = new Image;
  mitem2.src = "images/mitem2.jpg";
  mitem2on = new Image;
  mitem2on.src = "images/mitem2on.jpg";

  mitem3 = new Image;
  mitem3.src = "images/mitem3.jpg";
  mitem3on = new Image;
  mitem3on.src = "images/mitem3on.jpg";

  mitem4 = new Image;
  mitem4.src = "images/mitem4.jpg";
  mitem4on = new Image;
  mitem4on.src = "images/mitem4on.jpg";

  mitem5 = new Image;
  mitem5.src = "images/mitem5.jpg";
  mitem5on = new Image;
  mitem5on.src = "images/mitem5on.jpg";
}	
]]>
</xsl:template>

<xsl:template match="menu">
	<xsl:variable name="menuId"><xsl:value-of select="@id"/></xsl:variable>
	<xsl:variable name="menuName"><xsl:value-of select="@name"/></xsl:variable>
	<xsl:variable name="menuPage"><xsl:value-of select="@page"/></xsl:variable>

	<!-- xsl:comment>Start: Menu ID: <xsl:value-of select="@id"/></xsl:comment -->
	<xsl:apply-templates select="menu"/>

	<xsl:for-each select="menuitem">
	<xsl:variable name="menuItemName"><xsl:value-of select="@name"/></xsl:variable>
	<xsl:variable name="menuItemPage"><xsl:value-of select="@page"/></xsl:variable>
	 window.<xsl:value-of select="$menuId"/> = new Menu();
		
	 <xsl:value-of select="$menuId"/>.addMenuItem( "<xsl:value-of select="$menuItemName"/>", "location='<xsl:value-of select="$menuItemPage"/>'"      );
	 <xsl:value-of select="$menuId"/>.disableDrag = true;
	</xsl:for-each>
	 <xsl:value-of select="$menuId"/>.fontFamily = "verdana,arial,helvetica,sans-serif";
	 <xsl:value-of select="$menuId"/>.fontColor = "#2d476f";
	 <xsl:value-of select="$menuId"/>.fontColorHilite = "white";
	 <xsl:value-of select="$menuId"/>.menuHiliteBgColor = "#436da9";
	 <xsl:value-of select="$menuId"/>.menuItemBgColor = "white";
	 <xsl:value-of select="$menuId"/>.bgColor = "white";
	 <xsl:value-of select="$menuId"/>.writeMenus();
	 <xsl:value-of select="$menuId"/>.prototypeStyles = <xsl:value-of select="$menuId"/>;
</xsl:template>

</xsl:stylesheet>


<!--
  window.menuEvent = new Menu();

  menuEvent.addMenuItem( "Calendar",     "location='calendar.html'"      );
  menuEvent.disableDrag = true;


  window.menuContinuum = new Menu( "Calvary Continuum" );

  menuContinuum.addMenuItem( "Tape Catalog",      "location='live.html'"      );
  menuContinuum.addMenuItem( "Radio &amp; Television", "location='continuum.html'" );


  window.menuMedia = new Menu();

  menuMedia.addMenuItem( "Live Webcast",      "location='live.html'"      );
  menuMedia.addMenuItem( "Audio Archives",      "location='live.html'"      );
  menuMedia.addMenuItem( menuContinuum );
  menuMedia.addMenuItem( "Links",             "location='links.html'"     );
  menuMedia.disableDrag = true;

  window.menuMinistry = new Menu();

  menuMinistry.addMenuItem( "Children",  "location='children.html'" );
  menuMinistry.addMenuItem( "Focus",     "location='focus.html'"    );
  menuMinistry.addMenuItem( "FrontLine", "location='front.html'"    );
  menuMinistry.addMenuItem( "Home",      "location='home.html'"     );
  menuMinistry.addMenuItem( "Men",       "location='men.html'"      );
  menuMinistry.addMenuItem( "Women",     "location='women.html'"    );
  menuMinistry.addMenuItem( "Worship",   "location='worship.html'"  );
  menuMinistry.addMenuItem( "Youth",     "location='youth.html'"    );
  menuMinistry.disableDrag = true;

  window.menuStaff = new Menu( "Meet the Staff" );

  menuStaff.addMenuItem( "Pastor Allen",  "location='allen.html'"  );
  menuStaff.addMenuItem( "Glendon",       "location='glendon.html'"  );
  menuStaff.addMenuItem( "Donna",         "location='donna.html'"  );
  menuStaff.addMenuItem( "David",         "location='david.html'"  );
  menuStaff.addMenuItem( "Bunjee",        "location='bunjee.html'"  );
  menuStaff.addMenuItem( "Darren",        "location='darren.html'"  );
  menuStaff.addMenuItem( "John",          "location='john.html'"  );

  window.menuAbout = new Menu();

  menuAbout.addMenuItem( "Schedule",              "location='schedule.html'"    );
  menuAbout.addMenuItem( "Location",              "location='location.html'"    );
  menuAbout.addMenuItem( menuStaff );
  menuAbout.addMenuItem( "Our Vision",            "location='vision.html'"    );
  menuAbout.addMenuItem( "We Believe",            "location='believe.html'"    );
  menuAbout.addMenuItem( "History",               "location='history.html'"    );
  menuAbout.disableDrag = true;
  menuAbout.fontFamily = "verdana,arial,helvetica,sans-serif";
  menuAbout.fontColor = "#2d476f";
  menuAbout.fontColorHilite = "white";
  menuAbout.menuHiliteBgColor = "#436da9";
  menuAbout.menuItemBgColor = "white";
  menuAbout.bgColor = "white";

  menuAbout.prototypeStyles = menuAbout;

  menuAbout.writeMenus();
}

function titleOn( name )
{
  if ( document.images
      && ((browser=="Netscape" && versionnum>=3.0)
	|| (browser=="Microsoft Internet Explorer" && versionnum >= 3.0)) )
  {
    document[name].src = eval( name + "on.src" );
  }
}

function titleOff( name )
{
  if ( document.images
      && ((browser=="Netscape" && versionnum>=3.0)
	|| (browser=="Microsoft Internet Explorer" && versionnum >= 3.0)) )
  {
    document[name].src = eval( name + ".src" );
  }
}

function flipImage( image, graphic)
{
  if ( (browser=="Netscape" && versionnum>=3.0)
      || (browser=="Microsoft Internet Explorer" && versionnum >= 3.0))
  {
    document.images[image].src = graphic;
  }
}


var browser=navigator.appName;
var version=navigator.appVersion;
var versionnum=parseInt(version.substring(0,2));

if ( document.images )
{
  CAlogo = new Image;
  CAlogo.src = "images/CAlogo.jpg";
  CAlogoon = new Image;
  CAlogoon.src = "images/CAlogoon.jpg";

  mitem1 = new Image;
  mitem1.src = "images/mitem1.jpg";
  mitem1on = new Image;
  mitem1on.src = "images/mitem1on.jpg";

  mitem2 = new Image;
  mitem2.src = "images/mitem2.jpg";
  mitem2on = new Image;
  mitem2on.src = "images/mitem2on.jpg";

  mitem3 = new Image;
  mitem3.src = "images/mitem3.jpg";
  mitem3on = new Image;
  mitem3on.src = "images/mitem3on.jpg";

  mitem4 = new Image;
  mitem4.src = "images/mitem4.jpg";
  mitem4on = new Image;
  mitem4on.src = "images/mitem4on.jpg";

  mitem5 = new Image;
  mitem5.src = "images/mitem5.jpg";
  mitem5on = new Image;
  mitem5on.src = "images/mitem5on.jpg";
}
-->