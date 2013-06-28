@echo off
setlocal EnableDelayedExpansion
set gampath=C:\gam\
if exist %gampath%\gam.exe ( goto start
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
dir /B %gampath%*_oauth.txt >%gampath%oauths.txt
cls
set /p curdom= <%gampath%oauth.txt
echo Current domain in use is %curdom%
echo Menu
echo 0. To exit
set i=1
echo !i!. Clear current oauth.txt and generate new one (domain name entered later)
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
del %gampath%oauth.txt
gam info domain 
set /p dom= <%gampath%oauth.txt
set dom=%dom:~0,-1%
set destfile=%gampath%%dom%_oauth.txt
copy %gampath%oauth.txt %destfile%
goto :end

:doopt
echo !name[%opt%]! is the chosen domain for GAM
del %gampath%oauth.txt
copy %gampath%!name[%opt%]!_oauth.txt %gampath%oauth.txt

:end
