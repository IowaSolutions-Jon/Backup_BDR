
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
IF "%DOW%" == "Sat" GOTO :FRI
GOTO :END

 

:MON

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -cherase 3 5 1 1

GOTO :END 


:TUE

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -cherase 3 5 1 2

GOTO :END 


:WED

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -cherase 3 5 1 3
pause

GOTO :END 
 

:THU

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -cherase 3 5 1 4

GOTO :END 
 

:FRI

C:
cd\
cd "Program Files (x86)\CA\ARCserve Backup"
ca_devmgr -cherase 3 5 1 5

GOTO :END 


:END

