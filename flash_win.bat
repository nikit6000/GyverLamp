@echo off

set CHECK_CMD=arduino-cli.exe
set CHECK_DESC=ArduinoCLI
call :check_installed


set SOURCE_PATH=%~dp0
set BUILD_PATH=%SOURCE_PATH:~0,-1%
set BIN_PATH=%BUILD_PATH%\bin
set CONFIG_PATH=%BUILD_PATH%\config

if not exist "%CONFIG_PATH%" (
	mkdir "%CONFIG_PATH%"
	if errorlevel 1 popd & goto exit_failure
)

if not exist "%BIN_PATH%" (
	mkdir "%BIN_PATH%"
	if errorlevel 1 popd & goto exit_failure
)

if [%1]==[] (
	call :exit_failure
)

set BUILD_FQBN=%1

arduino-cli config init --dest-dir "%CONFIG_PATH%" --additional-urls https://arduino.esp8266.com/stable/package_esp8266com_index.json 

rename "%CONFIG_PATH%\arduino-cli.yaml" "arduino-cli-old.yaml"

(for /f "tokens=1* delims=:" %%a in (%CONFIG_PATH%\arduino-cli-old.yaml) do (
 if "%%b"=="" (echo %%a:) else (
  echo %%a|find " user" >nul && echo %%a: %BUILD_PATH% || echo %%a:%%b
 )
)) > "%CONFIG_PATH%\arduino-cli.yaml"


 arduino-cli core update-index --config-file "%CONFIG_PATH%\arduino-cli.yaml"

arduino-cli core download esp8266:esp8266@2.7.1 --config-file "%CONFIG_PATH%\arduino-cli.yaml"
arduino-cli core install esp8266:esp8266@2.7.1 --config-file "%CONFIG_PATH%\arduino-cli.yaml"

echo.
echo.
echo Available COM ports:

arduino-cli board list --config-file "%CONFIG_PATH%\arduino-cli.yaml"

set /p COM_PORT="Select port: "

echo.
echo Building for FQBN %BUILD_FQBN%
echo Port - %COM_PORT%

arduino-cli compile -b %BUILD_FQBN% "%BUILD_PATH%\firmware\GyverLamp_v1.5.5\GyverLamp_v1_5_5.ino" -o "%BIN_PATH%\firmware" -p %COM_PORT% -u -t --config-file "%CONFIG_PATH%\arduino-cli.yaml"

:check_installed
where %CHECK_CMD% > nul 2>&1
if "%errorlevel%"=="9009" (
  echo This build script requires where.exe. If running on Windows XP or
  echo earlier, this can be found in the Windows Resource Kit.
  exit /b 1
)
if errorlevel 1 (
  echo Please make sure that %CHECK_DESC% is installed and in your PATH.
  exit /b 1
)
goto :EOF

:exit_failure
echo Build failed.
cd %SOURCE_PATH%
exit /b 1
