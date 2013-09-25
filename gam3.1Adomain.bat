@echo off
setlocal EnableDelayedExpansion
set gampath=%CD%\
if exist %gampath%gam.exe ( 
 if exist C:\gawk\bin\gawk.exe (
  goto:start
 ) else (
  echo ************************************************************
  echo * GAWK needs to be installed for this batch file to run    *
  echo * Please download and install it, your browser will now    *
  echo * open and download it from http://gnuwin32.sourceforge.net*
  echo ************************************************************
  call :sleep 3
  Start http://gnuwin32.sourceforge.net/downlinks/gawk.php
  pause
 )
) else (
echo ************************************************************
echo * %gampath% is not the correct location of gam.exe *
echo * Please place this batch file in the GAM directory        *
echo ************************************************************
goto:end 
)

:start
rem c:
rem cd
dir /B %gampath%*_oauth2.txt >%gampath%oauths.txt
cls
rem set /p curdom= <%gampath%oauth2.txt
call :getdom
echo Current domain in use is %dom%
echo Menu
echo 0. To exit
set i=1
echo !i!. Clear current oauth2.txt and generate new one (domain name entered later)
for /F "tokens=1,* delims=_" %%a in (%gampath%oauths.txt) do (
   set /A i+=1
   set "name[!i!]=%%a"
   echo !i!. %%a
)
set lastOpt=%i%

:getOption
set /P "opt=Enter desired option : "
if %opt% gtr %lastOpt% (
   echo Please choose from the options above
   goto:getOption
)
if %opt%==0 goto:EOF
if %opt%==1 goto:clearsel
goto:doopt

:clearsel
del %gampath%oauth2.txt
del %gampath%oauth2service.p12
del %gampath%oauth2service.txt
gam info domain 
call :getdom
copy %gampath%oauth2.txt %gampath%%dom%_oauth2.txt
goto:svc_acc1

:svc_acc1
if exist %gampath%oauth2service.p12 ( 
@copy %gampath%oauth2service.p12 %gampath%%dom%_oauth2service.p12
goto:svc_acc2
) else (
echo ************************************************************
echo * You need to setup a service account, this will now       *
echo * launch your browser with instructions on how to do this  *
echo * please return here once these steps have been created    *
echo * and continue the process                                 *
echo ************************************************************
call :sleep 3
Start https://code.google.com/p/google-apps-manager/wiki/GAM3OAuthServiceAccountSetup
pause
goto:svc_acc1
)

:svc_acc2
if exist %gampath%oauth2service.txt (
@copy %gampath%oauth2service.txt %gampath%%dom%_oauth2service.txt
goto:end
) else (
echo ************************************************************
echo * You need complete the service account setup by running   *
echo * the follwoing GAM command                                *
echo * "gam user <non admin user email> show calendars"         *
echo * please return here once this step has been completed     *
echo ************************************************************
pause
goto:svc_acc2
)
goto:end

:doopt
echo !name[%opt%]! is the chosen domain for GAM
@del %gampath%oauth2.txt
@del %gampath%oauth2service.p12
@del %gampath%oauth2service.txt
@copy %gampath%!name[%opt%]!_oauth2.txt %gampath%oauth2.txt
@copy %gampath%!name[%opt%]!_oauth2service.p12 %gampath%oauth2service.p12
@copy %gampath%!name[%opt%]!_oauth2service.txt %gampath%oauth2service.txt
goto:end

:getdom
FOR /F "tokens=*" %%i in ('c:\gawk\bin\awk.exe -f %gampath%script.awk %gampath%oauth2.txt') do SET dom=%%i


:sleep
ping 127.0.0.1 -n 2 -w 1000 > NUL
ping 127.0.0.1 -n %1 -w 1000 > NUL

:end
