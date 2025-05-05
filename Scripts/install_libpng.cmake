message(STATUS "Installing RapidJSON (rapidjson)...")

add_custom_target(LibPNG)
target_sources(LibPNG PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_libpng.cmake")
set_target_properties(LibPNG PROPERTIES FOLDER "Visera/Packages/LibPNG")

execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install libpng)

macro(link_libpng _target)
    message(STATUS "\nLoading LibPNG (PNG::PNG)")
    find_package(PNG CONFIG REQUIRED)
    target_link_libraries(${_target} PUBLIC PNG::PNG)
endmacro()