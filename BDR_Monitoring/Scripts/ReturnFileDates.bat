@ECHO OFF
REM You will pass the name of the text file to the command and the target
REM 
REM FORMAT for Invocation :: ReturnFileDates.bat <filename> <target>
REM 
REM This will create a file on the local machine running the script that will retunr
REM the remote information requested and put that into a filename that you specify.
REM
REM IF YOU INVOKE THIS THROUGH PSEXEC
REM 
set output=%1.txt
FOR %%? IN (%2) DO (
	ECHO Filename:%%~n? >> %output%
	ECHO File Extension:%%~x? >> %output%
	ECHO File Attributes:%%~a? >> %output%
	ECHO Located on Drive:%%~d? >> %output%
	ECHO File Size:%%~z? >> %output%
	ECHO Last-Modified Date:%%~t? >> %output%
	ECHO. >> %output%
)
