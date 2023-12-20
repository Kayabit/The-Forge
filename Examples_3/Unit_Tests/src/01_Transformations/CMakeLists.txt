file(GLOB_RECURSE FSL_FILES "${CMAKE_CURRENT_SOURCE_DIR}/Shaders/FSL/*.fsl")
add_shaders(01Shaders ${CMAKE_CURRENT_SOURCE_DIR}/Shaders/FSL/ShaderList.fsl)

add_executable(01_Transformations
    01_Transformations.cpp
)

target_link_libraries(01_Transformations
    The-Forge
)

add_dependencies(01_Transformations 01Shaders)
install_theforge_resources(01_Transformations)
