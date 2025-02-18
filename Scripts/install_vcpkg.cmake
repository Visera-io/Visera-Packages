add_custom_target(Vcpkg)
target_sources(Vcpkg PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_vcpkg.cmake")
set_target_properties(Vcpkg PROPERTIES FOLDER "Visera/Packages/Vcpkg")

if (NOT DEFINED VISERA_PACKAGES_VCPKG_EXE)
    message(STATUS "Installing Vcpkg...")

    execute_process(
        COMMAND git submodule update --init --recursive
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    )
    execute_process(
        COMMAND git pull --recurse-submodules
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
    )

    if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
        set(VISERA_PACKAGES_VCPKG_EXE "${VISERA_PACKAGES_VCPKG_DIR}/vcpkg.exe" CACHE PATH "")
        execute_process(
            COMMAND bootstrap-vcpkg.bat
            WORKING_DIRECTORY ${VISERA_PACKAGES_VCPKG_DIR}
        )
    elseif (CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" OR CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
        set(VISERA_PACKAGES_VCPKG_EXE "${VISERA_PACKAGES_VCPKG_DIR}/vcpkg" CACHE PATH "")
        execute_process(
            COMMAND bootstrap-vcpkg.sh
            WORKING_DIRECTORY ${VISERA_PACKAGES_VCPKG_DIR}
        )
    else()
        message(FATAL_ERROR "Unknown platform \"${CMAKE_HOST_SYSTEM_NAME}\", script cannot be executed.")
    endif()
else()
    message(NOTICE "Vcpkg has been installed but may not up to date.")
endif()