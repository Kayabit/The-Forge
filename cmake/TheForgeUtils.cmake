find_package(Python COMPONENTS Interpreter REQUIRED)
function(tf_add_shaders TARGET_NAME SHADER_LIST IS_EXAMPLE)
    if(EXISTS ${SHADER_LIST})
        get_filename_component(FILE_NAME ${SHADER_LIST} NAME)
        if(IS_EXAMPLE)
            if (LINUX)
                set(OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME})
            endif()
            if (APPLE)
                set(OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/${TARGET_NAME}.app/Contents/Resources)
            endif()
        else()
            set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources)
        endif()
        set(OUTPUT_FILE "${OUTPUT_DIR}/${FILE_NAME}")

        add_custom_command(
            OUTPUT ${OUTPUT_FILE}
            COMMAND ${CMAKE_COMMAND} -E echo "Building FSL shaders for ${SHADER_LIST}"
            COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Common_3/Tools/ForgeShadingLanguage/fsl.py -l ${FSL_LANGUAGE} -d ${OUTPUT_DIR}/Shaders --verbose -b ${OUTPUT_DIR}/CompiledShaders/ --incremental --compile ${SHADER_LIST} > /dev/null 2>&1
            DEPENDS ${SHADER_LIST}
        )

        add_custom_target(
            ${TARGET_NAME}Shaders
            ALL
            DEPENDS ${OUTPUT_FILE}
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
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/input/*.dds ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/
    )
endfunction(tf_install_unit_tests_resources)

function(tf_install_example_resources TARGET_NAME)
    message(STATUS "Configuring building for example ${TARGET_NAME}")

    if(EXISTS ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/GPUCfg})
        set(GPUCfgDir ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/GPUCfg)
    else()
        set(GPUCfgDir ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/GPUCfg)
    endif()

    if (LINUX)
        set(RESOURCES_DIR ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME})
    endif()
    if (APPLE)
        set(RESOURCES_DIR ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}/${TARGET_NAME}.app/Contents/Resources)
    endif()

    # Copy example scripts if they exist
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET_NAME}/Scripts)
        add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET_NAME}/Scripts ${RESOURCES_DIR}/Scripts
        )
    endif()

    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        # Copy core shaders from UnitTestResources
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/CompiledShaders ${RESOURCES_DIR}/CompiledShaders
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Shaders ${RESOURCES_DIR}/Shaders
        # Link from UnitTestResources
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Textures ${RESOURCES_DIR}/Textures
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Fonts ${RESOURCES_DIR}/Fonts
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${GPUCfgDir} ${RESOURCES_DIR}/GPUCfg
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Meshes ${RESOURCES_DIR}/Meshes
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Animation ${RESOURCES_DIR}/Animation
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/ZipFiles ${RESOURCES_DIR}/ZipFiles
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/cameraPath.bin ${RESOURCES_DIR}/cameraPath.bin
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Scripts ${RESOURCES_DIR}/Scripts
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Animation/stormtrooper ${RESOURCES_DIR}/Meshes/stormtrooper
        # Link stuff from Art directory
        COMMAND ${CMAKE_COMMAND} -E create_symlink ${CMAKE_SOURCE_DIR}/Art/SDF ${RESOURCES_DIR}/SDF
    )

    if(APPLE AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../macOS Xcode/${TARGET_NAME}/${TARGET_NAME}/Base.lproj/MainMenu.xib")
        add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND xcrun ibtool --compile "${RESOURCES_DIR}/Base.lproj/MainMenu.nib" "${CMAKE_CURRENT_SOURCE_DIR}/../macOS Xcode/${TARGET_NAME}/${TARGET_NAME}/Base.lproj/MainMenu.xib"
        )
    endif()
endfunction(tf_install_example_resources)

function(tf_add_example EXAMPLE_DIR SOURCES)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${EXAMPLE_DIR}")

    if (APPLE)
        # Link against the application's delegate class since it's not visible if built inside libThe-Forge.a
        list(APPEND SOURCES ${CMAKE_SOURCE_DIR}/Common_3/OS/Darwin/macOSAppDelegate.m)
        set_source_files_properties(
            ${SOURCES}
            PROPERTIES COMPILE_FLAGS "-x objective-c++ -fobjc-arc"
        )
    endif()
    add_executable(${EXAMPLE_DIR} MACOSX_BUNDLE ${SOURCES})

    tf_add_shaders(${EXAMPLE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/${EXAMPLE_DIR}/Shaders/FSL/ShaderList.fsl TRUE)
    target_link_libraries(${EXAMPLE_DIR} The-Forge)
endfunction(tf_add_example)
