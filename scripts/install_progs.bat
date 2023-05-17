@echo on

set set_vars=%~dp0set_vars.bat
call %set_vars%
call:install_pkg_mgrs
goto:eof

:install_pkg_mgrs
    SETLOCAL
        :: Select PowerShell Version
        set pwsh=powershell
        where pwsh /q
        if ERRORLEVEL 0 (
            set pwsh=pwsh
        )

        :: Choco
        echo Installing Chocolatey | %boxes_bin% -d shell & echo.
        where chocolatey /q
        IF NOT ERRORLEVEL 0 (
            %pwsh% -c "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
        ) ELSE (
            echo Skipping Chocolatey is already installed%NL%%NL%
        )
        
        :: Scoop
        echo Installing scoop | %boxes_bin% -d shell & echo.
        where scoop /q
        IF NOT ERRORLEVEL 0 (
            %pwsh% -c "iex '& {$(irm get.scoop.sh)} -RunAsAdmin'"
        ) ELSE (
            echo Skipping, scoop is already installed%NL%%NL%
        )
    ENDLOCAL