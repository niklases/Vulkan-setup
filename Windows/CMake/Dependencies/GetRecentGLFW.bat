@echo off
:: Ensure the script stops if any command fails
setlocal enabledelayedexpansion
set "GLFW_DIR=GLFW"

:: Check if git is installed
git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Git is not installed. Please install Git first.
    exit /b 1
)

:: Check if cmake is installed
cmake --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo CMake is not installed. Please install CMake first.
    exit /b 1
)

:: Clone the latest GLFW repository
if not exist "%GLFW_DIR%" (
    echo Cloning the latest GLFW source code from GitHub...
    git clone --branch master --single-branch https://github.com/glfw/glfw.git %GLFW_DIR%
) else (
    echo GLFW directory already exists. Pulling the latest updates...
    pushd %GLFW_DIR%
    git pull origin master
    popd
)

:: Create a build directory for the compilation
set "BUILD_DIR=%CD%\build"
if exist "%BUILD_DIR%" (
    rmdir /s /q "%BUILD_DIR%"
)

mkdir "%BUILD_DIR%"

:: Navigate to the build directory and run CMake
cd "%BUILD_DIR%"
echo Running CMake to configure the project...
cmake -G "Visual Studio 17 2022" -DGLFW_BUILD_SHARED=OFF -DGLFW_BUILD_STATIC=ON -DCMAKE_BUILD_TYPE=Release ..\%GLFW_DIR%

:: Check if CMake configuration failed
if %ERRORLEVEL% neq 0 (
    echo ERROR: CMake configuration failed. Please check the output above.
    pause
    exit /b 1
)

:: Build the project using CMake
echo Building the project...
cmake --build . --config Release

:: Check if the build failed
if %ERRORLEVEL% neq 0 (
    echo ERROR: Build failed. Please check the output above.
    pause
    exit /b 1
)

chdir ..

:: Verify the existence of the .lib file
set "LIB_FILE=%BUILD_DIR%\src\Release\glfw3.lib"
if exist "%LIB_FILE%" (
    echo GLFW static library built successfully. The .lib file can be found at:
    echo %LIB_FILE%

    :: Copy the .lib file to the specified directory
    echo "DEST DIR: %CD%\GLFW\lib-vc2022\"
    if not exist "%CD%\GLFW\lib-vc2022\" (
        mkdir "%CD%\GLFW\lib-vc2022\"
    )
    copy "%LIB_FILE%" "%CD%\GLFW\lib-vc2022\." >nul
    echo Copied %LIB_FILE% to %CD%\GLFW\lib-vc2022\glfw3.lib
) else (
    echo ERROR: The .lib file was not found at the expected location.
    echo Expected location: %LIB_FILE%
    pause
    exit /b 1
)


echo GLFW build complete!
pause
