var mwcWindowUp = 0;

function mwcCell( label )
{
  mwcWindow.document.writeln( '<TR>' );
  mwcWindow.document.write( '<TD ALIGN="right" VALIGN="middle" WIDTH="24%"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA" COLOR="black">' );
  mwcWindow.document.write( label );
  mwcWindow.document.writeln( '</FONT></TD><TD WIDTH="8" BGCOLOR="#007482"><FONT SIZE="+1">&nbsp;</FONT></TD>' );
  mwcWindow.document.write( '<TD WIDTH="75%" BGCOLOR="#FFEFCE"><FONT SIZE="+2"><TABLE WIDTH="100%" BORDER="1" CELLPADDING="0" CELLSPACING="0"><TR><TD>&nbsp;</TD></TR></TABLE></FONT></TD>' );
  mwcWindow.document.writeln( '</TR>' );
}

function mwcCell2( label1, fsz1, label2, fsz2 )
{
  mwcWindow.document.write( '<TR>' );
  mwcWindow.document.write( '<TD ALIGN="right" VALIGN="middle"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA" ' + fsz1 + 'COLOR="black">' );
  mwcWindow.document.write( label1 );
  mwcWindow.document.write( '</FONT></TD><TD ALIGN="center" WIDTH="6%" BGCOLOR="#BFDCE0"><FONT ' + fsz2 + '>' );
  mwcWindow.document.write( label2 );
  mwcWindow.document.write( '</FONT></TD>' );
  mwcWindow.document.write( '<TD WIDTH="40%" BGCOLOR="#FFEFCE"><FONT SIZE="+1"><TABLE WIDTH="100%" BORDER="1" CELLPADDING="0" CELLSPACING="0"><TR><TD>&nbsp;</TD></TR></TABLE></FONT></TD>' );
  mwcWindow.document.writeln( '</TR>' );
}

function mwcCell2comment( label1 )
{
  mwcWindow.document.write( '<TR>' );
  mwcWindow.document.write( '<TD COLSPAN="2" ALIGN="right" VALIGN="middle"><FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA" SIZE="1" COLOR="black">' );
  mwcWindow.document.write( label1 );
  mwcWindow.document.write( '</FONT></TD>' );
  mwcWindow.document.write( '<TD></TD>' );
  mwcWindow.document.writeln( '</TR>' );
}

function mwcWin()
{
  if ( 0 == mwcWindowUp )
  {
    mwcWindow = window.open( '', 'mwcImage',
	'width=800,height=800,menubar=no,toolbar=no,status=no,directories=no,scrollbars=yes' );
    windowUp = 1;
  }
  else if ( mwcWindow.closed )
  {
    mwcWindow = window.open( '', 'mwcImage',
	'width=800,height=800,menubar=no,toolbar=no,status=no,directories=no,scrollbars=yes' );
  }
  else
    mwcWindow.document.open();

  mwcWindow.document.writeln( '<HTML>' );
  mwcWindow.document.writeln( '<TITLE>Calvary Chapel Mid-South Music &amp; Worship Conference 2003</TITLE>' );
  mwcWindow.document.write( '<BODY TEXT="#007882" LINK="#206020" VLINK="#640032" BGCOLOR="white"' );
  mwcWindow.document.writeln( 'BACKGROUND="../images/mwcmailbg.jpg" MARGINWIDTH="0" MARGINHEIGHT="0">' );

  mwcWindow.document.writeln( '<TABLE CELLPADDING="0" CELLSPACING="3" WIDTH="100%" BORDER="0">' );
  mwcWindow.document.write( '<TR>' );
  mwcWindow.document.write( '<TD ALIGN="right" VALIGN="middle">' );
  mwcWindow.document.write( '<A HREF="javascript:print()">' );
  mwcWindow.document.write( '<IMG SRC="../images/events/printwin.gif" ALT="Print this window" BORDER="0"></A>' );
  mwcWindow.document.write( '<A HREF="javascript:close()" ' );
  mwcWindow.document.write( 'TARGET="mwcImage"><IMG SRC="../images/events/closewin.gif" ALT="Close this window" BORDER="0"></A>' );
  mwcWindow.document.write( '</TD>' );
  mwcWindow.document.writeln( '</TR>' );
  mwcWindow.document.writeln( "</TABLE>" );

  mwcWindow.document.write( '<FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA">' );
  mwcWindow.document.write( '<P ALIGN="center"><TABLE><TR><TD VALIGN="middle"><IMG SRC="../images/events/mwclogosmall.jpg" BORDER="0"></TD><TD VALIGN="middle">' );
  mwcWindow.document.write( '<FONT FACE="TAHOMA,VERDANA,ARIAL,HELVETICA" SIZE="+1">' );
  mwcWindow.document.write( 'Calvary Chapel Mid-South<BR>Music &amp; Worship Conference<BR>2003 Registration' );
  mwcWindow.document.write( '</FONT></TD></TR></TABLE>' );
  mwcWindow.document.write( '<P ALIGN="center"><FONT SIZE="-2"><I>Please Print Neatly</I></FONT></P>' );

  mwcWindow.document.writeln( '<TABLE CELLPADDING="0" CELLSPACING="4" WIDTH="100%" BORDER="0">' );

  mwcCell( 'Name' );
  mwcCell( 'Address' );
  mwcCell( 'City' );
  mwcCell( 'State' );
  mwcCell( 'Zip' );
  mwcCell( 'Phone' );
  mwcCell( 'Church Name' );
  mwcCell( 'email' );
  mwcWindow.document.writeln( '</TABLE>' );

  mwcWindow.document.writeln( '<P><TABLE WIDTH="100%" CELLPADDING="2" CELLSPACING="4" BORDER="0">' );
  mwcCell2( 'Registration:', 'SIZE="-1"', '$', 'SIZE="+1"' );
  mwcCell2comment( '$45 until February 9, 2003; $55 thereafter' );
  mwcCell2( 'T-Shirt Size (Adult M/L/XL/XXL)', 'SIZE="-1"', '', 'SIZE="+1"' );
  mwcCell2comment( 'Conference fee includes 1 T-shirt' );
  mwcCell2( 'Additional T-Shirts, $10 ea', 'SIZE="-1"', '$', 'SIZE="+1"' );

  mwcWindow.document.write( '<TR><TD></TD><TD COLSPAN="2" ALIGN="left"><TABLE CELLPADDING="4" CELLSPACING="4" BORDER="0"' );
  mwcCell2comment( 'Please indicate quantity;<BR>all sizes are Adult' );
  mwcCell2( '', '', 'M' );
  mwcCell2( '', '', 'L' );
  mwcCell2( '', '', 'XL' );
  mwcCell2( '', '', 'XXL' );
  mwcWindow.document.write( '</TABLE></TD></TR>' );
  mwcCell2( 'Total Enclosed', 'SIZE="-1"', '$', 'SIZE="+1"' );
  mwcWindow.document.writeln( '</TABLE>' );

  mwcWindow.document.writeln( '<P><TABLE WIDTH="100%" CELLPADDING="0" CELLSPACING="0" BORDER="0"><TR><TD WIDTH="25%"></TD><TD ALIGN="left">' );
  mwcWindow.document.write( '<P>Please print this form ' );
  mwcWindow.document.write( '<A HREF="javascript:print()"><IMG SRC="../images/events/printwin.gif" ALT="Print this window" BORDER="0"></A>' );
  mwcWindow.document.write( ' and fill out completely.<BR>Complete one registration form per attendee.<BR>Return this form along with the total amount indicated above to:</P><P></P>' );
  mwcWindow.document.writeln( '<P><FONT COLOR="black"><B>Calvary Austin<BR>Attn: Worship Conference<BR>9414 Parkfield Drive<BR>Austin, Texas 78758</B></FONT></P>' );
  mwcWindow.document.write( '<P><FONT SIZE="-1">Checks may be made out to "Calvary Chapel of Austin".  Please indicate "worship conference" in the memo space.</FONT></P>' );
  mwcWindow.document.writeln( '</TD></TR></TABLE></P>' );

  mwcWindow.document.writeln( '</P></FONT>' );


  mwcWindow.document.write( "</BODY></HTML>" );

  mwcWindow.document.close();
}

var mwctshirtUp = 0;

function mwctshirtWin()
{
  if ( 0 == mwctshirtUp )
  {
    mwctshirt = window.open( '', 'mwctshirt',
	'width=640,height=600,menubar=no,toolbar=no,status=no,directories=no,scrollbars=no' );
    mwctshirtUp = 1;
  }
  else if ( mwctshirt.closed )
  {
    mwctshirt = window.open( '', 'mwctshirt',
	'width=640,height=600,menubar=no,toolbar=no,status=no,directories=no,scrollbars=no' );
  }
  else
    mwctshirt.document.open();

  mwctshirt.document.writeln( '<HTML>' );
  mwctshirt.document.writeln( '<TITLE>2003 Conference T-Shirt Design</TITLE>' );
  mwctshirt.document.write( '<BODY TEXT="#3a5d8c" LINK="#206020" VLINK="#640032"' );
  mwctshirt.document.writeln( 'BGCOLOR="white" MARGINWIDTH="0" MARGINHEIGHT="0">' );

  mwctshirt.document.writeln( '<TABLE CELLPADDING="0" CELLSPACING="0" WIDTH="100%" BORDER="0">' );
  mwctshirt.document.write( '<TR>' );
  mwctshirt.document.write( '<TD ALIGN="right" VALIGN="top">' );
  mwctshirt.document.write( '<A HREF="javascript:close()" ' );
  mwctshirt.document.write( 'TARGET="mwctshirt"><IMG SRC="../images/events/closewin.gif" ALT="Close this window" BORDER="0"></A>' );
  mwctshirt.document.write( '</TD></TR>' );

  mwctshirt.document.write( '<TR>' );
  mwctshirt.document.write( '<TD VALIGN="MIDDLE" ALIGN="CENTER">' );
  mwctshirt.document.write( '<IMG SRC="../images/events/mwctshirtlg.jpg" ALT="Larger image of conference T-shirt" BORDER="0"></A>' );
  mwctshirt.document.write( '</TD></TR>' );
  mwctshirt.document.write( '</TABLE>' );

  mwctshirt.document.write( "</BODY></HTML>" );

  mwctshirt.document.close();
}
