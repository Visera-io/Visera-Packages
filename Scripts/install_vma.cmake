if(NOT TARGET VMA)
    message(STATUS "Installing VMA (GPUOpen::VulkanMemoryAllocator)...")

    add_custom_target(VMA)
    target_sources(VMA PRIVATE "${VISERA_PACKAGES_SCRIPTS_DIR}/install_vma.cmake")
    set_target_properties(VMA PROPERTIES FOLDER "Visera/Packages/VMA")

    execute_process(COMMAND ${VISERA_PACKAGES_VCPKG_EXE} install vulkan-memory-allocator)
endif()

macro(link_vma _target)
    message(STATUS "Loading VMA (GPUOpen::VulkanMemoryAllocator)...")
    FIND_PACKAGE(VulkanMemoryAllocator CONFIG REQUIRED)
    target_link_libraries(${_target} PUBLIC GPUOpen::VulkanMemoryAllocator)
endmacro()