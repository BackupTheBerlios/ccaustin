#!/bin/bash

# check that JAVA_HOME is set
if [ -z "$JAVA_HOME" ] 
then
    echo JAVA_HOME must be set
    exit 1
fi
echo JAVA_HOME is $JAVA_HOME

# get JBOSS_HOME from env or arg 0
jboss=$JBOSS_HOME
if [ -z "$jboss" ]
then
    jboss=${1:?"Must supply JBOSS_HOME by setting it or providing it on the command line"}
fi

echo JBOSS_HOME is $jboss

# invoke shutdown script
# NOTE: we do this right now since we have to update jars to the lib dir which isn't hot deployable
echo Shutting down JBoss
$jboss/bin/shutdown.sh

# unzip jboss tar.gz
tar -zxvC $jboss -f jboss-server-default.tar.gz

# copy ears/wars to jboss deploy
cp *.war $jboss/server/default/deploy
cp *.ear $jboss/server/default/deploy

# invoke startup script
echo Installation complete! Restarting JBoss
cd $jboss/bin
./run.sh &

# done
