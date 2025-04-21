set(TBB_VERSION "2022.0.0")

if(NOT TARGET OneTBB)
    message(STATUS "Installing OneTBB(${TBB_VERSION} (TBB)...")

    add_custom_target(OneTBB)
    target_sources(OneTBB PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_tbb.cmake")
    set_target_properties(OneTBB PROPERTIES FOLDER "Visera/Packages/TBB")

    execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install tbb)
endif()

macro(link_tbb _target)
    message(STATUS "Loading Intel OneTBB${TBB_VERSION} (TBB::tbb)...")

    find_package(TBB REQUIRED)

    target_link_libraries(${_target}
        PUBLIC
        TBB::tbb
        TBB::tbbmalloc)
    
    add_custom_command(
        TARGET ${_target}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:TBB::tbb>
        $<IF:$<CONFIG:Debug>,${VISERA_APP_DEBUG_DIR},${VISERA_APP_RELEASE_DIR}>
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:TBB::tbbmalloc>
        $<IF:$<CONFIG:Debug>,${VISERA_APP_DEBUG_DIR},${VISERA_APP_RELEASE_DIR}>
    )
endmacro()
