#!/bin/sh
# ---------------------------------------------------------------------------
# run.sh - Start Script for the Slide Client
#
# $Id: run.sh,v 1.2 2003/05/17 00:24:36 javajames27 Exp $
# ---------------------------------------------------------------------------

if [ -z "${SLIDE_HOME}" ] ; then 
    SLIDE_HOME=.
    if [ ! -f ${SLIDE_HOME}/client/lib/slide-client.jar ] ; then
        if [ ! -f ${SLIDE_HOME}/dist/client/lib/slide-client.jar ] ; then
            if [ ! -d ${SLIDE_HOME}/build/client/classes ] ; then
                SLIDE_HOME=..
            fi
        fi
    fi
    if [ ! -f ${SLIDE_HOME}/client/lib/slide-client.jar ] ; then
        if [ ! -f ${SLIDE_HOME}/dist/client/lib/slide-client.jar ] ; then
            if [ ! -d ${SLIDE_HOME}/build/client/classes ] ; then
                SLIDE_HOME=../..
            fi
        fi
    fi
    if [ ! -f ${SLIDE_HOME}/client/lib/slide-client.jar ] ; then
        if [ ! -f ${SLIDE_HOME}/dist/client/lib/slide-client.jar ] ; then
            if [ ! -d ${SLIDE_HOME}/build/client/classes ] ; then
                SLIDE_HOME=../../..
            fi
        fi
    fi
    if [ ! -f ${SLIDE_HOME}/client/lib/slide-client.jar ] ; then
        if [ ! -f ${SLIDE_HOME}/dist/client/lib/slide-client.jar ] ; then
            if [ ! -d ${SLIDE_HOME}/build/client/classes ] ; then
                SLIDE_HOME=../../../..
            fi
        fi
    fi
fi

if [ ! -f ${SLIDE_HOME}/client/lib/slide-client.jar ] ; then
    if [ ! -f ${SLIDE_HOME}/dist/client/lib/slide-client.jar ] ; then
        if [ ! -d ${SLIDE_HOME}/build/client/classes ] ; then
            echo Unable to determine the value of SLIDE_HOME
            exit 1
        fi
    fi
fi

# consider classpath for the both source and binary distribution
CP=${CLASSPATH}
CP=${CP}:./classes:../classes

if [ -d ${SLIDE_HOME}/classes ] ; then
    CP=${CP}:${SLIDE_HOME}/classes
    CP=${CP}:${SLIDE_HOME}/client/classes
elif [ -d ${SLIDE_HOME}/dist/classes ] ; then
    CP=${CP}:${SLIDE_HOME}/dist/classes
    CP=${CP}:${SLIDE_HOME}/dist/client/classes
elif [ -d ${SLIDE_HOME}/build/classes ] ; then
    CP=${CP}:${SLIDE_HOME}/build/classes
    CP=${CP}:${SLIDE_HOME}/build/client/classes
fi

if [ -f ${SLIDE_HOME}/client/lib/slide-client.jar ] ; then
    CP=${CP}:${SLIDE_HOME}/client/lib/slide-client.jar
    CP=${CP}:${SLIDE_HOME}/client/lib/slide-webdavlib.jar
    CP=${CP}:${SLIDE_HOME}/client/lib/commons-httpclient.jar
    CP=${CP}:${SLIDE_HOME}/client/lib/antlr.jar
    CP=${CP}:${SLIDE_HOME}/client/lib/jaxp.jar
    CP=${CP}:${SLIDE_HOME}/client/lib/crimson.jar
elif [ -f ${SLIDE_HOME}/dist/client/lib/slide-client.jar ] ; then
    CP=${CP}:${SLIDE_HOME}/dist/client/lib/slide-client.jar
    CP=${CP}:${SLIDE_HOME}/dist/client/lib/slide-webdavlib.jar
    CP=${CP}:${SLIDE_HOME}/dist/client/lib/commons-httpclient.jar
    CP=${CP}:${SLIDE_HOME}/dist/client/lib/antlr.jar
    CP=${CP}:${SLIDE_HOME}/dist/client/lib/jaxp.jar
    CP=${CP}:${SLIDE_HOME}/dist/client/lib/crimson.jar
elif [ -f ${SLIDE_HOME}/build/lib/slide-client.jar ] ; then
    CP=${CP}:${SLIDE_HOME}/build/lib/slide-client.jar
    CP=${CP}:${SLIDE_HOME}/build/lib/slide-webdavlib.jar
    CP=${CP}:${SLIDE_HOME}/build/lib/slide-client.jar
    CP=${CP}:${SLIDE_HOME}/build/lib/antlr.jar
    CP=${CP}:${SLIDE_HOME}/build/lib/jaxp.jar
    CP=${CP}:${SLIDE_HOME}/build/lib/crimson.jar
elif [ -f ${SLIDE_HOME}/lib/slide-client.jar ] ; then
    CP=${CP}:${SLIDE_HOME}/lib/slide-client.jar
    CP=${CP}:${SLIDE_HOME}/lib/slide-webdavlib.jar
    CP=${CP}:${SLIDE_HOME}/lib/slide-client.jar
    CP=${CP}:${SLIDE_HOME}/lib/antlr.jar
    CP=${CP}:${SLIDE_HOME}/lib/jaxp.jar
    CP=${CP}:${SLIDE_HOME}/lib/crimson.jar
fi

MAINCLASS=org.apache.webdav.cmd.Slide
java -classpath ${CP} ${MAINCLASS} $*

