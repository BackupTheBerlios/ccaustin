@echo off
REM $Id: example.bat,v 1.1 2003/02/12 22:13:37 javajames27 Exp $
set JAVA=%JAVA_HOME%\bin\java
set _OLD=%_CLASSPATH%
set _CLASSPATH=..\..\classes;..\..\lib\slide-kernel.jar;..\..\lib\slide-stores.jar;..\..\lib\slide-roles.jar;..\;..\..\lib\jaxp.jar;..\..\lib\crimson.jar;..\..\lib\jta.jar;..\..\lib\hsqldb.jar;%CLASSPATH%

cd %1
%JAVA% -classpath %_CLASSPATH% %1.Test %2 %3 %4 %5 %6
cd ..

set _CLASSPATH=%_OLD%