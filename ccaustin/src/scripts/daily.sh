#!/bin/sh

#
# Performs a checkout/update of the latest code from the ccaustin module,
# executes the build, and copies the results to /daily under the html root
#
echo Starting daily build at `date`
export CVSROOT=javajames27@cvs.ccaustin.berlios.de:/cvsroot/ccaustin
export CVS_RSH=ssh
export PROJECT_ROOT=/home/users/javajames27
export DAILY_DIR=$PROJECT_ROOT/.daily
export DEPLOY_DIR=/home/groups/ccaustin/htdocs/daily

export CALVARY_HOME=$DAILY_DIR/ccaustin
export ANT_HOME=$PROJECT_ROOT/jakarta-ant-1.4.1
export JAVA_HOME=$PROJECT_ROOT/jdk1.3.1_02
PATH=$CALVARY_HOME/bin:$ANT_HOME/bin:$JAVA_HOME/bin:$PATH

export ANT_OPTS="-Ddeploy.dir=$DEPLOY_DIR"

echo CVSROOT=$CVSROOT
echo JAVA_HOME=$JAVA_HOME

# Check to see if the dir exists
# If not, perform a checkout
# Otherwise, do an update

if [ ! -d $DAILY_DIR ]; then
	echo First Time: Checking out daily...
	mkdir $DAILY_DIR
	cd $DAILY_DIR
	cvs co ccaustin
	cd ccaustin
else
	echo Updating daily...
	cd $DAILY_DIR/ccaustin
	cvs update -Pd
fi

# Do the work
ant web deploy

echo Ending daily build at `date`
