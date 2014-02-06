REM net use \\172.16.30.11 /user:chathamoaks\veeam Veeam2013
@ECHO OFF
d:
@call D:\install\scripts\YesterdayDate.bat
DEL /F /Q "D:\Install\Scripts\report.txt"
set mm=%date:~4,2%
set dd=%date:~7,2%
set ydd=dd - 1
set yyyy=%date:~10,4%
echo Todays Date is: %mm%/%dd%/%yyyy%
set TodayDate=%mm%/%dd%/%yyyy%
set YesterdayDate=%Yesterday%

echo Yesterday's Date is: %YesterdayDate%
set missing=0


SET esxfile1="D:\Veeam\10.10\10.10.vbm"
SET esxfile2="D:\Veeam\10.09\10.09.vbm"
SET TapeBackup="D:\Install\Scripts\LastTapeBackup.txt"

ECHO.  >> D:\Install\Scripts\report.txt
ECHO Checking file presence  >> D:\Install\Scripts\report.txt
ECHO.  >> D:\Install\Scripts\report.txt



:CHECKFILE1
IF Not Exist %esxfile1% GOTO FileMissing1
ECHO File 1: %esxfile1% was found.  >> D:\Install\Scripts\report.txt
:CHECKFILE2
IF Not Exist %esxfile2% GOTO FileMissing2
ECHO File 1: %esxfile2% was found.  >> D:\Install\Scripts\report.txt
:CHECKFILE3
IF Not Exist %TapeBackup% GOTO FileMissing3
ECHO File 1: %TapeBackup% was found.  >> D:\Install\Scripts\report.txt
GOTO DATECHECK

:FileMissing1
set missing=1
ECHO File 1: %esxfile1% is missing >> D:\Install\Scripts\report.txt
GOTO CHECKFILE2

:FileMissing2
set missing=1
ECHO File 2 %esxfile2% is missing >> D:\Install\Scripts\report.txt
GOTO CHECKFILE3

:FileMissing3
set missing=1
ECHO File 3: %TapeBackup% is missing >> D:\Install\Scripts\report.txt
GOTO FILESFOUND

:FILESFOUND
IF %missing% EQU 0 (GOTO ALLFOUND) ELSE (GOTO MIA)

:MIA
echo.  >> D:\Install\Scripts\report.txt
echo Files are missing, moving to check further into issues.  >> D:\Install\Scripts\report.txt
echo.  >> D:\Install\Scripts\report.txt
GOTO FileMissing

:ALLFOUND
echo.  >> D:\Install\Scripts\report.txt
echo ALL Files were found on the system  >> D:\Install\Scripts\report.txt
echo.  >> D:\Install\Scripts\report.txt
GOTO DATECHECK




:DATECHECK
set dok=0
echo.  >> D:\Install\Scripts\report.txt
echo Checking file dates...  >> D:\Install\Scripts\report.txt
echo. >> D:\Install\Scripts\report.txt

:Esxfile0-OK

FOR %%f IN (%esxfile1%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %TodayDate% goto Esxfile1-OK
IF %filedatetime:~0, 10% == %YesterdayDate% goto Esxfile1-OK
goto BadDate1

:Esxfile1-OK

FOR %%f IN (%esxfile2%) DO SET filedatetime=%%~tf
echo File 1: %esxfile1% is current  >> D:\Install\Scripts\report.txt
IF %filedatetime:~0, 10% == %TodayDate% goto Esxfile2OK
IF %filedatetime:~0, 10% == %YesterdayDate% goto Esxfile2-OK
goto BadDate2

:Esxfile2-OK

GOTO Esxfile3-Ok

:Esxfile3-OK

REM Check if Tape Backup Ran OK

FOR %%f IN (%TapeBackup%) DO SET filedatetime=%%~tf
echo File 2: %esxfile2% is current  >> D:\Install\Scripts\report.txt
IF %filedatetime:~0, 10% == %TodayDate% goto TapeBackup-OK
IF %filedatetime:~0, 10% == %esterdayDate% goto TapeBackup-OK
goto BadDate3


:BadDate1
ECHO. >> D:\Install\Scripts\report.txt
ECHO File 1 : %esxfile1% is out of current >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
set dok=1
GOTO Esxfile1-OK

:BadDate2
ECHO. >> D:\Install\Scripts\report.txt
ECHO File 1 : %esxfile1% is out of current >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
set dok=1
GOTO Esxfile1-OK

:BadDate3
ECHO. >> D:\Install\Scripts\report.txt
ECHO File 1 : %esxfile1% is out of current >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
set dok=1
GOTO 


:TapeBackup-OK
echo File 3: %TapeBackup% is current  >> D:\Install\Scripts\report.txt

echo SUCCESS!!!
d:
cd\Install\Scripts\Cmail_Success
cmail

goto END


:BadDate
echo Bad Date Compare!
d:
cd\Install\Scripts\Cmail_BadDate
cmail
goto END

:FileMissing
echo Files are Missing!
d:
cd\Install\Scripts\Cmail_FAILED
cmail
goto END

:END
cd\install\scripts