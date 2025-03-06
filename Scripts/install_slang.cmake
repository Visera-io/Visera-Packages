message(STATUS "Installing Slang (slang)...")

add_custom_target(Slang)
target_sources(Slang PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_slang.cmake")
set_target_properties(Slang PROPERTIES FOLDER "Visera/Packages/Slang")

#execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install Slang)

macro(link_slang _target)
    message(STATUS "\nLoading Slang (slang)")
    # Make sure that Version(VulkanSDK) >= "1.4.0"
    add_library(slang UNKNOWN IMPORTED)
    if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
        set_target_properties(slang
                PROPERTIES
                IMPORTED_LOCATION "$ENV{VULKAN_SDK}/Lib/slang.lib"
                INTERFACE_INCLUDE_DIRECTORIES "$ENV{VULKAN_SDK}/Include/slang")
        target_link_libraries(${_target} PUBLIC slang)

    elseif (CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin") # MacOS
        set_target_properties(slang
                PROPERTIES
                IMPORTED_LOCATION "$ENV{VULKAN_SDK}/lib/libslang.dylib"
                INTERFACE_INCLUDE_DIRECTORIES "$ENV{VULKAN_SDK}/include/slang")
        target_link_libraries(${_target} PUBLIC slang)

    #elseif (CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    else()
        message(FATAL_ERROR "Unsupported Platform!")
    endif()

endmacro()