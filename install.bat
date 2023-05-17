@echo on

::VARIABLES

set set_vars=%~dp0scripts\set_vars.bat
set install_progs=%~dp0scripts\install_progs.bat
set install_confs=%~dp0scripts\install_confs.bat
echo %install_confs%

call %set_vars%

::PROGRAM
call %install_progs%
call %install_confs%