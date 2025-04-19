set(STB_VERSION "2025.4.19")
message(STATUS "Installing STB(${STB_VERSION} [image]) (STB)...")

set(VISERA_PACKAGES_STB_SOURCE_DIR "${VISERA_PACKAGES_SOURCE_DIR}/STB")
file(GLOB_RECURSE VISERA_PACKAGES_STB_SOURCE_FILES "${VISERA_PACKAGES_STB_SOURCE_DIR}/*")
add_custom_target(STB)

target_sources(STB PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_stb.cmake")
set_target_properties(STB PROPERTIES FOLDER "Visera/Packages/STB")

macro(link_stb _target)
    message(STATUS "Loading STB (STB)")
    target_include_directories(${_target} PUBLIC ${VISERA_PACKAGES_STB_SOURCE_DIR})
endmacro()