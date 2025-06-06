if(NOT TARGET Spdlog)
    message(STATUS "Installing Spdlog (spdlog::spdlog)...")

    add_custom_target(Spdlog)
    target_sources(Spdlog PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_spdlog.cmake")
    set_target_properties(Spdlog PROPERTIES FOLDER "Visera/Packages/Spdlog")

    execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install spdlog)
endif()

macro(link_spdlog _target)
    message(STATUS "Loading Spdlog (spdlog::spdlog)")
    FIND_PACKAGE(spdlog REQUIRED)
    target_link_libraries(${_target} PUBLIC spdlog::spdlog)
    add_custom_command(
        TARGET ${_target}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:spdlog::spdlog>
        $<IF:$<CONFIG:Debug>,${VISERA_APP_DEBUG_DIR},${VISERA_APP_RELEASE_DIR}>
    )
    add_custom_command(
        TARGET ${_target}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:fmt::fmt>
        $<IF:$<CONFIG:Debug>,${VISERA_APP_DEBUG_DIR},${VISERA_APP_RELEASE_DIR}>
    )
endmacro()