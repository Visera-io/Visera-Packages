if(NOT TARGET GLFW)
    message(STATUS "Installing GLFW3 (glfw)...")

    add_custom_target(GLFW)
    target_sources(GLFW PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_glfw.cmake")
    set_target_properties(GLFW PROPERTIES FOLDER "Visera/Packages/GLFW3")

    execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install glfw3)
endif()

macro(link_glfw _target)
    message(STATUS "Loading GLFW3 (glfw)")
    find_package(glfw3 REQUIRED)

    target_link_libraries(${_target} PUBLIC glfw)
    add_custom_command(
        TARGET ${_target}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:glfw>
        $<IF:$<CONFIG:Debug>,${VISERA_APP_DEBUG_DIR},${VISERA_APP_RELEASE_DIR}>
    )
endmacro()