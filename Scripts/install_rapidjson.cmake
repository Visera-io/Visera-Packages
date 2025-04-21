set(RAPIDJSON_VERSION "1.10")

if(NOT TARGET RapidJSON)
    message(STATUS "Installing RapidJSON(${RAPIDJSON_VERSION}) (rapidjson)...")

    set(VISERA_PACKAGES_RAPIDJSON_SOURCE_DIR "${VISERA_PACKAGES_SOURCE_DIR}/RapidJSON")
    file(GLOB_RECURSE VISERA_PACKAGES_RAPIDJSON_SOURCE_FILES "${VISERA_PACKAGES_RAPIDJSON_SOURCE_DIR}/*")
    
    add_custom_target(RapidJSON)
    target_sources(RapidJSON PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_rapidjson.cmake")
    set_target_properties(RapidJSON PROPERTIES FOLDER "Visera/Packages/RapidJSON")
endif()

macro(link_rapidjson _target)
    message(STATUS "\nLoading Rapid JSON (rapidjson)")
    target_include_directories(${_target} PUBLIC ${VISERA_PACKAGES_RAPIDJSON_SOURCE_DIR})
endmacro()