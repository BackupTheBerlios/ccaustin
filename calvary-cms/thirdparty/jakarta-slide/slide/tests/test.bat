@echo off
REM $Id: test.bat,v 1.1 2003/02/12 22:14:35 javajames27 Exp $
set JAVA=%JAVA_HOME%\bin\java
set _OLD=%_CLASSPATH%
set _CLASSPATH=..\classes;..\lib\slide-kernel.jar;..\lib\slide-stores.jar;.\junit.jar;.\webdavlib.jar;%CLASSPATH%

%JAVA% -classpath %_CLASSPATH% junit.swingui.TestRunner %1

set _CLASSPATH=%_OLD%