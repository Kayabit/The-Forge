find_package(Python COMPONENTS Interpreter REQUIRED)
function(tf_add_shaders TARGET_NAME SHADER_LIST IS_EXAMPLE)
    if(EXISTS ${SHADER_LIST})
        get_filename_component(FILE_NAME ${SHADER_LIST} NAME)
        set(OUTPUT_FILE "${CMAKE_BINARY_DIR}/CompiledShaders/${TARGET_NAME}-${FILE_NAME}")
        if(IS_EXAMPLE)
            set(OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/)
        else()
            set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/)
        endif()
        message(STATUS "output dir: ${OUTPUT_DIR}")

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
    if(IS_EXAMPLE)
        add_dependencies(${TARGET_NAME} ${TARGET_NAME}Shaders)
    endif()
    endif()

    if(IS_EXAMPLE)
        tf_install_example_resources(${TARGET_NAME})
    endif()
endfunction(tf_add_shaders)

function(tf_install_unit_tests_resources)
    add_custom_command(TARGET The-Forge POST_BUILD
        # Copy to UnitTestResources
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_SOURCE_DIR}/Art/PBR ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/PBR
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_SOURCE_DIR}/Art/Hair ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes/Hair
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Meshes/*.gltf ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes/
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Meshes/*.bin ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes/
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Textures/*.dds ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_SOURCE_DIR}/Art/Sponza/Textures/SponzaPBR_Textures ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/SponzaPBR_Textures
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Art/Sponza/Textures/SponzaPBR_Textures/Lion/*.dds ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_SOURCE_DIR}/Art/Sponza/Textures/lion ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/lion
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Art/Sponza/Meshes/*.gltf ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes/
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Art/Sponza/Meshes/*.bin ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes/
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Art/SparseTextures/*.svt ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/DLUT/dlut.ktx ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/dlut.ktx
    )
endfunction(tf_install_unit_tests_resources)

function(tf_install_example_resources TARGET_NAME)
    if(EXISTS ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/GPUCfg})
        set(GPUCfgDir ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/GPUCfg)
    else()
        set(GPUCfgDir ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/GPUCfg)
    endif()

    # Copy example scripts if they exist
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET_NAME}/Scripts)
        add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET_NAME}/Scripts ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Scripts
        )
    endif()

    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        # Copy core shaders from UnitTestResources
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/CompiledShaders ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/CompiledShaders
        # Link from UnitTestResources
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Textures ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Textures
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Textures/input/*.dds ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Textures/
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Fonts ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Fonts
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${GPUCfgDir} ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/GPUCfg
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Meshes ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Meshes
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Animation ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Animation
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/ZipFiles ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/ZipFiles
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/cameraPath.bin ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/cameraPath.bin
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Scripts ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Scripts
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Animation/stormtrooper ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/Meshes/stormtrooper
        # Link stuff from Art directory
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_SOURCE_DIR}/Art/SDF ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/SDF
    )
endfunction(tf_install_example_resources)

function(tf_add_example EXAMPLE_DIR SOURCES)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${EXAMPLE_DIR}")

    add_executable(${EXAMPLE_DIR} ${SOURCES})
    tf_add_shaders(${EXAMPLE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/${EXAMPLE_DIR}/Shaders/FSL/ShaderList.fsl TRUE)
    target_link_libraries(${EXAMPLE_DIR} The-Forge)
endfunction(tf_add_example)
