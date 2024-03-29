import traceback
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
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}    

    def configure(self):
        pass

    def requirements(self):
        # Forge does HAVE dependencies, but they're handled manually in their repo, not in this minimal conan config piece
        pass

    def generate(self):
        try:
            deps = CMakeDeps(self)
            deps.generate()
            tc = CMakeToolchain(self)
            tc.generate()
        except Exception as e:
            print(f"Error in forge conanfile generate(): {e}")
            traceback.print_exc()
            raise e
