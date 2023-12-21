find_package(Python COMPONENTS Interpreter REQUIRED)
function(tf_add_shaders TARGET_NAME SHADER_LIST IS_EXAMPLE)
    get_filename_component(FILE_NAME ${SHADER_LIST} NAME)
    set(OUTPUT_FILE "${CMAKE_BINARY_DIR}/CompiledShaders/${TARGET_NAME}-${FILE_NAME}")
    if (IS_EXAMPLE)
        set(OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/)
    else()
        set(OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/)
    endif()

    add_custom_command(
        OUTPUT ${OUTPUT_FILE}
        COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Common_3/Tools/ForgeShadingLanguage/fsl.py -l VULKAN -d ${OUTPUT_DIR}/Shaders --verbose -b ${OUTPUT_DIR}/CompiledShaders/ --incremental --compile ${SHADER_LIST}
        DEPENDS ${SHADER_LIST}
        COMMENT "Processing ${SHADER_LIST}"
    )

    add_custom_target(
        ${TARGET_NAME}Shaders
        ALL
        DEPENDS ${OUTPUT_FILE}
        COMMENT "Building all FSL shaders"
    )
endfunction(tf_add_shaders)

function(tf_install_resources TARGET_NAME)
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Textures ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Textures
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Fonts ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Fonts
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/GPUCfg ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/GPUCfg
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_BINARY_DIR}/CompiledShaders ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/CompiledShaders
    )
endfunction(tf_install_resources)

function(tf_add_example EXAMPLE_DIR SOURCES)
    tf_add_shaders(${EXAMPLE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/${EXAMPLE_DIR}/Shaders/FSL/ShaderList.fsl TRUE)

    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${EXAMPLE_DIR}")

    message(STATUS "sources: ${SOURCES}")
    add_executable(${EXAMPLE_DIR}
        ${SOURCES}
    )

    target_link_libraries(${EXAMPLE_DIR}
        The-Forge
    )

    add_dependencies(${EXAMPLE_DIR} ${EXAMPLE_DIR}Shaders)
    tf_install_resources(${EXAMPLE_DIR})
endfunction(tf_add_example)
