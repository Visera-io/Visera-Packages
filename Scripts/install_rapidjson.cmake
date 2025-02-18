message(STATUS "Installing RapidJSON (RapidJSON::volk_headers)...")

add_custom_target(RapidJSON)
target_sources(RapidJSON PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_rapidjson.cmake")
set_target_properties(RapidJSON PROPERTIES FOLDER "Visera/Packages/RapidJSON")

execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install rapidjson)

macro(link_rapidjson _target)
    message(STATUS "\nLoading Rapid JSON (rapidjson)")
    find_package(RapidJSON CONFIG REQUIRED)
    target_link_libraries(${PROJECT_NAME} PUBLIC rapidjson)
endmacro()