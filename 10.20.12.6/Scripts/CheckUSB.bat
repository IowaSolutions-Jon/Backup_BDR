@ECHO OFF
CD C:\Scripts
setlocal ENABLEDELAYEDEXPANSION
DEL C:\Scripts\datemap.txt
DEL C:\Scripts\report.txt
REM Access the network drive
net use \\10.20.12.6 /user:cyber2002 yyeXjAML@2012


REM Set the files for validation
SET esxfile1="\\10.20.12.5\usb1-2share1\Veeam1\12.09\12.09.vbm"
SET esxfile2="\\10.20.12.5\usb1-2share1\Veeam1\12.10\12.10.vbm"
SET esxfile3="\\10.20.12.5\usb1-2share1\Veeam1\12.11\12.11.vbm"
SET esxfile4="\\10.20.12.5\usb1-2share1\Veeam1\12.12\12.12.vbm"
SET esxfile5="\\10.20.12.5\usb1-2share1\Veeam1\12.13\12.13.vbm"

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
IF %filedatetime:~0, 10% == %var1% goto Esxfile3-OK
IF %filedatetime:~0, 10% == %var2% goto Esxfile3-OK
IF %filedatetime:~0, 10% == %var3% goto Esxfile3-OK
IF %filedatetime:~0, 10% == %var4% goto Esxfile3-OK
goto BadDate_3

:ESX4
FOR %%f IN (%esxfile4%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %var1% goto Esxfile4-OK
IF %filedatetime:~0, 10% == %var2% goto Esxfile4-OK
IF %filedatetime:~0, 10% == %var3% goto Esxfile4-OK
IF %filedatetime:~0, 10% == %var4% goto Esxfile4-OK
goto BadDate_4

:ESX5
FOR %%f IN (%esxfile5%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %var1% goto Esxfile5-OK
IF %filedatetime:~0, 10% == %var2% goto Esxfile5-OK
IF %filedatetime:~0, 10% == %var3% goto Esxfile5-OK
IF %filedatetime:~0, 10% == %var4% goto Esxfile5-OK
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
CD Cmail_FAILED
cmail
EXIT

:GOODEND
CD Cmail_Success
cmail
EXIT

