var browser=navigator.appName;
var version=navigator.appVersion;
var versionnum=parseInt(version.substring(0,2));

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
