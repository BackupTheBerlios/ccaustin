function onLoad()
{
  window.onResize = onLoad;
  buildMenus();
}

function	buildMenus()
{
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
