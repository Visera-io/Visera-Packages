set(IMGUI_VERSION "1.91.8")
message(STATUS "Installing Dear ImGui(${IMGUI_VERSION} [volk,glfw]) (ImGui)...")

set(VISERA_PACKAGE_IMGUI_SOURCE_DIR "${VISERA_PACKAGE_SOURCE_DIR}/ImGui")
file(GLOB_RECURSE VISERA_PACKAGE_IMGUI_SOURCE_FILES "${VISERA_PACKAGE_IMGUI_SOURCE_DIR}/*")
add_library(ImGui STATIC ${VISERA_PACKAGE_IMGUI_SOURCE_FILES})

set_target_properties(ImGui PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${VISERA_PACKAGE_INSTALL_DIR}/ImGui"
    ARCHIVE_OUTPUT_DIRECTORY "${VISERA_PACKAGE_INSTALL_DIR}/ImGui"
    LIBRARY_OUTPUT_DIRECTORY "${VISERA_PACKAGE_INSTALL_DIR}/ImGui"
)
target_compile_definitions(
    ImGui PRIVATE 
    IMGUI_IMPL_VULKAN_USE_VOLK
    IMGUI_IMPL_VULKAN_NO_PROTOTYPES)

target_link_libraries(ImGui PRIVATE volk::volk_headers glfw)
target_sources(GLFW PRIVATE "${VISERA_PACKAGE_SCRIPTS_DIR}/install_imgui.cmake")
set_target_properties(ImGui PROPERTIES FOLDER "Visera/Packages/ImGui")

macro(link_ImGui _target)
    message(STATUS "Loading Dear ImGui (ImGui)")
    target_link_libraries(${PROJECT_NAME} PUBLIC ImGui)
    target_include_directories(${PROJECT_NAME} PUBLIC ${VISERA_PACKAGE_IMGUI_SOURCE_DIR})
endmacro()