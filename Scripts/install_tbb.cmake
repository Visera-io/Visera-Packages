set(TBB_VERSION "2022.0.0")

add_custom_target(OneTBB)
target_sources(OneTBB PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_tbb.cmake")
set_target_properties(OneTBB PROPERTIES FOLDER "Visera/Packages/TBB")

execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install tbb)

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
        $<TARGET_FILE_DIR:${VISERA_APP}>
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:TBB::tbbmalloc>
        $<TARGET_FILE_DIR:${VISERA_APP}>
        #"tbb12_debug.dll" conflicts with embree's dependency name "tbb12.dll"
        #COMMAND ${CMAKE_COMMAND} -E rename
        #$<TARGET_FILE_DIR:${VISERA_APP}>/$<TARGET_FILE_NAME:TBB::tbb>
        #$<TARGET_FILE_DIR:${VISERA_APP}>/tbb12.dll
    )
endmacro()
