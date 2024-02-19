@echo off

set rsync_params=-avzh --progress --info=name0 --info=progress2 --include-from=
set set_vars=%~dp0set_vars.bat
call %set_vars%

call:configs_bak
goto:eof

:configs_bak
SETLOCAL
    :: START Clink
        echo Backing up Clink Config | %boxes_bin% -d shell & echo.
        call rsync %rsync_params%%basegitdir_cyg%/configs/clink_filelist %homedir%/AppData/Local/clink/ %basegitdir_cyg%/configs/clink/ & echo. %NL%
    :: END Clink

    :: Starship
        echo Backing up Starship Config | %boxes_bin% -d shell & echo.
        copy "%USERPROFILE%\.config\starship.toml" "%basegitdir%\configs\starship\starship.toml"
    :: END Starship
        echo Backing up Neovim Config | %boxes_bin% -d shell & echo.
        call rsync %rsync_params% %basegitdir_cyg%/configs/all %homedir%/AppData/Local/nvim/ %basegitdir_cyg%/configs/nvim/ & echo. %NL%
    :: START neovim
ENDLOCAL