# cmake-lint: disable=C0103

tf_add_unit_test(01_Transformations 01_Transformations/01_Transformations.cpp)
tf_add_unit_test(03_MultiThread 03_MultiThread/03_MultiThread.cpp)

set(04_ExecuteIndirect_SRC 04_ExecuteIndirect/04_ExecuteIndirect.cpp 04_ExecuteIndirect/AsteroidSim.cpp 04_ExecuteIndirect/simplexnoise1234.cpp 04_ExecuteIndirect/TextureGen.cpp)
tf_add_unit_test(04_ExecuteIndirect "${04_ExecuteIndirect_SRC}")

tf_add_unit_test(06_MaterialPlayground 06_MaterialPlayground/06_MaterialPlayground.cpp)
tf_add_unit_test(07_Tessellation 07_Tessellation/07_Tessellation.cpp)

set(09_LightShadowPlayground_SRC 09_LightShadowPlayground/09_LightShadowPlayground.cpp 09_LightShadowPlayground/Geometry.cpp)
tf_add_unit_test(09_LightShadowPlayground "${09_LightShadowPlayground_SRC}")

tf_add_unit_test(09a_HybridRaytracing 09a_HybridRaytracing/09a_HybridRaytracing.cpp)
tf_add_unit_test(10_ScreenSpaceReflections 10_ScreenSpaceReflections/10_ScreenSpaceReflections.cpp)

if(WIN32 OR ANDROID)
    tf_add_unit_test(11_MultiGPU 11_MultiGPU/11_MultiGPU.cpp)
    tf_add_unit_test(11a_UnlinkedMultiGPU 11a_UnlinkedMultiGPU/11a_UnlinkedMultiGPU.cpp)
endif()

tf_add_unit_test(12_ZipFileSystem 12_ZipFileSystem/12_ZipFileSystem.cpp)
tf_add_unit_test(14_WaveIntrinsics 14_WaveIntrinsics/14_WaveIntrinsics.cpp)
tf_add_unit_test(15_Transparency 15_Transparency/15_Transparency.cpp)

set(15a_VisibilityBufferOIT_SRC 15a_VisibilityBufferOIT/15a_VisibilityBufferOIT.cpp 15a_VisibilityBufferOIT/Geometry.cpp)
tf_add_unit_test(15a_VisibilityBufferOIT "${15a_VisibilityBufferOIT_SRC}")

tf_add_unit_test(16_Raytracing 16_Raytracing/16_Raytracing.cpp)
tf_add_unit_test(17_EntityComponentSystem 17_EntityComponentSystem/17_EntityComponentSystem.cpp)

if(NOT APPLE)
    tf_add_unit_test(18_VirtualTexture 18_VirtualTexture/18_VirtualTexture.cpp)
endif()

set(19_CodeHotReload_SRC 19_CodeHotReload/19_CodeHotReload_Game.cpp 19_CodeHotReload/19_CodeHotReload_Main.cpp)
tf_add_unit_test(19_CodeHotReload "${19_CodeHotReload_SRC}")

tf_add_unit_test(21_Animations 21_Animations/21_Animations.cpp)
tf_add_unit_test(28_Skinning 28_Skinning/28_Skinning.cpp)

if(LINUX)
    tf_add_unit_test(33_YUV 33_YUV/33_YUV.cpp)
endif()

tf_add_unit_test(34_Input 34_Input/34_Input.cpp)
if(NOT APPLE)
    tf_add_unit_test(35_VariableRateShading 35_VariableRateShading/35_VariableRateShading.cpp)
endif()

set(36_AlgorithmsAndContainers_SRC 36_AlgorithmsAndContainers/36_AlgorithmsAndContainers.cpp 36_AlgorithmsAndContainers/AlgorithmsTest.c)
set_source_files_properties(36_AlgorithmsAndContainers/AlgorithmsTest.c PROPERTIES LANGUAGE CXX)
tf_add_unit_test(36_AlgorithmsAndContainers "${36_AlgorithmsAndContainers_SRC}")

tf_add_unit_test(37_PrecomputedVolumeDLUT 37_PrecomputedVolumeDLUT/37_PrecomputedVolumeDLUT.cpp)

set(38_AmbientOcclusion_GTAO_SRC 38_AmbientOcclusion_GTAO/38_AmbientOcclusion_GTAO.cpp 38_AmbientOcclusion_GTAO/Geometry.cpp)
tf_add_unit_test(38_AmbientOcclusion_GTAO "${38_AmbientOcclusion_GTAO_SRC}")
