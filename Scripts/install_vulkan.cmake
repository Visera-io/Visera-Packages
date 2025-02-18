set(VULKAN_REQUIRED_MINIMAL_VERSION "1.4.0")

add_custom_target(Vulkan)
target_sources(Vulkan PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_vulkan.cmake")
set_target_properties(Vulkan PROPERTIES FOLDER "Visera/Packages/Vulkan")

message(STATUS "Installing Vulkan(>=${VULKAN_REQUIRED_MINIMAL_VERSION}) (Vulkan)...")

if(NOT DEFINED ENV{VULKAN_SDK})
    message(FATAL_ERROR "Failed to find VulkanSDK on your system!")
else()
    # Extract the version from the path
    string(REGEX MATCH "[0-9]+\\.[0-9]+\\.[0-9]+" VULKAN_VERSION "$ENV{VULKAN_SDK}")
    message(STATUS "Found VulkanSDK ${VULKAN_VERSION} on current system.")
    if(VULKAN_VERSION)
        # Compare with required version (1.4.0)
        if(VULKAN_VERSION VERSION_LESS ${VULKAN_REQUIRED_MINIMAL_VERSION})
            message(FATAL_ERROR "VulkanSDK version is required: >=1.4.0, Found: ${VULKAN_VERSION}")
        endif()
    else()
        message(WARNING "Could not determine Vulkan SDK version.")
    endif()
endif()

macro(link_vulkan _target)
    message(STATUS "Loading Vulkan (Vulkan::Vulkan)")
    FIND_PACKAGE(Vulkan REQUIRED)
    target_link_libraries(${PROJECT_NAME} PUBLIC Vulkan::Vulkan)
endmacro()
