# https://cliutils.gitlab.io/modern-cmake/chapters/basics/example.html
# rm -rf CMakeFiles/ && rm *
# ---------------------------

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

list(APPEND CMAKE_PREFIX_PATH "/usr/lib/x86_64-linux-gnu/" "/usr/lib/x86_64-linux-gnu/cmake/" "/usr/lib/x86_64-linux-gnu/cmake/glfw3/")

### dpkg --listfiles libglfw3-dev
### https://stackoverflow.com/questions/67375163/cmake-find-package-find-library-can-locate-glfw-but-target-glfw-is-false
### https://cmake.org/cmake/help/book/mastering-cmake/chapter/Finding%20Packages.html
#find_package(VulkanLoader REQUIRED)
find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)
include_directories(${Vulkan_INCLUDE_DIRS})

# Adding something we can run - Output name matches target name
add_executable(VulkanWindowedProgram main.cpp)

# Make sure you link your targets with this command. It can also link libraries and
# even flags, so linking a target that does not exist will not give a configure-time error.
target_link_libraries(VulkanWindowedProgram ${Vulkan_LIBRARIES} glfw)

# Copy the shaders directory to the executable output directory
add_custom_command(TARGET VulkanWindowedProgram POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/shaders
    $<TARGET_FILE_DIR:VulkanWindowedProgram>/shaders
)
