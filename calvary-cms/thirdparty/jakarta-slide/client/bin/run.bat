@echo off
rem ---------------------------------------------------------------------------
rem run.bat - Start Script for the Slide Client
rem
rem $Id: run.bat,v 1.2 2003/05/17 00:24:36 javajames27 Exp $
rem ---------------------------------------------------------------------------

set _SLIDE_HOME=%SLIDE_HOME%
set CP=%CLASSPATH%
set CP=%CP%;.\classes\;..\classes

if "%SLIDE_HOME%" == "" goto getHome
else goto gotHome

:getHome
set SLIDE_HOME=.
if exist "%SLIDE_HOME%\client\lib\slide-client.jar" goto binaryDist
set SLIDE_HOME=..
if exist "%SLIDE_HOME%\client\lib\slide-client.jar" goto binaryDist
set SLIDE_HOME=..\..
if exist "%SLIDE_HOME%\client\lib\slide-client.jar" goto binaryDist
set SLIDE_HOME=..\..\..
if exist "%SLIDE_HOME%\client\lib\slide-client.jar" goto binaryDist
set SLIDE_HOME=..\..\..\..
if exist "%SLIDE_HOME%\client\lib\slide-client.jar" goto binaryDist
set SLIDE_HOME=.
if exist "%SLIDE_HOME%\dist\client\lib\slide-client.jar" goto sourceDist
set SLIDE_HOME=..
if exist "%SLIDE_HOME%\dist\client\lib\slide-client.jar" goto sourceDist
set SLIDE_HOME=..\..
if exist "%SLIDE_HOME%\dist\client\lib\slide-client.jar" goto sourceDist
set SLIDE_HOME=..\..\..
if exist "%SLIDE_HOME%\dist\client\lib\slide-client.jar" goto sourceDist
set SLIDE_HOME=..\..\..\..
if exist "%SLIDE_HOME%\dist\client\lib\slide-client.jar" goto sourceDist
set SLIDE_HOME=.
if exist "%SLIDE_HOME%\build\client\lib\slide-client.jar" goto sourceBuild
set SLIDE_HOME=..
if exist "%SLIDE_HOME%\build\client\lib\slide-client.jar" goto sourceBuild
set SLIDE_HOME=..\..
if exist "%SLIDE_HOME%\build\cleint\lib\slide-client.jar" goto sourceBuild
set SLIDE_HOME=..\..\..
if exist "%SLIDE_HOME%\build\cleint\lib\slide-client.jar" goto sourceBuild
set SLIDE_HOME=..\..\..\..
if exist "%SLIDE_HOME%\build\cleint\lib\slide-client.jar" goto sourceBuild
:unableTo
echo Unable to determine the value of SLIDE_HOME
goto cleanup

:gotHome
if not exist "%SLIDE_HOME%\client\lib\slide-client.jar" goto getHome

:binaryDist
rem It's for the Slide binary distribution
set CP=%CP%;%SLIDE_HOME%\client\lib\slide-client.jar
set CP=%CP%;%SLIDE_HOME%\client\lib\slide-webdavlib.jar
set CP=%CP%;%SLIDE_HOME%\client\lib\commons-httpclient.jar
set CP=%CP%;%SLIDE_HOME%\client\lib\antlr.jar
set CP=%CP%;%SLIDE_HOME%\client\lib\jaxp.jar
set CP=%CP%;%SLIDE_HOME%\client\lib\crimson.jar
goto execution

:sourceDist
rem It's for distribution from the Slide sources
set CP=%CP%;%SLIDE_HOME%\dist\client\lib\slide-client.jar
set CP=%CP%;%SLIDE_HOME%\dist\client\lib\slide-webdavlib.jar
set CP=%CP%;%SLIDE_HOME%\dist\client\lib\commons-httpclient.jar
set CP=%CP%;%SLIDE_HOME%\dist\client\lib\antlr.jar
set CP=%CP%;%SLIDE_HOME%\dist\client\lib\jaxp.jar
set CP=%CP%;%SLIDE_HOME%\dist\client\lib\crimson.jar
goto execution

:sourceBuild
rem It's for build from the Slide sources
set CP=%CP%;%SLIDE_HOME%\build\client\lib\slide-client.jar
set CP=%CP%;%SLIDE_HOME%\build\client\lib\slide-webdavlib.jar
set CP=%CP%;%SLIDE_HOME%\build\client\lib\commons-httpclient.jar
set CP=%CP%;%SLIDE_HOME%\build\client\lib\antlr.jar
set CP=%CP%;%SLIDE_HOME%\build\client\lib\jaxp.jar
set CP=%CP%;%SLIDE_HOME%\build\client\lib\crimson.jar
goto execution

:execution
set MAINCLASS=org.apache.webdav.cmd.Slide
java -classpath %CP% %MAINCLASS% %1 %2 %3 %4 %5 %6 %7 %8 %9

:cleanup
set SLIDE_HOME=%_SLIDE_HOME%
set _SLIDE_HOME=
set MAINCLASS=
set CP=

