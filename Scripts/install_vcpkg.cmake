if(NOT TARGET Vcpkg)
    message(STATUS "Installing Vcpkg...")

    add_custom_target(Vcpkg)
    target_sources(Vcpkg PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_vcpkg.cmake")
    set_target_properties(Vcpkg PROPERTIES FOLDER "Visera/Packages/Vcpkg")
endif()

if (WIN32)
    set(VISERA_PACKAGES_VCPKG_EXE "${VISERA_PACKAGES_VCPKG_DIR}/vcpkg.exe" CACHE PATH "")
    if (NOT EXISTS "${VISERA_PACKAGES_VCPKG_EXE}")
        execute_process(
            COMMAND bootstrap-vcpkg.bat
            WORKING_DIRECTORY ${VISERA_PACKAGES_VCPKG_DIR}
        )
    endif ()
elseif (CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" OR CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
    set(VISERA_PACKAGES_VCPKG_EXE "${VISERA_PACKAGES_VCPKG_DIR}/vcpkg" CACHE PATH "")
    if (NOT EXISTS "${VISERA_PACKAGES_VCPKG_EXE}")
        execute_process(
            COMMAND bootstrap-vcpkg.sh
            WORKING_DIRECTORY ${VISERA_PACKAGES_VCPKG_DIR}
        )
    endif()
else()
    message(FATAL_ERROR "Unknown platform \"${CMAKE_HOST_SYSTEM_NAME}\", script cannot be executed.")
endif()