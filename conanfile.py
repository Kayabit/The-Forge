from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout, CMakeDeps
from conan.tools.files import copy
from conan.errors import ConanInvalidConfiguration
import os

class BuildboxForgeConanfile(ConanFile):
    name = "BuildboxForge"
    version = "0.2"
    package_type = "library"

    # Optional metadata
    license = "custom"
    author = "Buildbox Developers"

    # Binary configuration
    settings = "os", "build_type", "arch"
    # see notes in Potion conanfile.py about this
    #options = {"mac_universal": [True, False], "shared": [True, False]}
    #default_options = {"mac_universal": False, "shared": False}

    def configure(self):
        pass

    def requirements(self):
        # Forge does HAVE dependencies, but they're handled manually in their repo, not in this minimal conan config piece
        pass

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()
        tc = CMakeToolchain(self)
        #if self.settings.os == 'Macos' and self.options.mac_universal:
        #    # NB: apparently conan doesn't respect well the CMAKE_OSX_ARCHITECTURES setting, so you have to use this 'feature'
        #    tc.blocks["apple_system"].values["cmake_osx_architectures"] = "x86_64;arm64"
        tc.generate()
