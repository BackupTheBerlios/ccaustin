#!/bin/sh

#
# Checks to see if any files were FTPed from an external source,
# checks-in the file to CVS, then emails the summary to interested parties.
#
echo Starting ftpmonitor at `date`
export CVSROOT=javajames27@cvs.ccaustin.berlios.de:/cvsroot/ccaustin
export CVS_RSH=ssh
export FTP_ROOT=/home/groups/ftp/pub/ccaustin
export PROJECT_ROOT=/home/users/javajames27
export DAILY_DIR=$PROJECT_ROOT/.daily
export DEPLOY_DIR=/home/groups/ccaustin/htdocs/daily

export CALVARY_HOME=$DAILY_DIR/ccaustin
export ANT_HOME=$PROJECT_ROOT/jakarta-ant-1.4.1
export JAVA_HOME=$PROJECT_ROOT/jdk1.3.1_02
PATH=$CALVARY_HOME/bin:$ANT_HOME/bin:$JAVA_HOME/bin:$PATH

export ANT_OPTS="-Ddeploy.dir=$DEPLOY_DIR"

export EMAIL=jhigginbotham@betweenmarkets.com

echo CVSROOT=$CVSROOT
echo JAVA_HOME=$JAVA_HOME
echo EMAIL=$EMAIL

# Check to see if the dir exists first
if [ ! -d $FTP_ROOT ]; then
	echo First Time: Checking out module...
	cd $FTP_ROOT
	cvs co ccaustin
	cd ccaustin
else
	echo Checking FTP_ROOT
	cd $FTP_ROOT/ccaustin
	cvs -q update -Pd > ~/.ftpmonitor.cvs.out 2>&1
	cvs -q commit -m "FTP Monitor checkin" >> ~/.ftpmonitor.cvs.out 2>&1
	#cat ~/.ftpmonitor.cvs.out
	# Check to see if anything interesting happened and email if so
	COUNT=`cat ~/.ftpmonitor.cvs.out | wc -l`
	echo COUNT=$COUNT
	if [ $COUNT -gt 0 ]; then 
		mail -s "FTP Monitor Result" $EMAIL < ~/.ftpmonitor.cvs.out
	fi
fi

echo Ending ftpmonitor at `date`
