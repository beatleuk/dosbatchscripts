@echo off
setlocal EnableDelayedExpansion
set gampath=%CD%
if exist %gampath%\gam.exe ( 
	goto:updgrp
) else (
	echo ************************************************************
	echo * %gampath% is not the correct location of gam.exe *
	echo * Please edit this batch file and correct!                  *
	echo ************************************************************
	goto:end 
)

rem To get a list of all groups in your GAfB account run 
rem gam print groups >groups.txt

:updgrp
for /F "tokens=*"  %%a in (%gampath%\groups.txt) do (
gam update group %%a settings spam_moderation_level allow
IF %ERRORLEVEL%==0 (ECHO Spam moderation level for %%a set to allow)
IF %ERRORLEVEL%==1 (ECHO Spam moderation level not changed)
gam update group %%a settings allow_external_members true
IF %ERRORLEVEL%==0 (ECHO %%a is set to allow external members)
IF %ERRORLEVEL%==1 (ECHO External members setting not changed)
gam update group %%a settings who_can_join invited_can_join
IF %ERRORLEVEL%==0 (ECHO Only invited members are alowed to join %%a)
IF %ERRORLEVEL%==1 (ECHO Who is allowed to join is not changed)
gam update group %%a settings primary_language en-GB
IF %ERRORLEVEL%==0 (ECHO Primary language for %%a set to en-GB)
IF %ERRORLEVEL%==1 (ECHO Primary language not changed)
gam update group %%a settings who_can_post_message anyone_can_post
IF %ERRORLEVEL%==0 (ECHO Anyone is allowed to post to %%a)
IF %ERRORLEVEL%==1 (ECHO Who is allowed to post is not changed)
gam update group %%a settings is_archived false
IF %ERRORLEVEL%==0 (ECHO Email for %%a will not be archived)
IF %ERRORLEVEL%==1 (ECHO Archiving has not been changed)
gam update group %%a settings show_in_group_directory true
IF %ERRORLEVEL%==0 (ECHO %%a will be shown in the groups directory)
IF %ERRORLEVEL%==1 (ECHO Groups diretory visibility not changed)
gam update group %%a settings allow_web_posting false
IF %ERRORLEVEL%==0 (ECHO Messages can only be posted to %%a by email)
IF %ERRORLEVEL%==1 (ECHO Web posting of messages setting has not changed)
)	

:end
