@echo off
setlocal EnableDelayedExpansion
set gampath=C:\gam\
if exist %gampath%\gam.exe ( goto getgrpid
) else (
echo ************************************************************
echo * %gampath% is not the correct location of gam.exe *
echo * Please edit this batch file and correct!                  *
echo ************************************************************
goto end 
)

set groupid=""
:getgrpid
set /P "groupid=Enter group to be changed : "
if [%groupid%] == [] (
   echo Please enter a valid group email address
   goto getgrpid
)
if [%groupid%]==[0] goto:EOF
if [%groupid%]==[exit] goto:EOF

goto:dogrpset

:dogrpset
gam info group %groupid%
IF %ERRORLEVEL%==1303 (
	ECHO Invalid group address, please re-enter
	goto:getgrpid
)
gam update group %groupid% settings spam_moderation_level allow
IF %ERRORLEVEL%==0 (ECHO Spam moderation level for %groupid% set to allow)
IF %ERRORLEVEL%==1 (ECHO Spam moderation level not changed)
gam update group %groupid% settings allow_external_members true
IF %ERRORLEVEL%==0 (ECHO %groupid% is set to allow external members)
IF %ERRORLEVEL%==1 (ECHO External members setting not changed)
gam update group %groupid% settings who_can_join invited_can_join
IF %ERRORLEVEL%==0 (ECHO Only invited members are alowed to join %groupid%)
IF %ERRORLEVEL%==1 (ECHO Who is allowed to join is not changed)
gam update group %groupid% settings primary_language en-GB
IF %ERRORLEVEL%==0 (ECHO Primary language for %groupid% set to en-GB)
IF %ERRORLEVEL%==1 (ECHO Primary language not changed)
gam update group %groupid% settings who_can_post_message anyone_can_post
IF %ERRORLEVEL%==0 (ECHO Anyone is allowed to post to %groupid%)
IF %ERRORLEVEL%==1 (ECHO Who is allowed to post is not changed)
gam update group %groupid% settings is_archived false
IF %ERRORLEVEL%==0 (ECHO Email for %groupid% will not be archived)
IF %ERRORLEVEL%==1 (ECHO Archiving has not been changed)
gam update group %groupid% settings show_in_group_directory true
IF %ERRORLEVEL%==0 (ECHO %groupid% will be shown in the groups directory)
IF %ERRORLEVEL%==1 (ECHO Groups diretory visibility not changed)
gam update group %groupid% settings allow_web_posting false
IF %ERRORLEVEL%==0 (ECHO Messages can only be posted to %groupid% by email)
IF %ERRORLEVEL%==1 (ECHO Web posting of messages setting has not changed)

:more
set /P "yn=Do you want to run for another group (y/n) : "
if [%yn%] == [] (
   echo Please enter y or n
   goto more
)
if [%yn%]==[y] goto:getgrpid
if [%yn%]==[n] goto:EOF


:end
