message(STATUS "Installing Volk (volk::volk)...")

add_custom_target(Volk)
target_sources(Volk PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_volk.cmake")
set_target_properties(Volk PROPERTIES FOLDER "Visera/Packages/Volk")

execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install volk)

macro(link_volk _target)
    message(STATUS "Loading Volk (volk::volk)")
    FIND_PACKAGE(volk CONFIG REQUIRED)
    target_link_libraries(${_target} PUBLIC volk::volk volk::volk_headers)
endmacro()