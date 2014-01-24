REM net use \\172.16.30.11 /user:chathamoaks\veeam Veeam2013

d:
@call D:\install\scripts\YesterdayDate.bat

set mm=%date:~4,2%
set dd=%date:~7,2%
set ydd=dd - 1
set yyyy=%date:~10,4%
echo Todays Date is: %mm%/%dd%/%yyyy%
set TodayDate=%mm%/%dd%/%yyyy%
set YesterdayDate=%Yesterday%

echo Yesterday's Date is: %YesterdayDate%

REM SET filename1="C:\Acronis\01\AbbeCC1.tib"

SET esxfile1="D:\Veeam\10.10\10.10.vbm"
SET esxfile2="D:\Veeam\10.09\10.09.vbm"
REM SET esxfile3="\\172.16.30.11\z$\ChathamVeeam\ChathamOaks\ChathamOaks.vbm"

SET TapeBackup="D:\Install\Scripts\LastTapeBackup.txt"

REM Fix File Names 
REM ren C:\Acronis\01\AbbeCC1* AbbeCC1.tib

Rem Do All Files Exist?

REM IF Not Exist %filename1% GOTO FileMissing

IF Not Exist %esxfile1% GOTO FileMissing
IF Not Exist %esxfile2% GOTO FileMissing
REM IF Not Exist %esxfile3% GOTO FileMissing

IF Not Exist %TapeBackup% GOTO FileMissing

REM FOR %%f IN (%filename1%) DO SET filedatetime=%%~tf
REM IF %filedatetime:~0, 10% == %TodayDate%	goto Filename1-OK
REM IF %filedatetime:~0, 10% == %YesterdayDate% goto Filename1-OK
REM goto BadDate
REM :Filename1-OK

FOR %%f IN (%esxfile1%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %TodayDate% goto Esxfile1-OK
IF %filedatetime:~0, 10% == %YesterdayDate% goto Esxfile1-OK
goto BadDate

:Esxfile1-OK

FOR %%f IN (%esxfile2%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %TodayDate% goto Esxfile2OK
IF %filedatetime:~0, 10% == %YesterdayDate% goto Esxfile2-OK
goto BadDate

:Esxfile2-OK


REM FOR %%f IN (%esxfile3%) DO SET filedatetime=%%~tf
REM IF %filedatetime:~0, 10% == %TodayDate% goto Esxfile3-OK
REM IF %filedatetime:~0, 10% == %YesterdayDate% goto Esxfile3-OK
REM goto BadDate

GOTO Esxfile3-Ok

:Esxfile3-OK

REM Check if Tape Backup Ran OK

FOR %%f IN (%TapeBackup%) DO SET filedatetime=%%~tf
IF %filedatetime:~0, 10% == %TodayDate% goto TapeBackup-OK
IF %filedatetime:~0, 10% == %esterdayDate% goto TapeBackup-OK
goto BadDate

:TapeBackup-OK

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