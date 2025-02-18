cmake_minimum_required(VERSION 3.21.0 FATAL_ERROR)
set(VISERA_PACKAGE_CACHE_DIR    "${CMAKE_SOURCE_DIR}/.Cache")
set(VISERA_PACKAGE_VCPKG_DIR    "${CMAKE_SOURCE_DIR}/Vcpkg")
set(VISERA_PACKAGE_SCRIPTS_DIR  "${CMAKE_SOURCE_DIR}/Scripts")
set(VISERA_PACKAGE_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/Install")
set(VISERA_PACKAGE_SOURCE_DIR   "${CMAKE_SOURCE_DIR}/Source")

set(CMAKE_TOOLCHAIN_FILE "${VISERA_PACKAGE_VCPKG_DIR}/scripts/buildsystems/vcpkg.cmake")

#<< Install/Download Packages >>
list(APPEND CMAKE_MODULE_PATH "${VISERA_PACKAGE_SCRIPTS_DIR}")
include(install_all)

project("Visera-EXT"
    HOMEPAGE_URL    "www.visera.io"
)

option(bCleanCache "Clean cache after installation" ON)

add_executable(${PROJECT_NAME} "Test/Main.cpp")
link_all(${PROJECT_NAME})

#<< Post Processes >>
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_target_properties(${PROJECT_NAME} PROPERTIES FOLDER "Visera/Packages")

if (${bCleanCache})
    message(STATUS "\nVisera EXT is cleaning cache...")
    file(REMOVE_RECURSE ${VISERA_PACKAGE_CACHE_DIR})
endif()