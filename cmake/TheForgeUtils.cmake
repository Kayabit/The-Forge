find_package(
    Python
    COMPONENTS Interpreter
    REQUIRED
)

# Add a custom target for invoking The Forge's FSL compiler
function(tf_add_shaders target_name shader_list_file is_unit_test)
    if(EXISTS ${shader_list_file})
        get_filename_component(FILE_NAME ${shader_list_file} NAME)
        if(is_unit_test)
            if(LINUX)
                set(output_dir ${CMAKE_CURRENT_BINARY_DIR}/${target_name})
            endif()
            if(WIN32)
                set(output_dir ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/${CMAKE_BUILD_TYPE})
            endif()
            if(APPLE)
                set(output_dir ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/${target_name}.app/Contents/Resources)
            endif()
        else()
            set(output_dir ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources)
        endif()
        set(output_file "${output_dir}/${FILE_NAME}")

        set(shader_targets "")
        foreach(fsl_language IN LISTS FSL_LANGUAGES)
            list(APPEND shader_targets ${output_file}-${fsl_language})
            add_custom_command(
                OUTPUT ${output_file}-${fsl_language}
                COMMAND ${CMAKE_COMMAND} -E echo "Building FSL shaders for ${shader_list_file}"
                COMMAND ${Python_EXECUTABLE} ${CMAKE_SOURCE_DIR}/Common_3/Tools/ForgeShadingLanguage/fsl.py -l ${fsl_language} -d ${output_dir}/Shaders --verbose -b
                        ${output_dir}/CompiledShaders/ --incremental --compile ${shader_list_file}
                DEPENDS ${shader_list_file}
                COMMENT "Compiling FSL shader list file ${shader_list_file}"
            )
        endforeach()

        add_custom_target(
            ${target_name}Shaders
            DEPENDS ${shader_targets}
            COMMENT "Custom target for ${target_name} shaders"
        )
        if(is_unit_test)
            add_dependencies(${target_name} ${target_name}Shaders)
        endif()
    endif()
endfunction(tf_add_shaders)

# Install resources used by all unit tests
function(tf_install_unit_tests_resources)
    add_custom_command(
        TARGET The-Forge
        POST_BUILD
        # Copy to UnitTestResources
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_SOURCE_DIR}/Art/PBR
                ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/PBR
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_SOURCE_DIR}/Art/Hair
                ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes/Hair
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Meshes ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/SanMiguel_3/Textures ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_SOURCE_DIR}/Art/Sponza/Textures/SponzaPBR_Textures
                ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/SponzaPBR_Textures
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/Sponza/Textures/SponzaPBR_Textures/Lion ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_SOURCE_DIR}/Art/Sponza/Textures/lion
                ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/lion
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/Sponza/Meshes ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/Sponza/Meshes ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Meshes
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Art/SparseTextures ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/DLUT/dlut.ktx
                ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/dlut.ktx
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/input
                ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Textures/
        COMMENT "Installing resources used by all unit tests"
    )
endfunction(tf_install_unit_tests_resources)

# Install resources for a given unit test
function(tf_install_unit_test_resources target_name)
    message(STATUS "Configuring building for unit test ${target_name}")

    if(EXISTS ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/GPUCfg})
        set(gpu_config_dir ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/GPUCfg)
    else()
        set(gpu_config_dir ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/GPUCfg)
    endif()

    if(LINUX)
        set(resources_dir ${CMAKE_CURRENT_BINARY_DIR}/${target_name})
    endif()
    if(WIN32)
        set(resources_dir ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/${CMAKE_BUILD_TYPE})
    endif()
    if(APPLE)
        set(resources_dir ${CMAKE_CURRENT_BINARY_DIR}/${target_name}/${target_name}.app/Contents/Resources)
    endif()

    # Copy unit test scripts if they exist
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${target_name}/Scripts)
        add_custom_command(
            TARGET ${target_name}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_CURRENT_SOURCE_DIR}/${target_name}/Scripts ${resources_dir}/Scripts
            COMMENT "Copying unit test scripts"
        )
    endif()

    add_custom_command(
        TARGET ${target_name}
        POST_BUILD
        # Copy core shaders from UnitTestResources
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/CompiledShaders ${resources_dir}/CompiledShaders
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Shaders ${resources_dir}/Shaders
        # Link from UnitTestResources
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Textures
                ${resources_dir}/Textures
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Fonts
                ${resources_dir}/Fonts
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${gpu_config_dir} ${resources_dir}/GPUCfg
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Meshes
                ${resources_dir}/Meshes
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/Animation
                ${resources_dir}/Animation
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/ZipFiles
                ${resources_dir}/ZipFiles
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_CURRENT_SOURCE_DIR}/../UnitTestResources/cameraPath.bin
                ${resources_dir}/cameraPath.bin
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Scripts ${resources_dir}/Scripts
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/Examples_3/Unit_Tests/UnitTestResources/Animation/stormtrooper ${resources_dir}/Meshes/stormtrooper
        # Link stuff from Art directory
        COMMAND ${CMAKE_COMMAND} -E $<$<PLATFORM_ID:Windows>:copy_directory> $<$<NOT:$<PLATFORM_ID:Windows>>:create_symlink> ${CMAKE_SOURCE_DIR}/Art/SDF ${resources_dir}/SDF
        COMMENT "Installing unit test resources"
    )

    message(STATUS "Target name 1: ${target_name}")
    if(APPLE AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../macOS Xcode/${target_name}/${target_name}/Base.lproj/MainMenu.xib")
        add_custom_command(
            TARGET ${target_name}
            POST_BUILD
            COMMAND xcrun ibtool --compile "${resources_dir}/Base.lproj/MainMenu.nib" "${CMAKE_CURRENT_SOURCE_DIR}/../macOS Xcode/${target_name}/${target_name}/Base.lproj/MainMenu.xib"
            COMMENT "Compiling unit test xib file"
        )
    endif()

    if(WIN32)
        message(STATUS "Target name 2: ${target_name}")
        add_custom_command(
            TARGET ${target_name}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/ags/ags_lib/lib/amd_ags_x64.dll
                    ${CMAKE_SOURCE_DIR}/Common_3/OS/ThirdParty/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.dll ${resources_dir}/
            COMMENT "Copying Windows dependencies"
        )
    endif()
endfunction(tf_install_unit_test_resources)

# Add a The-Forge's unit test
function(tf_add_unit_test unit_test_dir sources)
    if(APPLE)
        # Link against the application's delegate class since it's not visible if built inside libThe-Forge.a
        list(APPEND sources ${CMAKE_SOURCE_DIR}/Common_3/OS/Darwin/macOSAppDelegate.m)
        set_source_files_properties(${sources} PROPERTIES COMPILE_FLAGS "-x objective-c++ -fobjc-arc")
    endif()
    add_executable(${unit_test_dir} MACOSX_BUNDLE ${sources})
    set_target_properties(${unit_test_dir} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${unit_test_dir}")

    tf_add_shaders(${unit_test_dir} ${CMAKE_CURRENT_SOURCE_DIR}/${unit_test_dir}/Shaders/FSL/ShaderList.fsl TRUE)
    tf_install_unit_test_resources(${unit_test_dir})

    target_link_libraries(${unit_test_dir} The-Forge)
endfunction(tf_add_unit_test)
