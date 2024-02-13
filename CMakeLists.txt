cmake_minimum_required(VERSION 3.5)
#set (CMAKE_OSX_DEPLOYMENT_TARGET, "11.0")

# extra ../../cmake in case we're run from a build subdir under The-Forge folder
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" "${CMAKE_SOURCE_DIR}/../../cmake" ${CMAKE_MODULE_PATH})

OPTION(GENERATE_DEBUG_SYMBOLS "Always generate dSYM and pdb files, even if making a release build" OFF)

# have to do some conan setup that usually happens in the root cmakelists
include(BuildboxConan)
setup_conan()

# we want conan here so we can have standardized configurations; it's not used for its usual dependency management purposes
include_conan()

project(The-Forge LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_EXAMPLES "Build The-Forge's example programs" OFF)

if(BUILD_EXAMPLES AND NOT EXISTS ${CMAKE_SOURCE_DIR}/Art)
    message(STATUS "Downloading art assets, please grab a cup of coffee and wait a few minutes. This will be executed only once!")
    if(WIN32)
        execute_process(COMMAND ${CMAKE_SOURCE_DIR}/PRE_BUILD.bat)
    else()
        execute_process(COMMAND chmod +x ${CMAKE_SOURCE_DIR}/PRE_BUILD.command)
        execute_process(COMMAND ${CMAKE_SOURCE_DIR}/PRE_BUILD.command)
    endif()
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(TheForgeUtils)

set(CPP_SRC
    Common_3/Application/CameraController.cpp
    Common_3/Application/Fonts/FontSystem.cpp
    Common_3/Application/Fonts/stbtt.cpp
    Common_3/Application/InputSystem.cpp
    Common_3/Application/Profiler/GpuProfiler.cpp
    Common_3/Application/Profiler/ProfilerBase.cpp
    Common_3/Application/RemoteControl.cpp
    Common_3/Application/Screenshot.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputAllocator.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputDeltaState.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputDevice.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputManager.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputMap.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputState.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputMapFilters.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/builtin/GainputInputDeviceBuiltIn.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputDev.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputMemoryStream.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetAddress.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetConnection.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/dev/GainputNetListener.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/gainput.cpp
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
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/hid/hidparsers/HIDParserSwitchController.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboard.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputInputDeviceMouse.cpp
    #Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePad.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputPlayer.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputRecorder.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/recorder/GainputInputRecording.cpp
    Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/touch/GainputInputDeviceTouch.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_demo.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_draw.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_tables.cpp
    Common_3/Application/ThirdParty/OpenSource/imgui/imgui_widgets.cpp
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
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/core/soloud.cpp
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
    Common_3/Graphics/GPUConfig.cpp
    Common_3/Graphics/PickRenderingAPI.cpp
    Common_3/Graphics/Quest/VrApiHooks.cpp
    Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/SpirvTools.cpp
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
    Common_3/OS/CPUConfig.cpp
    Common_3/OS/WindowSystem/WindowSystem.cpp
    Common_3/Resources/AnimationSystem/Animation/AnimatedObject.cpp
    Common_3/Resources/AnimationSystem/Animation/Animation.cpp
    Common_3/Resources/AnimationSystem/Animation/Clip.cpp
    Common_3/Resources/AnimationSystem/Animation/ClipController.cpp
    Common_3/Resources/AnimationSystem/Animation/ClipMask.cpp
    Common_3/Resources/AnimationSystem/Animation/Rig.cpp
    Common_3/Resources/AnimationSystem/Animation/SkeletonBatcher.cpp
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/TressFX/TressFXAsset.cpp
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/additive_animation_builder.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/animation_builder.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/animation_optimizer.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/raw_animation.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/raw_animation_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/raw_animation_utils.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/raw_skeleton.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/raw_skeleton_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/raw_track.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/skeleton_builder.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/track_builder.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/offline/track_optimizer.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/animation.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/animation_utils.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/blending_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/ik_aim_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/ik_two_bone_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/local_to_model_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/sampling_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/skeleton.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/skeleton_utils.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/track.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/track_sampling_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/animation/runtime/track_triggering_job.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/containers/string_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/io/archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/maths/math_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/maths/simd_math_archive.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/memory/allocator.cc
    Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/base/platform.cc
    Common_3/Resources/ResourceLoader/ResourceLoader.cpp
    Common_3/Tools/ReloadServer/ReloadClient.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTDefaultAppInterop.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTFiberContext.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTScheduler.cpp
    Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Source/MTThreadContext.cpp
    Common_3/Utilities/ThirdParty/OpenSource/basis_universal/transcoder/basisu_transcoder.cpp
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_get_module_info.cpp
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_hook.cpp
    Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_lib.cpp
    Middleware_3/PaniniProjection/Panini.cpp
    Middleware_3/ParallelPrimitives/ParallelPrimitives.cpp
)

set(C_SRC
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
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/luac.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lundump.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lutf8lib.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lvm.c
    Common_3/Game/ThirdParty/OpenSource/lua-5.3.5/src/lzio.c
    Common_3/Game/ThirdParty/OpenSource/soloud20181119/src/audiosource/openmpt/soloud_openmpt_dll.c
    Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_freebsd.c
    Common_3/Tools/Network/Network.c
    Common_3/Utilities/FileSystem/FileSystem.c
    Common_3/Utilities/FileSystem/SystemRun.c
    Common_3/Utilities/FileSystem/ToolFileSystem.c
    Common_3/Utilities/Log/Log.c
    Common_3/Utilities/Math/Algorithms.c
    Common_3/Utilities/Math/StbDs.c
    Common_3/Utilities/MemoryTracking/MemoryTracking.c
    Common_3/Utilities/ThirdParty/OpenSource/bstrlib/bstrlib.c
    Common_3/Utilities/ThirdParty/OpenSource/bstrlib/utf8util.c
    Common_3/Utilities/ThirdParty/OpenSource/cJSON/cJSON.c
    Common_3/Utilities/ThirdParty/OpenSource/lz4/lz4.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/debug.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/entropy_common.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/error_private.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/fse_decompress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/pool.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/threading.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/xxhash.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/common/zstd_common.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/fse_compress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/huf_compress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_compress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_compress_literals.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_compress_sequences.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_compress_superblock.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_double_fast.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_fast.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_lazy.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_ldm.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstd_opt.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/compress/zstdmt_compress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/huf_decompress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/zstd_decompress.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/zstd_decompress_block.c
    Common_3/Utilities/ThirdParty/OpenSource/zstd/decompress/zstd_ddict.c
    Common_3/Utilities/Timer.c
    Common_3/Utilities/Threading/ThreadSystem.c
    
)

if(WIN32)
    set(FSL_LANGUAGES "DIRECT3D12" "DIRECT3D11" "VULKAN")
    if(NOT DEFINED ENV{VULKAN_SDK})
        message(FATAL_ERROR "Please install Vulkan SDK!")
    endif()

    # need to find vulkan headers
    message(STATUS "Vulkan SDK found at $ENV{VULKAN_SDK}, adding include directories... $ENV{VULKAN_SDK}/include")
    include_directories($ENV{VULKAN_SDK}/include)

    list(
        APPEND
        CPP_SRC
        # FORGE154 MERGETODO feels like these gainput guys probably already were somewhere else in this file
        Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePad.cpp
        Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/GainputInputManager.cpp
        Common_3/Graphics/Direct3D11/Direct3D11.cpp
        # FORGE154 D3D11 raytracing seemingly no longer exists, hope that's ok
        #Common_3/Graphics/Direct3D11/Direct3D11Raytracing.cpp
        Common_3/Graphics/Direct3D11/Direct3D11ShaderReflection.cpp
        Common_3/Graphics/Direct3D12/Direct3D12.cpp
        Common_3/Graphics/Direct3D12/Direct3D12Hooks.cpp
        Common_3/Graphics/Direct3D12/Direct3D12Raytracing.cpp
        Common_3/Graphics/Direct3D12/Direct3D12ShaderReflection.cpp
        Common_3/Graphics/Vulkan/Vulkan.cpp
        Common_3/Graphics/Vulkan/VulkanRaytracing.cpp
        Common_3/Graphics/Vulkan/VulkanShaderReflection.cpp
        Common_3/OS/Windows/WindowsBase.cpp
        Common_3/OS/Windows/WindowsFileSystem.cpp
        Common_3/OS/Windows/WindowsStackTraceDump.cpp
        Common_3/OS/Windows/WindowsToolsFileSystem.cpp
        Common_3/OS/Windows/WindowsWindow.cpp
        Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Include/Platform/Windows/MicroWindows.cpp
    )
    list(
        APPEND
        C_SRC
        Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/windows/hid.c
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_windows.c
        Common_3/OS/Windows/WindowsLog.c
        Common_3/OS/Windows/WindowsThread.c
        Common_3/OS/Windows/WindowsTime.c
    )
endif()

if(LINUX)
    set(FSL_LANGUAGES "VULKAN")
    find_package(PkgConfig REQUIRED)
    find_package(X11 REQUIRED)
    pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
    pkg_check_modules(XRANDR REQUIRED xrandr)
    pkg_check_modules(LIBUDEV REQUIRED libudev)

    list(
        APPEND
        CPP_SRC
        Common_3/Graphics/OpenGLES/GLES.cpp
        Common_3/Graphics/OpenGLES/EGLContextCreator.cpp
        Common_3/Graphics/OpenGLES/GLESShaderReflection.cpp
        Common_3/Graphics/Vulkan/Vulkan.cpp
        Common_3/Graphics/Vulkan/VulkanRaytracing.cpp
        Common_3/Graphics/Vulkan/VulkanShaderReflection.cpp
        Common_3/OS/Linux/LinuxBase.cpp
        Common_3/OS/Linux/LinuxWindow.cpp
    )
    list(
        APPEND
        C_SRC
        Common_3/Application/ThirdParty/OpenSource/Fontstash/example/error.c
        Common_3/Application/ThirdParty/OpenSource/Fontstash/example/example.c
        Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/linux/hid.c
        Common_3/Graphics/ThirdParty/OpenSource/volk/volk.c
        Common_3/OS/Linux/LinuxFileSystem.c
        Common_3/OS/Linux/LinuxLog.c
        Common_3/OS/Linux/LinuxThread.c
        Common_3/OS/Linux/LinuxTime.c
        Common_3/OS/Linux/LinuxToolsFileSystem.c
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/hwcaps.c
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_linux_or_android.c
        Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_linux_or_android.c
        Common_3/Utilities/FileSystem/UnixFileSystem.c
    )
endif()

if(APPLE)
    if(IOS)
        set(FSL_LANGUAGES "IOS")
        set(OBJCPP_SRC
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputIos.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDeviceBuiltInIos.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDevicePadIos.mm
            Common_3/OS/Darwin/iOSBase.mm
            Common_3/OS/Darwin/iOSToolsFileSystem.mm
            Common_3/OS/Darwin/iOSWindow.mm
        )
        set(OBJC_SRC Common_3/OS/Darwin/iOSAppDelegate.m)
        list(APPEND C_SRC Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_iOS.c)
    else() # MACOS
        find_library(APPKIT_LIBRARY AppKit)
        find_library(COREFOUNDATION_LIBRARY CoreFoundation)
        find_library(COREGRAPHICS_LIBRARY CoreGraphics)
        find_library(COREVIDEO_LIBRARY CoreVideo)
        find_library(IOKIT_LIBRARY IOKit)
        find_library(METAL_LIBRARY Metal)
        find_library(MPS_LIBRARY MetalPerformanceShaders)
        find_library(QUARTZCORE_LIBRARY QuartzCore)
        find_library(GAMEKIT_LIBRARY GameKit)
        find_library(GAMECONTROLLER_LIBRARY GameController)

        set(FSL_LANGUAGES "MACOS")
        set(OBJCPP_SRC
            Common_3/Application/Fonts/FontSystem.cpp
            Common_3/Application/InputSystem.cpp
            Common_3/Application/Profiler/GpuProfiler.cpp
            Common_3/Application/Profiler/ProfilerBase.cpp
            Common_3/Application/RemoteControl.cpp
            Common_3/Application/Screenshot.cpp
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputMac.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDeviceMouseMac.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDeviceMouseMacRaw.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDevicePadAppleGCKit.mm
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/mouse/GainputInputDeviceMouse.cpp
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePad.cpp
            Common_3/Application/UI/UI.cpp
            Common_3/Game/Scripting/LuaSystem.cpp
            Common_3/Graphics/CommonShaderReflection.cpp
            Common_3/Graphics/GPUConfig.cpp
            Common_3/Graphics/PickRenderingAPI.cpp
            Common_3/Graphics/Metal/MetalRaytracing.mm
            Common_3/Graphics/Metal/MetalRenderer.mm
            Common_3/Graphics/Metal/MetalShaderReflection.mm
            Common_3/Graphics/OpenGLES/EGLContextCreator.cpp
            Common_3/Graphics/OpenGLES/GLES.cpp
            Common_3/Graphics/OpenGLES/GLESShaderReflection.cpp
            Common_3/OS/Darwin/CocoaFileSystem.mm
            Common_3/OS/Darwin/CocoaToolsFileSystem.mm
            Common_3/OS/Darwin/macOSBase.mm
            Common_3/OS/Darwin/macOSWindow.mm
            Common_3/Resources/AnimationSystem/Animation/SkeletonBatcher.cpp
            Common_3/Resources/ResourceLoader/ResourceLoader.cpp
            Common_3/Tools/AssetPipeline/src/AssetPipeline.cpp
            Middleware_3/PaniniProjection/Panini.cpp
            Middleware_3/ParallelPrimitives/ParallelPrimitives.cpp
        )
        list(APPEND CPP_SRC 
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDeviceKeyboardMac.cpp
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputInputDevicePadMac.cpp 
            #Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/pad/GainputInputDevicePad.cpp
        )
        list(
            APPEND
            C_SRC
            Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/hidapi/mac/hid.c
            Common_3/OS/Darwin/DarwinLog.c
            Common_3/OS/Darwin/DarwinThread.c
            Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_iOS.c
            Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_macos.c
            Common_3/Utilities/FileSystem/UnixFileSystem.c
        )
        # All The-Forge's Objective-C++ code should be compiled with Automatic Reference Count (arc)
        set_source_files_properties(${OBJCPP_SRC} PROPERTIES COMPILE_FLAGS "-x objective-c++ -fobjc-arc")
        # Except GainputMac.mm
        set_source_files_properties(Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/apple/GainputMac.mm PROPERTIES COMPILE_FLAGS "-x objective-c++")
        set_source_files_properties(Common_3/Utilities/ThirdParty/OpenSource/rmem/3rd/lz4-r191/lz4.c PROPERTIES COMPILE_FLAGS "-Wno-implicit-function-declaration")
    endif()
endif()

if(ANDROID)
    set(FSL_LANGUAGES "ANDROID")
    list(
        APPEND
        CPP_SRC
        Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/gainput/android/GainputInputDeviceGestureDetectorAndroid.cpp
        Common_3/OS/Android/AndroidBase.cpp
        Common_3/OS/Android/AndroidFileSystem.cpp
        Common_3/OS/Android/AndroidLog.c
        Common_3/OS/Android/AndroidThread.c
        Common_3/OS/Android/AndroidTime.c
        Common_3/OS/Android/AndroidToolsFileSystem.cpp
        Common_3/OS/Android/AndroidWindow.cpp
        Common_3/OS/Android/android_native_app_glue.c
        Common_3/OS/Quest/VrApi.cpp
    )
    list(APPEND C_SRC Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_linux_or_android.c Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_linux_or_android.c)
endif()

set(SRC ${CPP_SRC} ${C_SRC} ${OBJCPP_SRC} ${OBJC_SRC})

add_library(${PROJECT_NAME} STATIC ${SRC})

if(GENERATE_DEBUG_SYMBOLS)
    message(STATUS "Generating debug symbols for ${PROJECT_NAME}")
    if(MSVC)
        target_compile_options(${PROJECT_NAME} PRIVATE /Zi /Oy-)
        target_link_options(${PROJECT_NAME} PRIVATE /DEBUG)
    else()
        target_compile_options(${PROJECT_NAME} PRIVATE -gdwarf-2)
        target_link_options(${PROJECT_NAME} PRIVATE -g)
    endif()
endif()

# apply conan settings for build type, mac universal, etc.
# if we ever migrate the Forge dependencies into conan that should work too but would take a lot of typing
# to update apply_conan()
# since each dependency has to be individually handled in BuildboxConan.cmake as of writing
apply_conan_toolchain(${PROJECT_NAME})

# Suppress compiler warnings
target_compile_options(
    The-Forge
    PUBLIC
        "$<$<CXX_COMPILER_ID:GNU>:-Wno-multichar;-Wno-stringop-overflow;-Wno-builtin-declaration-mismatch;-Wno-int-to-pointer-cast;-Wno-stringop-overread;>"
        "$<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:-Wno-deprecated-declarations;-Wno-deprecated-builtins;-Wno-unqualified-std-cast-call;-Wno-int-to-pointer-cast;>"
        "$<$<CXX_COMPILER_ID:MSVC>:/wd4005;/wd4244;/D_CRT_SECURE_NO_WARNINGS>"
)
if(LINUX)
    set_property(SOURCE ${C_SRC} ${OBJC_SRC} PROPERTY COMPILE_OPTIONS -Wno-implicit-function-declaration)
endif()

target_include_directories(
    The-Forge
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Application/ThirdParty/OpenSource/Fontstash/src/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Application/ThirdParty/OpenSource/gainput/lib/include/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Application/ThirdParty/OpenSource/gainput/lib/source/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Game/ThirdParty/OpenSource/soloud20181119/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Game/ThirdParty/OpenSource/soloud20181119/include/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/include/ozz/geometry/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Resources/AnimationSystem/ThirdParty/OpenSource/ozz-animation/src/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/TaskScheduler/Scheduler/Include/
           ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/basis_universal/transcoder/
)

# Common include directories
target_include_directories(The-Forge PUBLIC $<$<PLATFORM_ID:Windows>:$ENV{VULKAN_SDK}/Include> $<$<PLATFORM_ID:Linux>:${GTK3_INCLUDE_DIRS}>)

# Link libraries for Windows, Linux, and macOS
target_link_libraries(
    The-Forge
    PUBLIC # Windows-specific libraries
           $<$<PLATFORM_ID:Windows>:$ENV{VULKAN_SDK}/Lib/vulkan-1.lib>
           $<$<PLATFORM_ID:Windows>:Xinput>
           $<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/DirectXShaderCompiler/lib/x64/dxcompiler.lib>
           $<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/ags/ags_lib/lib/amd_ags_x64.lib>
           $<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/nvapi/amd64/nvapi64.lib>
           $<$<PLATFORM_ID:Windows>:${CMAKE_CURRENT_SOURCE_DIR}/Common_3/OS/ThirdParty/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.lib>
           # Linux-specific libraries
           $<$<PLATFORM_ID:Linux>:${GTK3_LIBRARIES}>
           $<$<PLATFORM_ID:Linux>:${LIBUDEV_LIBRARIES}>
           $<$<PLATFORM_ID:Linux>:${X11_LIBRARIES}>
           $<$<PLATFORM_ID:Linux>:${XRANDR_LIBRARIES}>
           # macOS-specific libraries (excluding iOS)
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${APPKIT_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${COREFOUNDATION_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${COREGRAPHICS_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${COREVIDEO_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${IOKIT_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${METAL_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${MPS_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${QUARTZCORE_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${GAMEKIT_LIBRARY}>
           $<$<AND:$<PLATFORM_ID:Darwin>,$<NOT:$<PLATFORM_ID:iOS>>>:${GAMECONTROLLER_LIBRARY}>
)

if(BUILD_EXAMPLES)
    tf_add_shaders(Font ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Application/Fonts/Shaders/FSL/Fonts_ShaderList.fsl FALSE)
    tf_add_shaders(PaniniProjection ${CMAKE_CURRENT_SOURCE_DIR}/Middleware_3/PaniniProjection/Shaders/FSL/Panini_ShaderList.fsl FALSE)
    tf_add_shaders(UI ${CMAKE_CURRENT_SOURCE_DIR}/Common_3/Application/UI/Shaders/FSL/UI_ShaderList.fsl FALSE)

    add_dependencies(The-Forge FontShaders PaniniProjectionShaders UIShaders)

    tf_install_unit_tests_resources()
    add_subdirectory(Examples_3/Unit_Tests/src)
endif()

include(GNUInstallDirs)
install(TARGETS The-Forge LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
