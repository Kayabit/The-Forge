if (LINUX)
endif()

add_executable(01_Transformations
    01_Transformations.cpp
)

target_link_libraries(01_Transformations
    The-Forge
)
