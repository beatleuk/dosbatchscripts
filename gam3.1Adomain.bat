@echo off
setlocal EnableDelayedExpansion
set gampath=%CD%\
:checks
if exist %gampath%gam.exe ( 
 if exist %gampath%bin\awk.exe (
  goto:start
 ) else (
  echo **********************************************************
  echo * AWK.exe needs to be present in this directory for this *
  echo * batch file to run. your browser will now open and      *
  echo * download it from http://gnuwin32.sourceforge.net       *
  echo * save it to %gampath% and press any key to continue  *
  echo **********************************************************
  call :sleep 5
  Start http://gnuwin32.sourceforge.net/downlinks/gawk-bin-zip.php
  pause
  FOR /F "tokens=*" %%g in ('dir /b gawk*.zip') do set gawkzip=%%g
  jar xf %gawkzip% bin/awk.exe
  del %gawkzip%
  goto:checks
 )
) else (
echo ************************************************************
echo * %gampath% is not the correct location of gam.exe *
echo * Please place this batch file in the GAM directory        *
echo ************************************************************
goto:checks
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
FOR /F "tokens=*" %%i in ('%gampath%bin\awk.exe -f %gampath%script.awk %gampath%oauth2.txt') do SET dom=%%i


:sleep
ping 127.0.0.1 -n 2 -w 1000 > NUL
ping 127.0.0.1 -n %1 -w 1000 > NUL

:end
