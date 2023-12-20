cmake_minimum_required(VERSION 3.5)

project(The-Forge LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_EXAMPLES "Build The-Forge's example programs" ON)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(TheForgeUtils)
tf_add_shaders(UIShaders ${CMAKE_SOURCE_DIR}/Common_3/Application/UI/Shaders/FSL/UI_ShaderList.fsl)
tf_add_shaders(FontShaders ${CMAKE_SOURCE_DIR}/Common_3/Application/Fonts/Shaders/FSL/Fonts_ShaderList.fsl)

set(CPP_SRC
    Common_3/Application/CameraController.cpp
    Common_3/Application/Fonts/FontSystem.cpp
    Common_3/Application/Fonts/stbtt.cpp
    Common_3/Application/InputSystem.cpp
    Common_3/Application/Profiler/GpuProfiler.cpp
    Common_3/Application/Profiler/ProfilerBase.cpp
    Common_3/Application/Screenshot.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/builtin/GainputInputDeviceBuiltIn.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputDev.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputMemoryStream.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetAddress.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetConnection.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetListener.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputAllocator.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gainput.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputDeltaState.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputDevice.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputManager.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputMap.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputState.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputMapFilters.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputButtonStickGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputDoubleClickGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputHoldGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputPinchGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputRotateGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputSimultaneouslyDownGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gestures/GainputTapGesture.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/GainputHID.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/GainputHIDWhitelist.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS4Controller.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS5Controller.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboard.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputInputDeviceMouse.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePad.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputPlayer.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputRecorder.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputRecording.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/touch/GainputInputDeviceTouch.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/samples/dynamic/dynamicsample.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/samples/gesture/gesturesample.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/samples/listener/listenersample.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/samples/recording/recordingsample.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/samples/samplefw/SampleFramework.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/samples/sync/syncsample.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/test/test.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/test/test_inputdevice.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/test/test_inputmanager.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/test/test_inputmap.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/test/test_inputrecording.cpp
    # Common_3/Application/ThirdParty/OpenSource/gainput/test/test_inputstate.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_demo.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_draw.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_tables.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_widgets.cpp
#    Common_3/Application/UI/imgui_user.cpp
    Common_3/Application/UI/UI.cpp
    Common_3/Game/Scripting/LuaManager.cpp
    Common_3/Game/Scripting/LuaManagerImpl.cpp
    Common_3/Game/Scripting/LuaSystem.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/monotone/soloud_monotone.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/openmpt/soloud_openmpt.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/sfxr/soloud_sfxr.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/speech/darray.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/speech/klatt.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/speech/resonator.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/speech/soloud_speech.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/speech/tts.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/tedsid/sid.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/tedsid/soloud_tedsid.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/tedsid/ted.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/vic/soloud_vic.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/vizsn/soloud_vizsn.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/wav/dr_impl.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/wav/soloud_wav.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/wav/soloud_wavstream.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/wav/stb_vorbis.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/backend/alsa/soloud_alsa.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/backend/coreaudio/soloud_coreaudio.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/backend/opensles/soloud_opensles.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/backend/winmm/soloud_winmm.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/backend/xaudio2/soloud_xaudio2.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_audiosource.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_bus.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_core_3d.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_core_basicops.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_core_faderops.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_core_filterops.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_core_getters.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_core_setters.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_core_voicegroup.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_core_voiceops.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_fader.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_fft.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_fft_lut.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_file.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_filter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_queue.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud_thread.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_bassboostfilter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_biquadresonantfilter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_dcremovalfilter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_echofilter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_fftfilter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_flangerfilter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_lofifilter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_robotizefilter.cpp
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/filter/soloud_waveshaperfilter.cpp
    Common_3/Graphics/CommonShaderReflection.cpp
    Common_3/Graphics/DependencyTracking.cpp
    Common_3/Graphics/GPUConfig.cpp
    Common_3/Graphics/Graphics.cpp
    Common_3/Graphics/OpenGLES/EGLContextCreator.cpp
    Common_3/Graphics/OpenGLES/GLES.cpp
    Common_3/Graphics/OpenGLES/GLESShaderReflection.cpp
    Common_3/Graphics/Quest/VrApiHooks.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cfg.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cpp.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross_parsed_ir.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross_util.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_glsl.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_hlsl.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_msl.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_parser.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_reflect.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/SpirvTools.cpp
    Common_3/Graphics/Vulkan/Vulkan.cpp
    Common_3/Graphics/Vulkan/VulkanRaytracing.cpp
    Common_3/Graphics/Vulkan/VulkanShaderReflection.cpp
    Common_3/OS/CPUConfig.cpp
    Common_3/OS/WindowSystem/WindowSystem.cpp
    Common_3/Resources/AnimationSystem/Animation/AnimatedObject.cpp
    Common_3/Resources/AnimationSystem/Animation/Animation.cpp
    Common_3/Resources/AnimationSystem/Animation/ClipController.cpp
    Common_3/Resources/AnimationSystem/Animation/Clip.cpp
    Common_3/Resources/AnimationSystem/Animation/ClipMask.cpp
    Common_3/Resources/AnimationSystem/Animation/Rig.cpp
    Common_3/Resources/AnimationSystem/Animation/SkeletonBatcher.cpp
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/TressFX/TressFXAsset.cpp
    Common_3/Resources/ResourceLoader/ResourceLoader.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_averages_and_directions.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_block_sizes.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenccli_error_metrics.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenccli_image.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenccli_image_external.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenccli_image_load_store.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenccli_platform_dependents.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenccli_toplevel.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenccli_toplevel_help.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_color_quantize.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_color_unquantize.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_compress_symbolic.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_compute_variance.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_decompress_symbolic.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_diagnostic_trace.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_entry.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_find_best_partitioning.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_ideal_endpoints_and_weights.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_image.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_integer_sequence.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_mathlib.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_mathlib_softfloat.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_partition_tables.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_percentile_tables.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_pick_best_endpoint_format.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_platform_isa_detection.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_quantization.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_symbolic_physical.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_weight_align.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/astcenc_weight_quant_xfer_tables.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Utils/astc_rgbm_codec.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Utils/astc_test_autoextract.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Utils/astc_test_autoextract_hdr.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Utils/Example/astc_api_example.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/allocator.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/clusterizer.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/indexcodec.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/indexgenerator.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/overdrawanalyzer.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/overdrawoptimizer.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/simplifier.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/spatialorder.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/stripifier.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/vcacheanalyzer.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/vcacheoptimizer.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/vertexcodec.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/vertexfilter.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/vfetchanalyzer.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/meshoptimizer/src/vfetchoptimizer.cpp
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/TinyEXR/tinyexr.cpp
    Common_3/Tools/AssetPipeline/src/AssetPipelineCmd.cpp
    Common_3/Tools/AssetPipeline/src/AssetPipeline.cpp
    Common_3/Utilities/FileSystem/FileSystem.cpp
    Common_3/Utilities/FileSystem/SystemRun.cpp
    Common_3/Utilities/FileSystem/UnixFileSystem.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_astc_decomp.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_backend.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_basis_file.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_comp.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_enc.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_etc.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_frontend.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_global_selector_palette_helpers.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_gpu_texture.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_pvrtc1_4.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_resample_filters.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_resampler.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_ssim.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/basisu_tool.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/contrib/previewers/lib/basisu_transcoder.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/lodepng.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/transcoder/basisu_transcoder.cpp
    # Common_3/Utilities/ThirdParty/OpenSource/basis_universal/webgl/transcoder/basis_wrappers.cpp
    # Common_3/Utilities/ThirdParty/OpenSource/basis_universal/webgl_videotest/basis_wrappers.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/allocator_eastl.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/allocator_forge.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/assert.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/EAStdC/EAMemory.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/EAStdC/EASprintf.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/eastl.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/fixed_pool.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/hashtable.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/intrusive_list.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/numeric_limits.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/red_black_tree.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/string.cpp
    Common_3/Utilities/ThirdParty/OpenSource/EASTL/thread_support.cpp
    Common_3/Utilities/ThirdParty/OpenSource/minizip/mz_os.cpp
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_get_module_info.cpp
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_hook.cpp
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_lib.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTDefaultAppInterop.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTFiberContext.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTScheduler.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTThreadContext.cpp
#    Common_3/Utilities/ThirdParty/OpenSource/TinyXML2/tinyxml2.cpp
#    Common_3/Utilities/ThirdParty/OpenSource/zip/zip.cpp
    Common_3/Utilities/Threading/ThreadSystem.cpp
)

set(C_SRC
    Common_3/Application/ThirdParty/OpenSource/Fontstash/example/error.c
    Common_3/Application/ThirdParty/OpenSource/Fontstash/example/example.c
    Common_3/Game/ThirdParty/OpenSource/flecs/flecs.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lapi.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lauxlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lbaselib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lbitlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lcode.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lcorolib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lctype.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldblib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldebug.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldo.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ldump.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lfunc.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lgc.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/linit.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/liolib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/llex.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lmathlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lmem.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/loadlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lobject.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lopcodes.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/loslib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lparser.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lstate.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lstring.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lstrlib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ltable.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ltablib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/ltm.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lua.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/luac.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lundump.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lutf8lib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lvm.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lzio.c
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/openmpt/soloud_openmpt_dll.c
    Common_3/Graphics/ThirdParty/OpenSource/volk/volk.c
#    Common_3/Graphics/ThirdParty/OpenSource/volk/volkForgeExt.c
    Common_3/OS/ThirdParty/OpenSource/cpu_features/src/hwcaps.c
    Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_freebsd.c
    Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/wuffs-v0.3.c
    Common_3/Utilities/FileSystem/ZipFileSystem.c
    Common_3/Utilities/Log/Log.c
    Common_3/Utilities/Math/Algorithms.c
    Common_3/Utilities/Math/StbDs.c
    Common_3/Utilities/MemoryTracking/MemoryTracking.c
    Common_3/Utilities/ThirdParty/OpenSource/bstrlib/bstrlib.c
#    Common_3/Utilities/ThirdParty/OpenSource/bstrlib/buniutil.c
    Common_3/Utilities/ThirdParty/OpenSource/bstrlib/utf8util.c
    Common_3/Utilities/ThirdParty/OpenSource/cJSON/cJSON.c
    Common_3/Utilities/ThirdParty/OpenSource/FluidStudios/MemoryManager/mmgr.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/lib/brg/aescrypt.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/lib/brg/aeskey.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/lib/brg/aestab.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/lib/brg/hmac.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/lib/brg/sha1.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/lib/brg/sha2.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/mz_crypt_brg.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/mz_crypt.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/mz_strm_raw.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/mz_strm_wzaes.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/mz_strm_zlib.c
    Common_3/Utilities/ThirdParty/OpenSource/minizip/mz_zip.c
    Common_3/Utilities/ThirdParty/OpenSource/rmem/3rd/lz4-r191/lz4.c
    Common_3/Utilities/Timer.c
)

if (WIN32)
    list(APPEND CPP_SRC
#        Common_3/Application/ThirdParty/OpenSource/gainput/samples/basic/basicsample_win.cpp
        Common_3/Graphics/Direct3D11/Direct3D11.cpp
        Common_3/Graphics/Direct3D11/Direct3D11Raytracing.cpp
        Common_3/Graphics/Direct3D11/Direct3D11ShaderReflection.cpp
        Common_3/Graphics/Direct3D12/Direct3D12.cpp
        Common_3/Graphics/Direct3D12/Direct3D12Hooks.cpp
        Common_3/Graphics/Direct3D12/Direct3D12Raytracing.cpp
        Common_3/Graphics/Direct3D12/Direct3D12ShaderReflection.cpp
        Common_3/Graphics/ThirdParty/OpenSource/ags/ags_sample/src/AGSSample.cpp
        Common_3/OS/Windows/WindowsBase.cpp
        Common_3/OS/Windows/WindowsFileSystem.cpp
        Common_3/OS/Windows/WindowsStackTraceDump.cpp
        Common_3/OS/Windows/WindowsToolsFileSystem.cpp
        Common_3/OS/Windows/WindowsWindow.cpp
        Common_3/Utilities/ThirdParty/OpenSource/basis_universal/contrib/previewers/win/basisthumbprovider.cpp
        Common_3/Utilities/ThirdParty/OpenSource/basis_universal/contrib/previewers/win/helpers.cpp
        Common_3/Utilities/ThirdParty/OpenSource/basis_universal/contrib/previewers/win/previewers.cpp
        Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Include/Platform/Windows/MicroWindows.cpp
    )
    list(APPEND C_SRC
        Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/windows/hid.c
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_windows.c
        Common_3/OS/Windows/WindowsLog.c
        Common_3/OS/Windows/WindowsThread.c
        Common_3/OS/Windows/WindowsTime.c
    )
endif()

if (LINUX)
    find_package(PkgConfig REQUIRED)
    find_package(X11 REQUIRED)
    pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
    pkg_check_modules(XRANDR REQUIRED xrandr)
    pkg_check_modules(LIBUDEV REQUIRED libudev)

    list(APPEND CPP_SRC
#        Common_3/Application/ThirdParty/OpenSource/gainput/samples/basic/basicsample_linux.cpp
        Common_3/OS/Linux/LinuxBase.cpp
        Common_3/OS/Linux/LinuxFileSystem.cpp
        Common_3/OS/Linux/LinuxToolsFileSystem.cpp
        Common_3/OS/Linux/LinuxWindow.cpp
    )
    list(APPEND C_SRC
        Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/linux/hid.c
        Common_3/OS/Linux/LinuxLog.c
        Common_3/OS/Linux/LinuxThread.c
        Common_3/OS/Linux/LinuxTime.c
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_linux_or_android.c
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_linux_or_android.c
    )
endif()

if (APPLE)
    if (IOS)
        set(OBJCPP_SRC
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/builtin/GainputInputDeviceBuiltInIos.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputIos.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePadIos.mm
#            Common_3/Application/ThirdParty/OpenSource/gainput/samples/basic/basicsample_ios.mm
            Common_3/OS/Darwin/iOSBase.mm
            Common_3/OS/Darwin/iOSToolsFileSystem.mm
            Common_3/OS/Darwin/iOSWindow.mm
        )
        set(OBJC_SRC
            Common_3/OS/Darwin/iOSAppDelegate.m
        )
        list(APPEND C_SRC
            Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_iOS.c
        )
    else()
        set(OBJCPP_SRC
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputMac.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputInputDeviceMouseMac.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputInputDeviceMouseMacRaw.mm
#            Common_3/Application/ThirdParty/OpenSource/gainput/samples/basic/basicsample_mac.mm
            Common_3/Graphics/Metal/MetalRaytracing.mm
            Common_3/Graphics/Metal/MetalRenderer.mm
            Common_3/Graphics/Metal/MetalShaderReflection.mm
            Common_3/OS/Darwin/CocoaFileSystem.mm
            Common_3/OS/Darwin/CocoaToolsFileSystem.mm
            Common_3/OS/Darwin/macOSBase.mm
            Common_3/OS/Darwin/macOSWindow.mm
        )
        set(OBJC_SRC
            Common_3/Graphics/ThirdParty/OpenSource/nvapi/NvApiDriverSettings.c
            Common_3/OS/Darwin/macOSAppDelegate.m
        )
        list(APPEND CPP_SRC
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboardMac.cpp
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePadMac.cpp
            Common_3/Application/UI/NoesisUI.cpp
        )
        list(APPEND C_SRC
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/mac/hid.c
            Common_3/OS/Darwin/DarwinLog.c
            Common_3/OS/Darwin/DarwinThread.c
            Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_macos.c
        )
    endif()
endif()

if (ANDROID)
    list(APPEND CPP_SRC
        Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/touch/GainputInputDeviceGestureDetectorAndroid.cpp
#        Common_3/Application/ThirdParty/OpenSource/gainput/samples/basic/basicsample_android.cpp
#        Common_3/Application/ThirdParty/OpenSource/gainput/samples/basic/basicsample_android_generic.cpp
        Common_3/OS/Android/AndroidBase.cpp
        Common_3/OS/Android/AndroidFileSystem.cpp
        Common_3/OS/Android/AndroidToolsFileSystem.cpp
        Common_3/OS/Android/AndroidWindow.cpp
        Common_3/OS/Android/AndroidLog.c
        Common_3/OS/Android/android_native_app_glue.c
        Common_3/OS/Android/AndroidThread.c
        Common_3/OS/Android/AndroidTime.c
        Common_3/OS/Quest/VrApi.cpp
    )
    list(APPEND C_SRC
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_linux_or_android.c
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_linux_or_android.c
    )
endif()

set (SRC ${CPP_SRC} ${C_SRC} ${OBJCPP_SRC} ${OBJC_SRC})

add_library(The-Forge STATIC ${SRC})

target_include_directories(The-Forge
    PUBLIC
    ${CMAKE_SOURCE_DIR}/Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/
    ${CMAKE_SOURCE_DIR}/Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/
    ${CMAKE_SOURCE_DIR}/Common_3/Game/ThirdParty/OpenSource/soloud20181119/
    ${CMAKE_SOURCE_DIR}/Common_3/Game/ThirdParty/OpenSource/soloud20181119/include/
    ${CMAKE_SOURCE_DIR}/Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/astc-encoder/Source/
    ${CMAKE_SOURCE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/basis_universal/transcoder/
    ${CMAKE_SOURCE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Include/
    ${CMAKE_SOURCE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/
    ${CMAKE_SOURCE_DIR}/Common_3/Application/ThirdParty/OpenSource/Fontstash/src/
    ${CMAKE_SOURCE_DIR}/
)

if (WIN32)
endif()

if (LINUX)
    target_include_directories(The-Forge PUBLIC
        ${GTK3_INCLUDE_DIRS}
    )
    target_link_libraries(The-Forge PUBLIC
        ${GTK3_LIBRARIES}
        ${X11_LIBRARIES}
        ${XRANDR_LIBRARIES}
        ${LIBUDEV_LIBRARIES}
    )
endif()

if (APPLE)
    if (IOS)
    else()
    endif()
endif()

if (ANDROID)
endif()

add_dependencies(The-Forge UIShaders FontShaders)

if(BUILD_EXAMPLES)
    add_subdirectory(Examples_3/Unit_Tests/src)
endif()

include(GNUInstallDirs)
install(TARGETS The-Forge
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
