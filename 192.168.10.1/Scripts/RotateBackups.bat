
cmd /c date /t>DOW 
set /p today=<DOW 
set DOW=%today:~0,3%
del DOW

:: Run Today M-F

IF "%DOW%" == "Mon" GOTO :DAILY
IF "%DOW%" == "Tue" GOTO :DAILY 
IF "%DOW%" == "Wed" GOTO :DAILY 
IF "%DOW%" == "Thu" GOTO :DAILY
IF "%DOW%" == "Fri" GOTO :FRI
IF "%DOW%" == "Sat" GOTO :DAILY
IF "%DOW%" == "Sun" GOTO :DAILY

GOTO :END


:FRI

d:
cd\
rd veeam /s /q
md Veeam

:DAILY

REM c:
REM cd\
REM cd Acronis
REM rd 03 /s /q
REM rd 02 /s /q
REM cd 01
REM del *.tib /q

GOTO :END 


:END

