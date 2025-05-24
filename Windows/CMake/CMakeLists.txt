cmake_minimum_required(VERSION 3.10)
project(MyVulkanProject)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Use the Vulkan SDK environment variable
if(WIN32)
    if(DEFINED ENV{VULKAN_SDK})
        set(VULKAN_SDK_PATH $ENV{VULKAN_SDK})
    else()
        message(FATAL_ERROR "VULKAN_SDK environment variable is not set.")
    endif()
endif()

# Include directories
include_directories(
    ${VULKAN_SDK_PATH}/Include
    ${CMAKE_SOURCE_DIR}/Dependencies/GLFW/include
)

# Link directories
link_directories(
    ${VULKAN_SDK_PATH}/Lib
    ${CMAKE_SOURCE_DIR}/Dependencies/GLFW/lib-vc2022
)

# Add your source files
add_executable(MyVulkanApp main.cpp)

# Link against Vulkan and GLFW
target_link_libraries(MyVulkanApp vulkan-1 glfw3)

# Copy the shaders directory to the executable output directory
add_custom_command(TARGET MyVulkanApp POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/shaders
    $<TARGET_FILE_DIR:MyVulkanApp>/shaders
)