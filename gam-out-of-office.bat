@echo off
setlocal EnableDelayedExpansion
set gampath=C:\gam-3\
if exist %gampath%gam.exe ( goto start
) else (
echo ************************************************************
echo * %gampath% is not the correct location of gam.exe         *
echo * Please edit this batch file and correct!                 *
echo ************************************************************
goto end 
)

:start
if exist "C:\temp\OutofOfficeSettings.csv" ( goto readfile
) else (
echo *************************************************************
echo * OutofOfficeSettings.csv is not in the correct location    *
echo * Please edit this batch file and correct!                   *
echo *************************************************************
goto end 
)


:readfile
for /F "tokens=1,2,3,4,5,6,7,8 skip=1 delims=," %%a in (C:\temp\OutofOfficeSettings.csv) do ( 
	set "gstring1=gam user %%a vacation %%b subject %%c message %%d startdate %%e enddate %%f"
	rem @echo !gstring1!
	if %%g==y ( set "gstring2=!gstring1! contactsonly" ) else ( set "gstring2=!gstring1!" )
	if %%h==y ( set "gstring3=!gstring2! domainonly" ) else ( set "gstring3=!gstring2!" )
	!gstring3!
)
:end
