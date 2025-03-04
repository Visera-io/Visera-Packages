set(TBB_VERSION "2022.0.0")
set(TBB_CACHE_PATH   "${VISERA_PACKAGES_CACHE_DIR}")
set(TBB_INSTALL_PATH "${VISERA_PACKAGES_INSTALL_DIR}/TBB")

add_custom_target(TBB)
target_sources(TBB PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_tbb.cmake")
set_target_properties(TBB PROPERTIES FOLDER "Visera/Packages/TBB")

# Check if installed
if (NOT EXISTS "${TBB_INSTALL_PATH}/oneapi-tbb-${TBB_VERSION}/lib/cmake/tbb")
    message(STATUS "Installing TBB${TBB_VERSION} (TBB)...")
    # Check if exist cache
    if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
        set(TBB_CACHE "${TBB_CACHE_PATH}/oneapi-tbb-${TBB_VERSION}-win.zip")
    elseif (CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin") # MacOS
        set(TBB_CACHE "${TBB_CACHE_PATH}/oneapi-tbb-${TBB_VERSION}-mac.tgz")
    elseif (CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
        set(TBB_CACHE "${TBB_CACHE_PATH}/oneapi-tbb-${TBB_VERSION}-lin.tgz")
    else()
        message(FATAL_ERROR "Unsupported Platform!")
    endif()

    if (NOT DEFINED TBB_CACHE)
        message(FATAL_ERROR "Cache is not found and start downloading... (WIP)")
        #set(TBB_URL "https://github.com/uxlfoundation/oneTBB/releases/download/v${TBB_VERSION}/oneapi-tbb-${TBB_VERSION}-win.zip")
        #file(DOWNLOAD ${TBB_URL} ${TBB_CACHE_PATH} SHOW_PROGRESS)
    endif()

    message(STATUS "Found TBB${TBB_VERSION} Cache: ${TBB_CACHE}")
    file(ARCHIVE_EXTRACT
        INPUT ${TBB_CACHE}
        DESTINATION ${TBB_INSTALL_PATH})
endif()

macro(link_tbb _target)
    message(STATUS "Loading TBB${TBB_VERSION} (TBB)...")

    set(TBB_DIR "${TBB_INSTALL_PATH}/oneapi-tbb-${TBB_VERSION}/lib/cmake/tbb")
    find_package(TBB REQUIRED)

    target_link_libraries(${_target}
        INTERFACE
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
        COMMAND ${CMAKE_COMMAND} -E rename
        $<TARGET_FILE_DIR:${VISERA_APP}>/$<TARGET_FILE_NAME:TBB::tbb>
        $<TARGET_FILE_DIR:${VISERA_APP}>/tbb12.dll
    )
endmacro()
