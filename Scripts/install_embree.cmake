set(EMBREE_VERSION "4.3.3")
set(EMBREE_CACHE_PATH "${VISERA_PACKAGES_CACHE_DIR}")
set(EMBREE_INSTALL_PATH "${VISERA_PACKAGES_INSTALL_DIR}/Embree")

if(NOT TARGET Embree4)
    message(STATUS "Installing Embree${EMBREE_VERSION} (embree)...")
    
    add_custom_target(Embree4)
    target_sources(Embree4 PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_embree.cmake")
    set_target_properties(Embree4 PROPERTIES FOLDER "Visera/Packages/Embree4")

    # Check if installed
    if (NOT EXISTS "${EMBREE_INSTALL_PATH}/lib/cmake/embree-${EMBREE_VERSION}")
        # Check if exist cache
        if (WIN32)
            set(EMBREE_CACHE "${EMBREE_CACHE_PATH}/embree-${EMBREE_VERSION}.x64.windows.zip")
        elseif (APPLE) # MacOS
            set(EMBREE_CACHE "${EMBREE_CACHE_PATH}/embree-${EMBREE_VERSION}.arm64.macosx.zip")
        elseif (LINUX)
            set(EMBREE_CACHE "${EMBREE_CACHE_PATH}/embree-${EMBREE_VERSION}.x86_64.linux.tar.gz")
        else()
            message(FATAL_ERROR "Unsupported Platform!")
        endif()

        if (NOT DEFINED EMBREE_CACHE)
            message(FATAL_ERROR "Cache is not found and start downloading... (WIP)")
            #set(EMBREE_URL "https://github.com/RenderKit/embree/releases/download/v${EMBREE_VERSION}/embree-${EMBREE_VERSION}.x64.windows.zip")
            #file(DOWNLOAD ${EMBREE_URL} ${EMBREE_CACHE_PATH} SHOW_PROGESS)
        endif()

        message(STATUS "Found Embree${EMBREE_VERSION} Cache: ${EMBREE_CACHE}")
        file(ARCHIVE_EXTRACT
            INPUT ${EMBREE_CACHE}
            DESTINATION ${EMBREE_INSTALL_PATH})
    endif()
endif()

macro(link_embree _target)
    message(STATUS "Loading Embree${EMBREE_VERSION} (embree)...")

    set(embree_DIR "${EMBREE_INSTALL_PATH}/lib/cmake/embree-${EMBREE_VERSION}")
    find_package(embree REQUIRED)

    target_link_libraries(${_target} PUBLIC embree)

    add_custom_command(
        TARGET ${_target}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:embree>
        $<IF:$<CONFIG:Debug>,${VISERA_APP_DEBUG_DIR},${VISERA_APP_RELEASE_DIR}>
    )
endmacro()
