#! /bin/sh

# $Id: test.sh,v 1.1 2003/02/12 22:14:35 javajames27 Exp $

if [ -z "$JAVA_HOME" ] ; then
  JAVA=`which java`
  if [ -z "$JAVA" ] ; then
    echo "Cannot find JAVA. Please set your PATH."
    exit 1
  fi
  JAVA_BIN=`dirname $JAVA`
  JAVA_HOME=$JAVA_BIN/..
fi

JAVA=$JAVA_HOME/bin/java

TEMPCLASSPATH=../classes:../lib/slide-kernel.jar:../lib/slide-stores.jar:./junit.jar:./webdavlib.jar:$CLASSPATH

if [ -z $1 ] ; then
  echo "Usage: example <pkg>";
  exit;
fi
$JAVA -cp $TEMPCLASSPATH junit.swingui.TestRunner $1
