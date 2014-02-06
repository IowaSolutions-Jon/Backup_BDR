@ECHO OFF
d:
@call D:\install\scripts\YesterdayDate.bat
DEL /f /q "D:\Install\Scripts\report.txt"
set mm=%date:~4,2%
set dd=%date:~7,2%
set ydd=dd - 1
set yyyy=%date:~10,4%
echo Todays Date is: %mm%/%dd%/%yyyy%
set TodayDate=%mm%/%dd%/%yyyy%
set YesterdayDate=%Yesterday%

echo Yesterday's Date is: %YesterdayDate%

SET filename1="D:\Acronis\01\Host01.tib"
SET filename2="D:\Acronis\01\Host02.tib"
SET filename3="D:\Acronis\01\Host03.tib"
SET filename4="D:\Acronis\01\AZDB.tib"
SET filename5="D:\Acronis\01\NewTransServer.tib"
SET filename6="D:\Acronis\01\Ecopy.tib"
SET filename7="D:\Veeam\40.15\40.15.vbm"
SET filename8="C:\Veeam\ChathamOaks_OFFSITE\ChathamOaks_OFFSITE.vbm"
SET filename9="D:\AZ-SQL_BK\analive.bak"
SET filename10="D:\Install\Scripts\LastTapeBackup.txt"

REM Fix File Names 
ren D:\Acronis\01\AZDB* AZDB.tib
ren D:\Acronis\01\NewTransServer* NewTransServer.tib
ren D:\Acronis\01\Ecopy* Ecopy.tib
ren D:\AZ-SQL_BK\analive*.bak analive.bak

Rem Do All Files Exist?
ECHO. >> D:\Install\Scripts\report.txt
ECHO FILE EXISTENCE CHECKING...>> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
set missing=0
GOTO FILECHECK1

:FILECHECK1
IF Not Exist %filename1% GOTO FileMissing1
ECHO %filename1% was found. >> D:\Install\Scripts\report.txt
:FILECHECK2
IF Not Exist %filename2% GOTO FileMissing2 
ECHO %filename2% was found. >> D:\Install\Scripts\report.txt
:FILECHECK3
IF Not Exist %filename3% GOTO FileMissing3
ECHO %filename3% was found. >> D:\Install\Scripts\report.txt
:FILECHECK4
IF Not Exist %filename4% GOTO FileMissing4 
ECHO %filename4% was found. >> D:\Install\Scripts\report.txt
:FILECHECK5
IF Not Exist %filename5% GOTO FileMissing5
ECHO %filename5% was found. >> D:\Install\Scripts\report.txt
:FILECHECK6
IF Not Exist %filename6% GOTO FileMissing6
ECHO %filename6% was found. >> D:\Install\Scripts\report.txt
:FILECHECK7
IF Not Exist %filename7% GOTO FileMissing7
ECHO %filename7% was found. >> D:\Install\Scripts\report.txt
:FILECHECK8
IF Not Exist %filename8% GOTO FileMissing8
ECHO %filename8% was found. >> D:\Install\Scripts\report.txt
:FILECHECK9
IF Not Exist %filename9% GOTO FileMissing9
ECHO %filename9% was found. >> D:\Install\Scripts\report.txt
:FILECHECK10
IF Not Exist %filename10% GOTO FileMissing10
ECHO %filename10% was found. >> D:\Install\Scripts\report.txt

GOTO FILECHECKFINAL

REM FILE MISSING SPECIFICATION REPORTING

:FileMissing1
echo File 1 : %filename1% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK2

:FileMissing2
echo File 2 : %filename2% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK3

:FileMissing3
echo File 3 : %filename3% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK4

:FileMissing4
echo File 4 : %filename4% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK5

:FileMissing5
echo File 5 : %filename5% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK6

:FileMissing6
echo File 6 : %filename6% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK7

:FileMissing7
echo File 7 : %esxfile1% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK8

:FileMissing8
echo File 8 : %esxfile2% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK9

:FileMissing9
echo File 9 : %AZProduction% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECK10

:FileMissing10
echo File 10 : %TapeBackup% is missing >> D:\Install\Scripts\report.txt
set missing=1
goto FILECHECKFINAL

:FILECHECKFINAL
IF %missing% EQU 1 (GOTO FILESGONE) ELSE (GOTO FILESFOUND)

:FILESGONE
ECHO. >> D:\Install\Scripts\report.txt
ECHO Files are missing - see above reporting>> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
GOTO FAILURE

:FILESFOUND
ECHO. >> D:\Install\Scripts\report.txt
ECHO All files are available and located! >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
GOTO DATEBLOCK

:DATEBLOCK
set dok=0
ECHO. >> D:\Install\Scripts\report.txt
ECHO FILE ^DATE CHECKING...>> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt
set dok=0
GOTO BADDATE0


:BADDATE0
FOR %%f IN (%filename1%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE1
ECHO %filename1% is current. >> D:\Install\Scripts\report.txt
:BADDATE1
FOR %%f IN (%filename2%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE2
ECHO %filename2% is current. >> D:\Install\Scripts\report.txt
:BADDATE2
FOR %%f IN (%filename3%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE3
ECHO %filename3% is current. >> D:\Install\Scripts\report.txt
:BADDATE3
FOR %%f IN (%filename4%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE4
ECHO %filename4% is current. >> D:\Install\Scripts\report.txt
:BADDATE4
FOR %%f IN (%filename5%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE5
ECHO %filename5% is current. >> D:\Install\Scripts\report.txt
:BADDATE5
FOR %%f IN (%filename6%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE6
ECHO %filename6% is current. >> D:\Install\Scripts\report.txt
:BADDATE6
FOR %%f IN (%filename7%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE7
ECHO %filename7% is current. >> D:\Install\Scripts\report.txt
:BADDATE7
FOR %%f IN (%filename8%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE8
ECHO %filename8% is current. >> D:\Install\Scripts\report.txt
:BADDATE8
FOR %%f IN (%filename9%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto CDATE9
ECHO %filename9% is current. >> D:\Install\Scripts\report.txt
:BADDATE9
REM Check if Tape Backup Ran OK
FOR %%f IN (%filename10%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %TodayDate% goto CDATE10
ECHO %filename10% is current. >> D:\Install\Scripts\report.txt

GOTO DATECHECKFINAL

:CDATE1
ECHO FILE 1: %filename1% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE2

:CDATE2
ECHO FILE 2: %filename2% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE3

:CDATE3
ECHO FILE 3: %filename3% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE4

:CDATE4
ECHO FILE 4: %filename4% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE5

:CDATE5
ECHO FILE 5: %filename5% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE6

:CDATE6
ECHO FILE 6: %filename6% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE7

:CDATE7
ECHO FILE 7: %filename7% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE8

:CDATE8
ECHO FILE 8: %filename8% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE9

:CDATE9
ECHO FILE 9: %filename9% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO BADDATE10

:CDATE10
ECHO FILE 10: %filename10% is old >> D:\Install\Scripts\report.txt
set dok=1
GOTO DATECHECKFINAL

:DATECHECKFINAL
if %dok%==1 (GOTO DATECHECKFAILED) ELSE (GOTO DATECHECKOK)

:DATECHECKOK
ECHO. >> D:\Install\Scripts\report.txt
ECHO All dates are correct according to parameters >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt

echo SUCCESS!!!
d:
cd\Install\Scripts\Cmail_Success
cmail

goto END

:DATECHECKFAILED
ECHO. >> D:\Install\Scripts\report.txt
ECHO Not all dates are correct, see above reporting. >> D:\Install\Scripts\report.txt
ECHO. >> D:\Install\Scripts\report.txt

echo Bad Date Compare!
d:
cd\Install\Scripts\Cmail_BadDate
cmail
goto END

:FAILURE
echo Files are Missing!
PAUSE
d:
cd\Install\Scripts\Cmail_FAILED
cmail
goto END


:END
cd\install\scripts
exit