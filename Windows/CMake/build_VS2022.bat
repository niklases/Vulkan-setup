@echo off
REM Remove the build directory recursively and quietly
rmdir /s /q build

REM Create build directory and enter it
mkdir build
cd build

REM Generate VS 2022 solution targeting x64
cmake -G "Visual Studio 17 2022" -A x64 ..

REM Build the solution in Release configuration
cmake --build . --config Debug

REM Define executable path
set EXE_PATH=%cd%\Debug\MyVulkanApp.exe

REM Echo the executable path
echo Executable path: %EXE_PATH%

REM Run the executable
"%EXE_PATH%"

REM Pause to see output after execution
pause
