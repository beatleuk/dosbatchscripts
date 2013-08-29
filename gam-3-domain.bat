@echo off
setlocal EnableDelayedExpansion
set gampath=C:\gam-3\
if exist %gampath%gam.exe ( goto start
) else (
echo ************************************************************
echo * %gampath% is not the correct location of gam.exe *
echo * Please edit this batch file and correct!                  *
echo ************************************************************
goto end 
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
   goto getOption
)
if %opt%==0 goto:EOF
if %opt%==1 goto:clearsel
goto:doopt

:clearsel
del %gampath%oauth2.txt
gam info domain 
call :getdom
set destfile=%gampath%%dom%_oauth2.txt
copy %gampath%oauth2.txt %destfile%
goto :end

:doopt
echo !name[%opt%]! is the chosen domain for GAM
del %gampath%oauth2.txt
copy %gampath%!name[%opt%]!_oauth2.txt %gampath%oauth2.txt
goto :end

:getdom
FOR /F "tokens=*" %%i in ('c:\gawk\bin\awk.exe -f %gampath%script.awk %gampath%oauth2.txt') do SET dom=%%i
goto end
goto :end

:end
