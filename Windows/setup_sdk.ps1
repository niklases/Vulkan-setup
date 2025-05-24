
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest https://sdk.lunarg.com/sdk/download/1.4.309.0/windows/VulkanSDK-1.4.309.0-Installer.exe -OutFile ( New-Item -Path "C:\SDKs\Vulkan\VulkanSDK-1.4.309.0-Installer.exe" -Force )

C:\SDKs\Vulkan\VulkanSDK-1.4.309.0-Installer.exe --accept-licenses --default-answer --confirm-command install

# vulkaninfoSDK
# vkcube

# Copy Templates from
#    C:\VulkanSDK\1.4.309.0\Templates\Visual Studio 2022
# to
#    C:\Users\nikla\Documents\Visual Studio 2022\Templates\ProjectTemplates\.
# so, e.g.:
#    C:\VulkanSDK\1.4.309.0\Templates\Visual Studio 2022\VulkanCppProgram.zip 
# No extraction needed
