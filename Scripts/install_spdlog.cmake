set(RAPIDJSON_VERSION "1.15.2")
set(VISERA_PACKAGES_SPDLOG_SOURCE_DIR "${VISERA_PACKAGES_SOURCE_DIR}/Spdlog")

if(NOT TARGET Spdlog)
    message(STATUS "Installing Spdlog (spdlog::spdlog)...")

    add_custom_target(Spdlog)
    target_sources(Spdlog PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_spdlog.cmake")
    set_target_properties(Spdlog PROPERTIES FOLDER "Visera/Packages/Spdlog")
endif()

macro(link_spdlog _target)
    message(STATUS "Loading Spdlog (spdlog::spdlog)")
    target_include_directories(${_target} PUBLIC ${VISERA_PACKAGES_SPDLOG_SOURCE_DIR})
endmacro()