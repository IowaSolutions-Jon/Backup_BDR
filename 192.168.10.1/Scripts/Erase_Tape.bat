
cmd /c date /t>DOW 
set /p today=<DOW 
set DOW=%today:~0,3%
del DOW

:: Run Today M-F

IF "%DOW%" == "Mon" GOTO :MON
IF "%DOW%" == "Tue" GOTO :TUE 
IF "%DOW%" == "Wed" GOTO :WED 
IF "%DOW%" == "Thu" GOTO :THU
IF "%DOW%" == "Fri" GOTO :FRI
GOTO :END

 

:MON

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -erase 2 2 0 qz

GOTO :END 


:TUE

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -erase 2 2 0 qz

GOTO :END 


:WED

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -erase 2 2 0 qz
pause

GOTO :END 
 

:THU

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -erase 2 2 0 qz

GOTO :END 
 

:FRI

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -erase 2 2 0 qz

GOTO :END 


:END

