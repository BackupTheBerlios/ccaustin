var hfnWindowUp = 0;

var hfnDay = new Array(
	'Friday', '', 'Friday', '', 'Friday', 'Friday', 'Sunday', '', 'Friday' );

var hfnTime = new Array(
	'7:30 PM', '', '7:00 PM', '', '7:30 PM', '7:30 PM', '6:30 PM', '', '7:30 PM' );

var hfnContact = new Array(
	'Gabe & Minerva Velasco',
	'',
	'Clyde & Marcia Combs',
	'',
	'Bones & Laurie Uk',
	'Mark & Cathy Achee',
	'Richard & Michelle Dowell',
	'',
	'Phil & Ruby Scholling' );
var hfnLocation = new Array(
	'Round Rock',
	'',
	'Southwest Austin/Slaughter Lane',
	'',
	'Wells Branch/North Austin',
	'Leander',
	'Bastrop',
	'',
	'Round Rock' );
var hfnLeader = new Array(
	'<A HREF="mailto:Jack.Murray@EmersonProcess.com">Jack Murray</A>',
	'',
	'<A HREF="mailto:clydeacombs@juno.com">Clyde Combs</A>',
	'',
	'<A HREF="mailto:bonarauk@yahoo.com">Bones Uk</A>',
	'<A HREF="mailto:texachee@cox-internet.com">Mark Achee</A>',
	'<A HREF="mailto:richarddowell@msn.com">Richard Dowell</A>',
	'',
	'<A HREF="mailto:superhawk@austin.rr.com">Steve Simpson</A>'
	);
var hfnPhone = new Array(
	'733-0897', '', '288-1280', '', '252-3087', '259-7826', '581-0436', '', '246-8266' );
var hfnComment = new Array(
	'', '', '', '', '', '', '', '', ''
	);

function hfnCell( label, info )
{
  hfnWindow.document.writeln( '<TR>' );
  hfnWindow.document.write( '<TD ALIGN=right VALIGN=middle><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA" SIZE=-1 COLOR=#7d7dad>' );
  hfnWindow.document.write( label );
  hfnWindow.document.writeln( '</FONT></TD><TD BGCOLOR=#b5b5ce><FONT SIZE=1>&nbsp;</FONT></TD>' );
  hfnWindow.document.write( '<TD ALIGN=left VALIGN=middle><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA"><B>' );
  hfnWindow.document.write( info );
  hfnWindow.document.writeln( '</B></FONT></TD>' );
  hfnWindow.document.writeln( '</TR>' );
}

function hfnWin( num )
{
  if ( 0 == hfnWindowUp )
  {
    hfnWindow = window.open( '', 'hfnImage',
	'width=400,height=300,menubar=no,toolbar=no,status=no,directories=no,scrollbars=yes' );
    windowUp = 1;
  }
  else if ( hfnWindow.closed )
  {
    hfnWindow = window.open( '', 'hfnImage',
	'width=400,height=300,menubar=no,toolbar=no,status=no,directories=no,scrollbars=yes' );
  }
  else
    hfnWindow.document.open();

  hfnWindow.document.writeln( '<HTML>' );
  hfnWindow.document.writeln( '<TITLE>Calvary Chapel of Austin Home Fellowship</TITLE>' );
  hfnWindow.document.write( '<BODY TEXT=#00008B LINK=#206020 VLINK=#640032 BGCOLOR="white"' );
  hfnWindow.document.writeln( 'BACKGROUND=\"images/bgburst1.gif\" MARGINWIDTH=0 MARGINHEIGHT=0>' );

  hfnWindow.document.writeln( '<TABLE CELLPADDING=0 CELLSPACING=3 WIDTH=100% BORDER=0>' );

  hfnWindow.document.write( "<TR><TD ALIGN=left VALIGN=middle COLSPAN=3>" );
  hfnWindow.document.write( '<A HREF=\"javascript:close()\"' );
  hfnWindow.document.write( 'TARGET=\"hfnImage\"><IMG SRC="images/closewin.gif" ALT="Close this window" BORDER=0></A>' );
  hfnWindow.document.write( '<A HREF=\"javascript:print()\">' );
  hfnWindow.document.write( '<IMG SRC="images/printwin.gif" ALT="Print this window" BORDER=0></A>' );
  hfnWindow.document.writeln( '</TD></TR>' );

  hfnWindow.document.write( "<TR><TD ALIGN=center COLSPAN=3>" );
  hfnWindow.document.write( '<FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA" SIZE=+1>Home Fellowship #' );
  hfnWindow.document.write( num.toString(10) + '</FONT>' );
  hfnWindow.document.writeln( '</TD></TR>' );
  hfnWindow.document.writeln( '<TR><TD COLSPAN=3 ALIGN=center><IMG SRC="images/underbar.gif" BORDER=0></TD></TR>' );

  num -= 1;

  hfnCell( 'Location', hfnLocation[num] );
  hfnCell( 'Time', hfnDay[num] + ', ' + hfnTime[num] );
  hfnCell( 'Hosted by', hfnContact[num] + ' -- ' + hfnPhone[num] );
  hfnCell( 'Group leader', hfnLeader[num] );

  if ( hfnComment[num].length > 0 )
  {
    hfnCell( 'Info', hfnComment[num] );
  }

  hfnWindow.document.writeln( '</TABLE>' );
  hfnWindow.document.write( "</BODY></HTML>" );

  hfnWindow.document.close();
}
