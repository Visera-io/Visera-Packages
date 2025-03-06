message(STATUS "Installing FreeImage (FreeImage::FreeImage)...")

add_custom_target(FreeImage)
target_sources(FreeImage PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_freeimage.cmake")
set_target_properties(FreeImage PROPERTIES FOLDER "Visera/Packages/FreeImage")

execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install freeimage)

macro(link_freeimage _target)
    message(STATUS "Loading FreeImage (freeimage::FreeImage)")
    find_package(freeimage CONFIG REQUIRED)
    target_link_libraries(${_target} PUBLIC
            freeimage::FreeImage
            freeimage::FreeImagePlus)
    add_custom_command(
        TARGET ${_target}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:freeimage::FreeImage>
        $<TARGET_FILE_DIR:${VISERA_APP}>
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:freeimage::FreeImagePlus>
        $<TARGET_FILE_DIR:${VISERA_APP}>
    )
endmacro()