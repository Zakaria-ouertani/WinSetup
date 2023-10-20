@echo off

set rsync_params=-avzh --progress --info=name0 --info=progress2 --include-from=
set set_vars=%~dp0set_vars.bat
call %set_vars%

call:configs_sync
goto:eof

:configs_sync
SETLOCAL
    ::START Clink
    echo Syncing Clink Config | %boxes_bin% -d shell & echo.
    call rsync %rsync_params% %basegitdir_cyg%/configs/clink_filelist %homedir%/AppData/Local/clink %basegitdir_cyg%/configs --dry-run & echo. %NL%
        :: START Clink Completions
            set clink_completions=%USERPROFILE%\AppData\Local\clink\Lua_Scripts\clink-completions
            set more_clink_completions=%USERPROFILE%\AppData\Local\clink\Lua_Scripts\more-clink-completions
            IF NOT EXIST %more_clink_completions% (
                git clone https://github.com/vladimir-kotikov/clink-completions %clink_completions%
            )
            
            IF NOT EXIST %more_clink_completions% (
                git clone https://github.com/sebthom/more-clink-completions %more_clink_completions%
            )
        ::END Clink Completions
    ::END Clink
    
    :: START Starship
        echo Syncing Starship Config | %boxes_bin% -d shell & echo.
        call rsync %rsync_params% %basegitdir_cyg%/configs/starship_filelist %homedir%/.config/starship.toml %basegitdir_cyg%/configs --dry-run
    :: END Starship
    
    ::START neovim
        call rsync %rsync_params% %basegitdir_cyg%/configs/all %homedir%/AppData/Local/nvim %basegitdir_cyg%/configs --dry-run & echo. %NL%
    ::END neovim
ENDLOCAL