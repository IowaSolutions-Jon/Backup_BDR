@echo on
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

SET filename1="D:\Acronis\01\Host01.tib"
SET filename2="D:\Acronis\01\Host02.tib"
SET filename3="D:\Acronis\01\Host03.tib"
SET filename4="D:\Acronis\01\AZDB.tib"
SET filename5="D:\Acronis\01\NewTransServer.tib"
SET filename5="D:\Acronis\01\Ecopy.tib"

SET esxfile1="D:\Veeam\40.15\40.15.vbm"
SET esxfile2="C:\Veeam\ChathamOaks_OFFSITE.vbm"

SET AZProduction="D:\AZ-SQL_BK\analive.bak"

SET TapeBackup="D:\Install\Scripts\LastTapeBackup.txt"

REM Fix File Names 
ren D:\Acronis\01\AZDB* AZDB.tib
ren D:\Acronis\01\NewTransServer* NewTransServer.tib
ren D:\Acronis\01\Ecopy* Ecopy.tib
ren D:\AZ-SQL_BK\analive*.bak analive.bak
cd\

Rem Do All Files Exist?

IF Not Exist %filename1% GOTO FileMissing
IF Not Exist %filename2% GOTO FileMissing
IF Not Exist %filename3% GOTO FileMissing
IF Not Exist %filename4% GOTO FileMissing
IF Not Exist %filename5% GOTO FileMissing
IF Not Exist %filename6% GOTO FileMissing

IF Not Exist %esxfile1% GOTO FileMissing
IF Not Exist %esxfile2% GOTO FileMissing

IF Not Exist %AZProduction% GOTO FileMissing

IF Not Exist %TapeBackup% GOTO FileMissing

FOR %%f IN (%filename1%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto BadDate

FOR %%f IN (%filename2%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto BadDate

FOR %%f IN (%filename3%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto BadDate

FOR %%f IN (%filename4%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto BadDate

FOR %%f IN (%filename5%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto BadDate

FOR %%f IN (%esxfile1%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto BadDate

FOR %%f IN (%AZProduction%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %YesterdayDate% goto BadDate

REM Check if Tape Backup Ran OK

FOR %%f IN (%TapeBackup%) DO SET filedatetime=%%~tf
IF NOT %filedatetime:~0, 10% == %TodayDate% goto BadDate

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

pause