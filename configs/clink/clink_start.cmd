@echo OFF

::Programs
doskey /macrofile="%userprofile%\.config\cmd\macros.doskey"
chcp 65001>nul

::Functions Calls
call :cmd_colors

:: Functions
:cmd_colors
	for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
	  set ESC=%%b
	  exit /B 0
	)
exit /B 0

