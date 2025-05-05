message(STATUS "Installing OpenEXR (OpenEXR)...")

add_custom_target(OpenEXR)
target_sources(OpenEXR PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_openexr.cmake")
set_target_properties(OpenEXR PROPERTIES FOLDER "Visera/Packages/OpenEXR")

execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install openexr)

macro(link_openexr _target)
    message(STATUS "\nLoading OpenEXR (OpenEXR::OpenEXR)")
    find_package(OpenEXR CONFIG REQUIRED)
    target_link_libraries(${_target} PUBLIC OpenEXR::OpenEXR)
endmacro()