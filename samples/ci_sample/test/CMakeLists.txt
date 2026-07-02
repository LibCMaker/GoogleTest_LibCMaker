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

# Testing with Google Test.
if(BUILD_TESTING)
  cmr_common_test_part__set_test_name()
  cmr_common_test_part__add_executable()
  cmr_common_test_part__android__init()
  cmr_common_test_part__android__push_shared_libs()

  cmr_common_test_part__android__push_test_lib()

  cmr_common_test_part__android__push_test_exe()
  cmr_common_test_part__android__run_test()
  cmr_common_test_part__ios()
  cmr_common_test_part__set_common_tests_properties()

  target_sources(${test_NAME}
    PRIVATE
      ${test_src_DIR}/sample1_unittest.cc
  )
  set_target_properties(${test_NAME} PROPERTIES
    CXX_STANDARD 11
    C_STANDARD 11
  )

  # Our lib for testing.
  target_link_libraries(${test_NAME} PRIVATE
    ${PROJECT_NAME}
  )
endif()


#-----------------------------------------------------------------------
# FailTest
#-----------------------------------------------------------------------

if(BUILD_TESTING AND NOT ANDROID AND NOT IOS)
  set(test_NAME "FailTest")

  cmr_common_test_part__add_executable()

  target_sources(${test_NAME}
    PRIVATE
      ${test_src_DIR}/fail-test.cpp
  )
  set_target_properties(${test_NAME} PROPERTIES
    CXX_STANDARD 11
    C_STANDARD 11
  )

  set_tests_properties(${test_NAME} PROPERTIES
    PASS_REGULAR_EXPRESSION "\\[  FAILED  \\] FailTest.FailTest"
  )
endif()
