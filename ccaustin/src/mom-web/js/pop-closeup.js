<!-- Begin POP-UP SIZES AND OPTIONS CODE


// ONLY USE lowercase FOR yes no OPTIONS

// CHANGE ANY OF THESE VARIABLES TO "no" OR "yes" TO TURN AN OPTION OFF OR ON


// SOUND POPUPS

var download_logos 	= "yes"		// "yes" FOR THE DOWNLOAD ICONS TO SHOW
var close_button_s 	= "yes"		// SOUND CLOSE BUTTON ON/OFF
var show_flash 		= "yes"		// SHOW THE FLASH OPTION
var show_realaudio 	= "yes"		// SHOW THE REALAUDIO OPTION
var show_quicktime 	= "yes"		// SHOW THE QUICKTIME OPTION
var show_windows 	= "yes"		// SHOW THE WINDOWS OPTION
var flash_text		= "Flash" 	// TEXT TO CHOOSE FLASH
var real_text		= "RealAudio" 	// TEXT TO CHOOSE REALAUDIO
var quick_text		= "Quicktime" 	// TEXT TO CHOOSE QUICKTIME
var windows_text	= "Windows Media" 	// TEXT TO CHOOSE WINDOWS
var close_location 	= "98" 		// MOVE THE SOUND CLOSE BUTTON UP OR DOWN
var view_sound_width 	=  600		// SOUND POPUP WIDTH
var view_sound_height 	=  400		// SOUND POPUP HEIGHT
var right_click_onS	= "no"		// SOUND RIGHT CLICK PROTECTION ON
var song_title		= "yes"		// SHOW SONG FILE NAME


// GALLERY POPUPS

var close_button_p 	= "yes"		// GALLERY CLOSE BUTTON ON/OFF
var slideshow_button 	= "yes"		// SLIDESHOW BUTTON ON/OFF
var right_click_onG	= "yes"		// GALLERY RIGHT CLICK PROTECTION ON
var border_color	= "000000"	// PICTURE OUTLINE COLOR
var slideshow_width 	= 700		// SLIDESHOW POPUP WINDOW WIDTH
var slideshow_height 	= 525		// SLIDESHOW POPUP WINDOW HEIGHT
var view_width 		= 700		// GALLERY POPUP WIDTH
var view_height 	= 525		// GALLERY POPUP HEIGHT


// OTHER OPTIONS YOU CAN CHANGE


var scrollbarS 		= "0"		// TURN ON POPUP SCROLLBARS "1" FOR ON "0" FOR OFF
var scrollbarS_sound	= "0"		// TURN ON POPUP SCROLLBARS "1" FOR ON "0" FOR OFF
var background_image	= "images/background-popups.jpg"			// BACKROUND IMAGE IN MUSIC POPUPS
var background_colors	= "FFFFFF"					// BACKROUND COLOR OF THE POPUPS
var background_colors_S	= "000000"	// SIDEBAR COLOR OF THE POPUPS
var right_click_text	= "You may not right mouse click this page"	// TEXT FOR THE RIGHT CLICK PROTECTION




// COPYRIGHT 2003 © Allwebco Design Corporation
// Unauthorized use or sale of this script is strictly prohibited by law

// YOU DO NOT NEED TO EDIT BELOW THIS LINE

// START SOUND POPUP CODE




function popUpSound(SONG) {
var look='toolbar=0,scrollbars='+scrollbarS_sound+',location=0,statusbar=0,menubar=0,resizable=0,width='+view_sound_width+',height='+view_sound_height+','
popwin=window.open("","",look)
popwin.document.open()
popwin.document.write('<html><head>');
popwin.document.write('<title>Player</title>');
popwin.document.write('<link rel=StyleSheet href="css/corporatestyle.css" type="text/css" media="screen">');
   if (right_click_onS == "yes") {
popwin.document.write('<META HTTP-EQUIV="imagetoolbar" CONTENT="no">')
popwin.document.write('<script language="JavaScript">')
popwin.document.write('function noRightClick() {')
popwin.document.write('if (event.button==2) {')
popwin.document.write('alert(\''+right_click_text+'\')')
popwin.document.write('}')
popwin.document.write('}')
popwin.document.write('document.onmousedown=noRightClick')
popwin.document.write('</script>')
}
popwin.document.write('</head>');
popwin.document.write('<BODY BGCOLOR="#'+background_colors+'" background="'+background_image+'" TEXT="#FFFFFF" LINK="#FFFFFF" VLINK="#FFFFFF" ALINK="#FFFFFF" leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0" marginheight="0" marginwidth="0">');
popwin.document.write('<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%"><tr><td bgcolor="#'+background_colors_S+'" width="43" align="center">');
popwin.document.write('<img src="images/popup-download.gif"><br>');
popwin.document.write('</td><td valign="middle" bgcolor="#'+background_colors_S+'" width="108">');
   if (download_logos == "yes") {


// START THE DOWNLOAD ICONS

   if (show_flash == "yes") {
popwin.document.write('<a href="http://www.macromedia.com/go/getflashplayer/" target="_blank"><img src="images/icon_flash.gif" border="0"></a><br><br>');
}
   if (show_realaudio == "yes") {
popwin.document.write('<a href="http://real.com" target="_blank"><img src="images/icon_real.gif" border="0"></a><br><br>');
}
   if (show_quicktime == "yes") {
popwin.document.write('<a href="http://www.apple.com" target="_blank"><img src="images/icon_quicktime.gif" border="0"></a><br><br>');
}
   if (show_windows == "yes") {
popwin.document.write('<a href="http://www.microsoft.com/windowsmedia" target="_blank"><img src="images/icon_windows.gif" border="0"></a><br>');
}

}
popwin.document.write('<img src="images/spacer.gif" width="108" height="1"><br>');
popwin.document.write('</td><td width="15">');
popwin.document.write('<img src="images/spacer.gif" width="15" height="20"><br>');
popwin.document.write('</td><td valign="top">');
popwin.document.write('<img src="images/popup-select.gif"><br>');
popwin.document.write('<img src="images/spacer.gif" width="10" height="105"><br>');
popwin.document.write('<table cellpadding="0" cellspacing="3" border="0" width="250"><tr><td width="40">');
   if (show_flash == "yes") {
popwin.document.write('<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" WIDTH="35" HEIGHT="20" id="popup_flash">');
popwin.document.write('<PARAM NAME=movie VALUE="popup_flash.swf?theFile='+SONG+'">');
popwin.document.write('<PARAM NAME=quality VALUE=high>');
popwin.document.write('<PARAM NAME=bgcolor VALUE=#FFFFFF>');
popwin.document.write('<EMBED src="popup_flash.swf?theFile='+SONG+'" quality=high bgcolor=#FFFFFF WIDTH="35" HEIGHT="20" NAME="popup_flash" TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer">');
popwin.document.write('</EMBED>');
popwin.document.write('</OBJECT><br>');
popwin.document.write('</td><td class="listen">');
popwin.document.write(''+flash_text+'<br>');
}
else
{
popwin.document.write('<br></td><td>');
popwin.document.write('<br>');
}
   if (show_realaudio == "yes") {
popwin.document.write('</td></tr><tr><td width="40">');
popwin.document.write('<a href="javascript:RealPlayer()"><img src="images/popup-player.gif" border="0"></a><br>');
popwin.document.write('<Script Language="JavaScript">\n');
popwin.document.write('function RealPlayer(){\n');
popwin.document.write('document.writeln(\'<html><head>\');\n');
popwin.document.write('document.writeln(\'<title>Player</title>\');\n');
popwin.document.write('document.writeln(\'<link rel=StyleSheet href="css/corporatestyle.css" type="text/css" media="screen">\');\n');
popwin.document.write('document.writeln(\'</head>\');\n');
popwin.document.write('document.writeln(\'<BODY BGCOLOR="#'+background_colors+'" background="'+background_image+'" TEXT="#FFFFFF" LINK="#FFFFFF" VLINK="#FFFFFF" ALINK="#FFFFFF" leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0" marginheight="0" marginwidth="0">\');\n');
popwin.document.write('document.writeln(\'<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%"><tr><td valign="middle" align="center">\');\n');
popwin.document.write('document.writeln(\'<object id=RVOCX classid="CLSID:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA" width="375" height="100">\');\n');
popwin.document.write('document.writeln(\'<param name="SRC" value="'+SONG+'">\');\n');
popwin.document.write('document.writeln(\'<param name="CONTROLS" value="All">\');\n');
popwin.document.write('document.writeln(\'<param name="CONSOLE" value="one">\');\n');
popwin.document.write('document.writeln(\'<PARAM NAME="AUTOSTART" VALUE="true">\');\n');
popwin.document.write('document.writeln(\'<embed src="'+SONG+'" type="audio/x-pn-realaudio-plugin" width="375" height="100" NOJAVA="true" controls="ControlPanel" console="one" AUTOSTART="false">\');\n');
popwin.document.write('document.writeln(\'</EMBED>\');\n');
popwin.document.write('document.writeln(\'</OBJECT><br>\');\n');
   if (close_button_s == "yes") {
popwin.document.write('document.writeln(\'<br><a href="javascript:self.close()"><img src="images/popup-close.gif" border="0" style="border: #FFFFFF 1px solid"></a><br>\');\n');
}
popwin.document.write('document.writeln(\'</td></tr></table>\');\n');
popwin.document.write('document.writeln(\'</BODY></HTML>\');\n');
popwin.document.write('}\n');
popwin.document.write('</script>\n');
popwin.document.write('</td><td class="listen">');
popwin.document.write(''+real_text+'<br>');
}
   if (show_quicktime == "yes") {
popwin.document.write('</td></tr><tr><td width="40">');
popwin.document.write('<OBJECT CLASSID="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" WIDTH="35" HEIGHT="20" CODEBASE="http://www.apple.com/qtactivex/qtplugin.cab">');
popwin.document.write('<PARAM name="SRC" VALUE="popup-quicktime.mov">');
popwin.document.write('<PARAM name="HREF" VALUE="'+SONG+'">');
popwin.document.write('<PARAM name="AUTOPLAY" VALUE="true">');
popwin.document.write('<PARAM name="TARGET" VALUE="QuickTimePlayer">');
popwin.document.write('<PARAM name="CONTROLLER" VALUE="FALSE">');
popwin.document.write('<EMBED SRC="popup-quicktime.mov" HREF="'+SONG+'" TARGET="QuickTimePlayer" WIDTH="35" HEIGHT="20" AUTOPLAY="true" CONTROLLER="false" PLUGINSPAGE="http://www.apple.com/quicktime/download/">');
popwin.document.write('</EMBED>');
popwin.document.write('</OBJECT><br>');
popwin.document.write('</td><td class="listen">');
popwin.document.write(''+quick_text+'<br>');
}
   if (show_windows == "yes") {
popwin.document.write('</td></tr><tr><td width="40">');
popwin.document.write('<table cellpadding="0" cellspacing="0" border="0"><tr><td>');
popwin.document.write('<INPUT TYPE="image" src="images/popup-player-win.gif" NAME="BtnPlay" VALUE="Play" OnClick="StartMeUp()"><br></td><td>');
popwin.document.write('<INPUT TYPE="image" src="images/popup-player_stop-win.gif" NAME="BtnStop" VALUE="Stop" OnClick="ShutMeDown()"></td><td>');
popwin.document.write('<div id="wm-location">');
popwin.document.write('<OBJECT ID="Player" width="152" height="'+view_sound_height+'" CLASSID="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6">');
popwin.document.write('<PARAM NAME="autoStart" VALUE="false">');
popwin.document.write('<PARAM name="URL" value="'+SONG+'">');
popwin.document.write('<PARAM name="uiMode" value="none">');
popwin.document.write('</OBJECT>');
popwin.document.write('</div>');
popwin.document.write('</td></tr></table>');
   popwin.document.write('\n');
   popwin.document.write('<script>\n');
   popwin.document.write('<!--\n');
   popwin.document.write('function StartMeUp ()\n');
   popwin.document.write('{\n');
       popwin.document.write('Player.controls.play();\n');
   popwin.document.write('}\n');
   popwin.document.write('function ShutMeDown ()\n');
   popwin.document.write('{\n');
       popwin.document.write('Player.controls.stop();\n');
   popwin.document.write('}\n');
   popwin.document.write('-->\n');
   popwin.document.write('</SCRIPT>\n');
   popwin.document.write('<SCRIPT LANGUAGE="VBScript">\n');
   popwin.document.write('<!--\n');
 popwin.document.write('On error resume next\n');
   popwin.document.write('Player.URL = ""\n');
   popwin.document.write('if err then msgbox "You need Windows Media Player 7. Go to" & chr(13) &_\n');
        popwin.document.write('"http://www.microsoft.com/windowsmedia"\n');
     popwin.document.write('err.clear\n');
   popwin.document.write('-->\n');
   popwin.document.write('</SCRIPT>\n');
popwin.document.write('</td><td class="listen" valign="top">');
popwin.document.write(''+windows_text+'<br>');
}
popwin.document.write('</td></tr></table>');
popwin.document.write('<img src="images/spacer.gif" width="15" height="'+close_location+'"><br>');
popwin.document.write('<div id="music-closebutton">');
popwin.document.write('<table cellpadding="0" cellspacing="0" border="0" width="100%"><tr><td>');
   if (song_title == "yes") {
popwin.document.write('FILE: '+SONG+'');
}
popwin.document.write('&nbsp;<br>');
popwin.document.write('</td><td width="130">');
   if (close_button_s == "yes") {
popwin.document.write('<a href="javascript:self.close()"><img src="images/popup-close.gif" border="0" onmouseover="this.style.border=\'#000000 1px solid\'" onmouseout="this.style.border=\'#'+background_colors+' 1px solid\'" style="border: #FFFFFF 1px solid" hspace="8"></a><br>');
}
popwin.document.write('</td></tr></table>');
popwin.document.write('</div>');
popwin.document.write('</td></tr></table>');
popwin.document.write('</BODY></HTML>');
popwin.document.close()
}



// START SLIDESHOW POPUP CODE


function popUpSlideshow(URL) {
day = new Date();
id = day.getTime();
eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars='+scrollbarS+',location=0,statusbar=0,menubar=0,resizable=1,width='+slideshow_width+',height='+slideshow_height+'');");
}


// START POPUP CODE


function popUp(URL) {
var look='toolbar=0,scrollbars='+scrollbarS+',location=0,statusbar=0,menubar=0,resizable=1,width='+view_width+',height='+view_height+','
popwin=window.open("","",look)
popwin.document.open()
popwin.document.write('<title>Image Close Up</title>')
   if (right_click_onG == "yes") {
popwin.document.write('<META HTTP-EQUIV="imagetoolbar" CONTENT="no">')
popwin.document.write('<script language="JavaScript">')
popwin.document.write('function noRightClick() {')
popwin.document.write('if (event.button==2) {')
popwin.document.write('alert(\''+right_click_text+'\')')
popwin.document.write('}')
popwin.document.write('}')
popwin.document.write('document.onmousedown=noRightClick')
popwin.document.write('</script>')
}
popwin.document.write('<head>')
popwin.document.write('<link rel=StyleSheet href="css/corporatestyle.css" type="text/css" media="screen"></head>')
popwin.document.write('<body bgcolor="#'+background_colors+'" background="'+background_image+'" leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0" marginheight="0" marginwidth="0">')
popwin.document.write('<TABLE cellpadding="0" cellspacing="0" border="0" width="100%" height="100%"><tr><td align="center">')
popwin.document.write('<br>')
popwin.document.write('<table cellspacing="0" cellpadding="1" border="0"><tr><td align="center">')
popwin.document.write('<TABLE cellpadding="0" cellspacing="0" border="1" bordercolor="#'+border_color+'" style="border-collapse: collapse"><tr><td>')
popwin.document.write('<img src="'+URL+'">')
popwin.document.write('</td></tr></table><br>')
popwin.document.write('</td></tr><tr><td valign="top" align="center" height="50">')
popwin.document.write('<TABLE cellpadding="0" cellspacing="0" border="0"><tr><td>')
   if (close_button_p == "yes") {
popwin.document.write('<form style="margin: 0px"><input type="button" value="Close" onmouseover="this.className=\'buttonon-popups\'" onmouseout="this.className=\'button-popups\'" class="button-popups" onClick=\'self.close()\'>&nbsp;</form>')
}
   if (slideshow_button == "yes") {
popwin.document.write('</td><td>')
popwin.document.write('<form action="slideshow.htm" style="margin: 0px"><input type="submit" value="Slideshow" onmouseover="this.className=\'buttonon-popups\'" onmouseout="this.className=\'button-popups\'" class="button-popups"></form>')
}
popwin.document.write('</td></tr></table>')
popwin.document.write('</td></tr></table>')
popwin.document.write('</td></tr></table>')
popwin.document.write('</body>')
popwin.document.close()
}



// Begin SMALL MESSAGES CODE


document.write('<div Class="divstyle" id="info" style=\'display:none;\'>')
document.write('<div id="imagetitle" class="pstyletitle" align="center"></div>')
document.write('</div>')


var IE = document.all?true:false

if (!IE) document.captureEvents(Event.MOUSEMOVE)

document.onmousemove = getMouseXY;

var tempX = 0
var tempY = 0

  
function getMouseXY(e) {
  if (IE) { // grab the x-y pos.s if browser is IE
    tempX = event.clientX + document.body.scrollLeft
    tempY = event.clientY + document.body.scrollTop
  } else {  // grab the x-y pos.s if browser is NS
    tempX = e.pageX
    tempY = e.pageY
  }  
  // catch possible negative values in NS4
  if (tempX < 0){tempX = 0}
  if (tempY < 0){tempY = 0}  
  // show the position values in the form named Show
  // in the text fields named MouseX and MouseY
obj_info = document.getElementById("info")
obj_info.style.top = tempY + 10;
obj_info.style.left = tempX + 10;
  return true
}

function alert_msg(titletext){
obj_info = document.getElementById("info")
obj_info.style.display = '';
obj_imagetitle = document.getElementById("imagetitle");
obj_imagetitle.innerHTML = titletext;

}

function away()
{
obj_info = document.getElementById("info")
obj_info.style.display = 'none';
}


function goToURL() { history.go(-1); }


// End -->

