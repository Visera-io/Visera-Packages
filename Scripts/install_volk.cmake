message(STATUS "Installing Volk (volk::volk_headers)...")

add_custom_target(Volk)
target_sources(Volk PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_volk.cmake")
set_target_properties(Volk PROPERTIES FOLDER "Visera/Packages/Volk")

execute_process(COMMAND ${VISERA_PACKAGES_Volk_EXE} install volk)

macro(link_volk _target)
    message(STATUS "Loading Volk (volk::volk_headers)")
    FIND_PACKAGE(volk CONFIG REQUIRED)
    target_link_libraries(${PROJECT_NAME} PUBLIC volk::volk_headers)
endmacro()