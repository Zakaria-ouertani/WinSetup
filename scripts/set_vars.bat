@echo off

set homedir=/cygdrive/c/Users/%USERNAME%
set basegitdir_cyg=/cygdrive/c%~p0..
set basegitdir=%~dp0..
set boxes_cfg=%~dp0..\bin\boxes\boxes.cfg
set boxes_bin=%~dp0..\bin\boxes\boxes.exe -f %boxes_cfg%

::START Newline var
set NLM=^


set NL=^^^%NLM%%NLM%^%NLM%%NLM%
::END Newline var