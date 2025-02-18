set(TBB_VERSION "2022.0.0")
set(TBB_URL "https://github.com/uxlfoundation/oneTBB/releases/download/v${TBB_VERSION}/oneapi-tbb-${TBB_VERSION}-win.zip")
set(TBB_CACHE_PATH "${VISERA_PACKAGES_CACHE_DIR}/TBB.zip")
set(TBB_INSTALL_PATH "${VISERA_PACKAGES_INSTALL_DIR}/TBB")

add_custom_target(TBB)
target_sources(TBB PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_tbb.cmake")
set_target_properties(TBB PROPERTIES FOLDER "Visera/Packages/TBB")

# Check if installed
if (NOT EXISTS ${TBB_INSTALL_PATH})
    message(STATUS "Installing TBB${TBB_VERSION} (TBB)...")
    # Check if exist cache
    if (NOT EXISTS ${TBB_CACHE_PATH})
        message(STATUS "Cache is not found and start downloading...")
        file(DOWNLOAD ${TBB_URL} ${TBB_CACHE_PATH} SHOW_PROGESS)
    endif()

    file(ARCHIVE_EXTRACT
        INPUT ${TBB_CACHE_PATH}
        DESTINATION ${TBB_INSTALL_PATH})
endif()

macro(link_tbb _target)
    message(STATUS "Loading TBB${TBB_VERSION} (TBB)...")

    set(TBB_DIR "${TBB_INSTALL_PATH}/oneapi-tbb-${TBB_VERSION}/lib/cmake/tbb")
    find_package(TBB REQUIRED)

    target_link_libraries(${PROJECT_NAME} PUBLIC TBB::tbb)
    target_link_libraries(${PROJECT_NAME} PUBLIC TBB::tbbmalloc)
    
    add_custom_command(
        TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:TBB::tbb>
        $<TARGET_FILE_DIR:${PROJECT_NAME}>
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:TBB::tbbmalloc>
        $<TARGET_FILE_DIR:${PROJECT_NAME}>
        #"tbb12_debug.dll" conflicts with embree's dependency name "tbb12.dll"
        COMMAND ${CMAKE_COMMAND} -E rename
        $<TARGET_FILE_DIR:${PROJECT_NAME}>/$<TARGET_FILE_NAME:TBB::tbb>
        $<TARGET_FILE_DIR:${PROJECT_NAME}>/tbb12.dll
    )
endmacro()
