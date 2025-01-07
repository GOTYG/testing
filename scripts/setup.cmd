@echo off
setlocal

for /f "delims=" %%i in ('git rev-parse --show-toplevel') do set ROOT=%%i
set ROOT=%ROOT:/=\%
set GODOT_VERSION=4.3-stable
set GDUNIT_VERSION=4.5.0
set GODOT_BIN=%ROOT%\.bin\godot.cmd

set dir=%TEMP%\godot
mkdir %dir%
set zip=%dir%\godot.zip

curl -o "%zip%" -L "https://github.com/godotengine/godot/releases/download/%GODOT_VERSION%/Godot_v%GODOT_VERSION%_mono_win64.zip"
powershell -command "Expand-Archive -Path '%zip%' -DestinationPath '%ROOT%\.bin\'"
(
    echo @echo off
    echo start /D %ROOT%\.bin %ROOT%\.bin\Godot_v%GODOT_VERSION%_mono_win64\Godot_v%GODOT_VERSION%_mono_win64.exe
) > "%ROOT%\.bin\godot.cmd"

set zip=%dir%\gdunit.zip
curl -o "%zip%" -L https://github.com/MikeSchulze/gdUnit4/archive/refs/tags/v%GDUNIT_VERSION%.zip
powershell -command "Expand-Archive -Path '%zip%' -DestinationPath '%dir%/gdunit'"
mkdir %ROOT%\addons
move %dir%\gdunit\gdUnit4-%GDUNIT_VERSION%\addons\gdUnit4 %ROOT%\addons\gdUnit4

@REM Generates test adapter
dotnet test

endlocal
