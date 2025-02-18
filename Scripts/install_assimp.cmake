message(STATUS "Installing Assimp (volk::volk_headers)...")

add_custom_target(Assimp)
target_sources(Assimp PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_assimp.cmake")
set_target_properties(Assimp PROPERTIES FOLDER "Visera/Packages/Assimp")

execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install assimp)

macro(link_assimp _target)
    message(STATUS "\nLoading Assimp (assimp)")
    find_package(assimp CONFIG REQUIRED)
    target_link_libraries(${PROJECT_NAME} PUBLIC assimp::assimp)
    add_custom_command(
        TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:assimp::assimp>
        $<TARGET_FILE_DIR:${PROJECT_NAME}>
    )
endmacro()