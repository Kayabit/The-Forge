find_package(Python COMPONENTS Interpreter REQUIRED)
function(add_shaders TARGET_NAME SHADER_LIST)
    get_filename_component(FILE_NAME ${SHADER_LIST} NAME)
    set(OUTPUT_FILE "${CMAKE_BINARY_DIR}/CompiledShaders/${FILE_NAME}")

    add_custom_command(
        OUTPUT ${OUTPUT_FILE}
        COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Common_3/Tools/ForgeShadingLanguage/fsl.py -l VULKAN -d ${CMAKE_BINARY_DIR}/Shaders --verbose -b ${CMAKE_BINARY_DIR}/CompiledShaders/ --incremental --compile ${SHADER_LIST}
        DEPENDS ${SHADER_LIST}
        COMMENT "Processing ${SHADER_LIST}"
    )

    add_custom_target(
        ${TARGET_NAME}
        ALL
        DEPENDS ${OUTPUT_FILE}
        COMMENT "Building all FSL shaders"
    )
endfunction(add_shaders)

function(install_theforge_resources TARGET_NAME)
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../../UnitTestResources/Textures ${CMAKE_CURRENT_BINARY_DIR}/Textures
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../../UnitTestResources/Fonts ${CMAKE_CURRENT_BINARY_DIR}/Fonts
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../../UnitTestResources/GPUCfg ${CMAKE_CURRENT_BINARY_DIR}/GPUCfg
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_BINARY_DIR}/CompiledShaders ${CMAKE_CURRENT_BINARY_DIR}/CompiledShaders
    )
endfunction(install_theforge_resources)
