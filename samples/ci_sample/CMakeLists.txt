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

set(LibCMaker_LIB_DIR "${CMAKE_CURRENT_LIST_DIR}/libs")
set(LibCMaker_DIR "${LibCMaker_LIB_DIR}/LibCMaker")

include("${LibCMaker_DIR}/cmake/cmr_get_cmake_min_ver.cmake" NO_POLICY_SCOPE)
cmr_get_cmake_min_ver()
cmake_minimum_required(VERSION ${cmr_CMAKE_MIN_VER})

include("${LibCMaker_DIR}/samples/cmr_samples_common_macros.cmake")
cmr_common_sample_part__before_project()

project(GoogleTest_LibCMaker_Compile_Test CXX)

cmr_common_sample_part__project_settings()

# Used only for executables.
#cmr_common_sample_part__add_executable()


#-----------------------------------------------------------------------
# Unpack, configure, build and find the required libraries
#-----------------------------------------------------------------------

# Google Test lib is working in `cmr_common_sample_part__project_settings()`.


#-----------------------------------------------------------------------
# Build the test library
#-----------------------------------------------------------------------

set(example_src_DIR "${CMAKE_CURRENT_LIST_DIR}/src")

add_library(${PROJECT_NAME}
    ${example_src_DIR}/sample1.h
    ${example_src_DIR}/sample1.cc
)

cmr_common_sample_part__set_cxx_c_standards()

if(BUILD_SHARED_LIBS AND WIN32 AND NOT MINGW)
  target_compile_definitions(${PROJECT_NAME}
    PRIVATE
      "SAMPLE_EXTERN=__declspec(dllexport) extern")
endif()


#-----------------------------------------------------------------------
# Testing
#-----------------------------------------------------------------------

cmr_common_test_part__add_subdirectory_test()
