@echo off
setlocal

for /f "delims=" %%i in ('git rev-parse --show-toplevel') do set ROOT=%%i
@rem Replace forward with backward slashes in ROOT
set ROOT=%ROOT:/=\%
set GODOT_VERSION=4.3-stable

set dir=%TEMP%\godot
mkdir %dir%
set zip=%dir%\godot.zip

curl -o "%zip%" -L "https://github.com/godotengine/godot/releases/download/%GODOT_VERSION%/Godot_v%GODOT_VERSION%_mono_win64.zip"
powershell -command "Expand-Archive -Path '%zip%' -DestinationPath '%ROOT%\.bin\'"
(
    echo @echo off
    echo start /D %ROOT%\.bin %ROOT%\.bin\Godot_v%GODOT_VERSION%_mono_win64\Godot_v%GODOT_VERSION%_mono_win64.exe
) > "%ROOT%\.bin\godot.cmd"

endlocal
