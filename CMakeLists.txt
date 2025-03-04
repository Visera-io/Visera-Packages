cmake_minimum_required(VERSION 3.21.0 FATAL_ERROR)

set(VISERA_PACKAGES "Visera-Packages")

project(${VISERA_PACKAGES}
    HOMEPAGE_URL    "www.visera.io"
    LANGUAGES       CXX
)

option(bUpdateVcpkg     "Automatically update Vcpkg"        ON)
option(bCleanCache      "Clean cache after installation"    OFF)

set(VISERA_PACKAGES_ROOT_DIR     "${PROJECT_SOURCE_DIR}"               CACHE STRING "")
set(VISERA_PACKAGES_CACHE_DIR    "${VISERA_PACKAGES_ROOT_DIR}/Cache"   CACHE STRING "")
set(VISERA_PACKAGES_VCPKG_DIR    "${VISERA_PACKAGES_ROOT_DIR}/Vcpkg"   CACHE STRING "")
set(VISERA_PACKAGES_SCRIPTS_DIR  "${VISERA_PACKAGES_ROOT_DIR}/Scripts" CACHE STRING "")
set(VISERA_PACKAGES_INSTALL_DIR  "${VISERA_PACKAGES_ROOT_DIR}/Install" CACHE STRING "")
set(VISERA_PACKAGES_SOURCE_DIR   "${VISERA_PACKAGES_ROOT_DIR}/Source"  CACHE STRING "")

list(APPEND CMAKE_MODULE_PATH "${VISERA_PACKAGES_SCRIPTS_DIR}")
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" PARENT_SCOPE)

#add_custom_target(${VISERA_PACKAGES} ALL)

if(${bUpdateVcpkg})
    include(install_vcpkg)
else()
    message(FATAL_ERROR "WIP")
endif()

if (${bCleanCache})
    message(STATUS "\nVisera Packages is cleaning cache...")
    file(REMOVE_RECURSE ${VISERA_PACKAGES_CACHE_DIR})
endif()