tf_add_example(01_Transformations 01_Transformations/01_Transformations.cpp)
tf_add_example(03_MultiThread 03_MultiThread/03_MultiThread.cpp)

set(04_ExecuteIndirect_SRC
    04_ExecuteIndirect/04_ExecuteIndirect.cpp
    04_ExecuteIndirect/AsteroidSim.cpp
    04_ExecuteIndirect/simplexnoise1234.cpp
    04_ExecuteIndirect/TextureGen.cpp
)
tf_add_example(04_ExecuteIndirect "${04_ExecuteIndirect_SRC}")

#tf_add_example(06_MaterialPlayground 06_MaterialPlayground/06_MaterialPlayground.cpp)
