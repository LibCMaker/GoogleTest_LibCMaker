# ****************************************************************************
#  Project:  LibCMaker
#  Purpose:  A CMake build scripts for build libraries with CMake
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2026 NikitaFeodonit
#
#    This file is part of the LibCMaker project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************


#-----------------------------------------------------------------------
# Library version
#

set(GTest_lib_VERSION "1.17.0" CACHE STRING "GTest_lib_VERSION")
set(GTest_sha256
  "65fab701d9829d38cb77c14acdc431d2108bfdbf8979e40eb8ae567edf10b27c"
  CACHE STRING "GTest_sha256"
)


#-----------------------------------------------------------------------
# Common Google Test and Google Mock options
#

# Note that googlemock target already builds googletest.
option(BUILD_GMOCK "Builds the googlemock subproject" ON)
option(INSTALL_GTEST
  "Enable installation of googletest. (Projects embedding googletest may want to turn this OFF.)"
  ON
)
option(GTEST_HAS_ABSL
  "Use Abseil and RE2. Requires Abseil and RE2 to be separately added to the build."
  OFF
)


#-----------------------------------------------------------------------
# Google Mock options
#

option(gmock_build_tests "Build all of Google Mock's own tests." OFF)


#-----------------------------------------------------------------------
# Google Test options
#

# When other libraries are using a shared version of runtime libraries,
# Google Test also has to use one.
option(gtest_force_shared_crt
  "Use shared (DLL) run-time lib even when Google Test is built as static lib."
  OFF
)

option(gtest_build_tests "Build all of gtest's own tests." OFF)

option(gtest_build_samples "Build gtest's sample programs." OFF)

option(gtest_disable_pthreads "Disable uses of pthreads in gtest." OFF)

option(gtest_hide_internal_symbols
  "Build gtest with internal symbols hidden in shared libraries."
  OFF
)


#-----------------------------------------------------------------------
# Unpack, configure and build the required libraries
#

include(FetchContent)

FetchContent_Declare(
  GTest
  URL ${CMAKE_CURRENT_LIST_DIR}/source/googletest-${GTest_lib_VERSION}.tar.gz
  URL_HASH SHA256=${GTest_sha256}
  OVERRIDE_FIND_PACKAGE
)

# From https://google.github.io/googletest/quickstart-cmake.html#set-up-a-project
# For Windows: Prevent overriding the parent project's compiler/linker settings
#set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(GTest)
