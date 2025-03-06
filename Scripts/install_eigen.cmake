message(STATUS "Installing Eigen3 (Eigen3::Eigen)...")

add_custom_target(Eigen)
target_sources(Eigen PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_eigen.cmake")
set_target_properties(Eigen PROPERTIES FOLDER "Visera/Packages/Eigen")

execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install eigen3)

macro(link_eigen _target)
    message(STATUS "\nLoading Eigen3 (Eigen3::Eigen)")
    FIND_PACKAGE(Eigen3 REQUIRED)
    target_link_libraries(${_target} PUBLIC Eigen3::Eigen)
endmacro()