#!/bin/sh

#
# Performs a checkout/update of the latest code from the ccaustin module,
# executes the build, and copies the results to /daily under the html root
#
echo Starting publish at `date`
export CVSROOT=javajames27@cvs.ccaustin.berlios.de:/cvsroot/ccaustin
export CVS_RSH=ssh
export PROJECT_ROOT=/home/james
export WORK_DIR=$PROJECT_ROOT/.websandbox
export DEPLOY_DIR=/usr/local/webapps/apache/htdocs

export CALVARY_HOME=$WORK_DIR/ccaustin
export ANT_HOME=$WORK_DIR/ccaustin/thirdparty/ant
export JAVA_HOME=/usr/local/jdk
PATH=$CALVARY_HOME/bin:$ANT_HOME/bin:$JAVA_HOME/bin:$PATH
PATH=$CALVARY_HOME/bin:$PATH

export ANT_OPTS="-Ddeploy.dir=$DEPLOY_DIR"

echo CVSROOT=$CVSROOT
echo JAVA_HOME=$JAVA_HOME

# Check to see if the dir exists
# If not, perform a checkout
# Otherwise, do an update

if [ ! -d $WORK_DIR ]; then
        echo First Time: Creating a new sandbox...
        mkdir $WORK_DIR
        cd $WORK_DIR
        cvs co ccaustin
        cd ccaustin
else
        echo Updating sandbox...
        cd $WORK_DIR/ccaustin
        cvs update -Pd
fi

# Do the work
ant web deploy

echo Ending publish at `date`