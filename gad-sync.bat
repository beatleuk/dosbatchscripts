rem There are 2 possible locations to install GADS
set x32-path="C:\Program Files (x86)\Google Apps Directory Sync\"
set x64-path="C:\Program Files\Google Apps Directory Sync\"

rem Check for GADS installation and set the correct path
:path
if exist %x64-path%sync-cmd.exe (
	set gads-path=%x64-path%
	goto:config-file
) else (
	if exist %x32-path%sync-cmd.exe ( 
		set gads-path=%x32-path%
		goto:config-file
	) else (
		echo **********************************************************
		echo * GADS doesn't appear to be installed on this computer   *
		echo * your browser will now open on the GADS download page   *
		echo * Download and install GADS then return to this window   *
		echo * and press any key to continue                          *
		echo **********************************************************
		call :sleep 5
		Start https://support.google.com/a/answer/106368?hl=en
		pause
		goto:path
	)
)

:config-file
rem Please specify the GADS configuration file to be used
set gads-config=bishopsmove-1.xml
rem The default path for saving configurations is the same as the install path
rem Please change this if you have saved the file elsewhere
set config-path=%gads-path%

:run-sync
if exist %config-path%%gads-config% (
	cd %gads-path:~3,-1%
	sync-cmd.exe -a -c %config-path:~0,-1%%gads-config%"
	goto:end
) else (
	echo **********************************************************
	echo * The configuration specified doesn't exist in the this  *
	echo * %config-path% *
	echo * directory. please edit this file and change the path   *
	echo **********************************************************
	goto:end
)
		
:sleep
ping 127.0.0.1 -n 2 -w 1000 > NUL
ping 127.0.0.1 -n %1 -w 1000 > NUL

:end
