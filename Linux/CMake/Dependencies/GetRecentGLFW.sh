#!/bin/bash

# Ensure the script stops if any command fails
set -e

GLFW_DIR="GLFW"

# Check if git is installed
if ! git --version >/dev/null 2>&1; then
    echo "Git is not installed. Please install Git first."
    exit 1
fi

# Check if cmake is installed
if ! cmake --version >/dev/null 2>&1; then
    echo "CMake is not installed. Please install CMake first."
    exit 1
fi

# Install required dependencies
echo "Installing required dependencies..."
sudo apt-get update
sudo apt-get install -y git cmake build-essential libwayland-dev wayland-protocols \
    extra-cmake-modules pkg-config libxrandr-dev libxkbcommon-dev libxinerama-dev \
    libxcursor-dev libxi-dev

# Clone the latest GLFW repository
if [ ! -d "$GLFW_DIR" ]; then
    echo "Cloning the latest GLFW source code from GitHub..."
    git clone --branch master --single-branch https://github.com/glfw/glfw.git "$GLFW_DIR"
else
    echo "GLFW directory already exists. Pulling the latest updates..."
    (cd "$GLFW_DIR" && git pull origin master)
fi

# Create a build directory for the compilation
BUILD_DIR="$(pwd)/build"
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR"
fi

mkdir -p "$BUILD_DIR"

# Navigate to the build directory and run CMake
cd "$BUILD_DIR"
echo "Running CMake to configure the project..."
cmake -G "Unix Makefiles" -DGLFW_BUILD_SHARED=OFF -DGLFW_BUILD_STATIC=ON -DCMAKE_BUILD_TYPE=Release ../"$GLFW_DIR"

# Build the project using CMake
echo "Building the project..."
cmake --build . --config Release

# Install GLFW to the default system location (/usr/local)
echo "Installing GLFW..."
sudo cmake --install .

echo "GLFW has been successfully built and installed."
