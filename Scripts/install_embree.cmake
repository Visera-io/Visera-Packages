set(EMBREE_VERSION "4.3.3")
set(EMBREE_URL "https://github.com/RenderKit/embree/releases/download/v${EMBREE_VERSION}/embree-${EMBREE_VERSION}.x64.windows.zip")
set(EMBREE_CACHE_PATH "${VISERA_PACKAGES_CACHE_DIR}/Embree.zip")
set(EMBREE_INSTALL_PATH "${VISERA_PACKAGES_INSTALL_DIR}/Embree")

add_custom_target(Embree4)
target_sources(Embree4 PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_embree.cmake")
set_target_properties(Embree4 PROPERTIES FOLDER "Visera/Packages/Embree4")

# Check if installed
if (NOT EXISTS ${EMBREE_INSTALL_PATH})
    message(STATUS "Installing Embree${EMBREE_VERSION} (embree)...")
    # Check if exist cache
    if (NOT EXISTS ${EMBREE_CACHE_PATH})
        message(STATUS "Cache is not found and start downloading...")
        file(DOWNLOAD ${EMBREE_URL} ${EMBREE_CACHE_PATH} SHOW_PROGESS)
    endif()

    file(ARCHIVE_EXTRACT
        INPUT ${EMBREE_CACHE_PATH}
        DESTINATION ${EMBREE_INSTALL_PATH})
endif()

macro(link_embree _target)
    message(STATUS "Loading Embree${EMBREE_VERSION} (embree)...")

    set(embree_DIR "${EMBREE_INSTALL_PATH}/lib/cmake/embree-${EMBREE_VERSION}")
    find_package(embree REQUIRED)

    target_link_libraries(${_target} PUBLIC embree)

    add_custom_command(
        TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:embree>
        $<TARGET_FILE_DIR:${PROJECT_NAME}>
    )
endmacro()
