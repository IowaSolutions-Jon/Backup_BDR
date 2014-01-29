@ECHO OFF
CD C:\Scripts
setlocal ENABLEDELAYEDEXPANSION
DEL C:\Scripts\datemap.txt
DEL C:\Scripts\report.txt
REM Access the network drive
net use \\172.16.10.10 /user:cyber2002 yyeXjAML@2012


REM Set the files for validation
SET esxfile1="\\172.16.10.10\usb1-2share1\Veeam\10.61\10.61.vbm"
SET esxfile2="\\172.16.10.10\usb1-2share1\Veeam\10.62\10.62.vbm"
SET esxfile3="\\172.16.10.10\usb1-2share1\Veeam\10.63\10.63.vbm"
SET esxfile4="\\172.16.10.10\usb1-2share1\Veeam\10.64\10.64.vbm"
SET esxfile5="\\172.16.10.10\usb1-2share1\Veeam\10.65\10.65.vbm"

REM Get last 4 days dates for reference
@call GetDateTarget.bat 4
@call GetDateTarget.bat 3
@call GetDateTarget.bat 2
@call GetDateTarget.bat 1

REM Read the contents of the date map into the current running script
set vidx=0
for /F "tokens=*" %%A in (datemap.txt) do (
    SET /A vidx=!vidx! + 1
    set var!vidx!=%%A
)
set var

:ESX1
set /a bad=0
FOR %%f IN (%esxfile1%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %var1% goto Esxfile1-OK
IF %filedatetime:~0, 10% == %var2% goto Esxfile1-OK
IF %filedatetime:~0, 10% == %var3% goto Esxfile1-OK
IF %filedatetime:~0, 10% == %var4% goto Esxfile1-OK
goto BadDate_1

:ESX2
FOR %%f IN (%esxfile2%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %var1% goto Esxfile2-OK
IF %filedatetime:~0, 10% == %var2% goto Esxfile2-OK
IF %filedatetime:~0, 10% == %var3% goto Esxfile2-OK
IF %filedatetime:~0, 10% == %var4% goto Esxfile2-OK
goto BadDate_2

:ESX3
FOR %%f IN (%esxfile3%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %var1% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var2% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var3% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var4% goto Esxfile-OK
goto BadDate_3

:ESX4
FOR %%f IN (%esxfile4%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %var1% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var2% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var3% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var4% goto Esxfile-OK
goto BadDate_4

:ESX5
FOR %%f IN (%esxfile5%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %var1% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var2% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var3% goto Esxfile-OK
IF %filedatetime:~0, 10% == %var4% goto Esxfile-OK
goto BadDate_5


:Esxfile1-OK
ECHO %esxfile1% is current >> report.txt
GOTO ESX2

:BadDate_1
set /a bad=1
ECHO %esxfile1% is out of date >> report.txt
GOTO ESX2

:Esxfile2-OK
ECHO %esxfile2% is current >> report.txt
GOTO ESX3

:BadDate_2
set /a bad=1
ECHO %esxfile2% is out of date >> report.txt
GOTO ESX3

:Esxfile3-OK
ECHO %esxfile3% is current >> report.txt
GOTO ESX4

:BadDate_3
set /a bad=1
ECHO %esxfile3% is out of date >> report.txt
GOTO ESX4

:Esxfile4-OK
ECHO %esxfile4% is current >> report.txt
GOTO ESX5

:BadDate_4
set /a bad=1
ECHO %esxfile4% is out of date >> report.txt
GOTO ESX5

:Esxfile5-OK
ECHO %esxfile5% is current >> report.txt
GOTO ENDGAME

:BadDate_5
set /a bad=1
ECHO %esxfile5% is out of date >> report.txt
GOTO ENDGAME

:ENDGAME
if %bad%==1 (GOTO BADEND) else (GOTO GOODEND)

:BADEND
ECHO SUBJECT^=IAS 172.16.10.6 FAILED >> Cmail_FAILED\cmail.ini
ECHO MESSAGE^=172.16.10.6 Backup FAILED Results Files are showing old dates. One of the backup systems did not run as expected^.^;^/n^/n >> Cmail_FAILED\cmail.ini
ECHO DELETEAFTERSEND^=0 >> Cmail_FAILED\cmail.ini
ECHO.  >> Cmail_FAILED\cmail.ini
ECHO.  >> Cmail_FAILED\cmail.ini
ECHO ^;ATTACHMENTS^=../report.txt >> Cmail_FAILED\cmail.ini
CD Cmail_FAILED
cmail
EXIT

:GOODEND
ECHO SUBJECT^=IAS 172.16.10.6 Success >> Cmail_Success\cmail.ini
ECHO MESSAGE^=172.16.10.6 Backup Success Results Files are showing old dates. One of the backup systems did not run as expected^.^;^/n^/n >> Cmail_Success\cmail.ini
ECHO DELETEAFTERSEND^=0 >> Cmail_Success\cmail.ini
ECHO.  >> Cmail_Success\cmail.ini
ECHO.  >> Cmail_Success\cmail.ini
ECHO ^;ATTACHMENTS^=../report.txt >> Cmail_Success\cmail.ini
CD Cmail_Success
cmail
EXIT

