# https://cliutils.gitlab.io/modern-cmake/chapters/basics/example.html
# rm -rf CMakeFiles/ && rm *
# ---------------------------

# Almost all CMake files should start with this
# You should always specify a range with the newest
# and oldest tested versions of CMake. This will ensure
# you pick up the best policies.
cmake_minimum_required(VERSION 3.15...4.0)

# This is your project statement. You should always list languages;
# Listing the version is nice here since it sets lots of useful variables
project(
  ModernCMakeExample
  VERSION 1.0
  LANGUAGES CXX)

# If you set any CMAKE_ variables, that can go here.
# (But usually don't do this, except maybe for C++ standard)
set (CMAKE_CXX_STANDARD 17)

list(APPEND CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu/" "/usr/lib/x86_64-linux-gnu/cmake/" "/usr/lib/x86_64-linux-gnu/cmake/glfw3/")# "/home/niklas/vulkan/1.4.309.0/x86_64/lib/cmake/VulkanLoader/")
# Find packages go here.
### dpkg --listfiles libglfw3-dev
### https://stackoverflow.com/questions/67375163/cmake-find-package-find-library-can-locate-glfw-but-target-glfw-is-false
### https://cmake.org/cmake/help/book/mastering-cmake/chapter/Finding%20Packages.html
#find_package(VulkanLoader REQUIRED)
find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)


# You should usually split this into folders, but this is a simple example

# This is a "default" library, and will match the *** variable setting.
# Other common choices are STATIC, SHARED, and MODULE
# Including header files here helps IDEs but is not required.
# Output libname matches target name, with the usual extensions on your system
#add_library(MyLibExample simple_lib.cpp simple_lib.hpp)

# Link each target with other targets or add options, etc.

# Adding something we can run - Output name matches target name
add_executable(MyExample main.cpp)

# Make sure you link your targets with this command. It can also link libraries and
# even flags, so linking a target that does not exist will not give a configure-time error.
target_link_libraries(MyExample vulkan glfw)
