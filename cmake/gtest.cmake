INCLUDE(ExternalProject)

SET(GTEST_SOURCES_DIR ${THIRD_PARTY_PATH}/gtest)
SET(GTEST_INSTALL_DIR ${THIRD_PARTY_PATH}/install/gtest)
SET(GTEST_INCLUDE_DIR "${GTEST_INSTALL_DIR}/include" CACHE PATH "gtest include directory." FORCE)
SET(GTEST_LIBRARIES "${GTEST_INSTALL_DIR}/lib/libgtest.a" CACHE FILEPATH "gtest library." FORCE)

INCLUDE_DIRECTORIES(${GTEST_INCLUDE_DIR})

set(prefix_path "${THIRD_PARTY_PATH}/install/gflags")

SET(gflags_BUILD_STATIC_LIBS ON)

ExternalProject_Add(
        extern_gtest
        ${EXTERNAL_PROJECT_LOG_ARGS}
        DEPENDS gflags
        GIT_REPOSITORY "https://github.com/google/googletest.git"
        GIT_TAG "master"
        PREFIX ${GTEST_SOURCES_DIR}
        UPDATE_COMMAND ""
        CMAKE_ARGS -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
        -DCMAKE_CXX_FLAGS_RELEASE=${CMAKE_CXX_FLAGS_RELEASE}
        -DCMAKE_CXX_FLAGS_DEBUG=${CMAKE_CXX_FLAGS_DEBUG}
        -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
        -DCMAKE_C_FLAGS_DEBUG=${CMAKE_C_FLAGS_DEBUG}
        -DCMAKE_C_FLAGS_RELEASE=${CMAKE_C_FLAGS_RELEASE}
        -DCMAKE_INSTALL_PREFIX=${GTEST_INSTALL_DIR}
        -DCMAKE_INSTALL_LIBDIR=${GTEST_INSTALL_DIR}/lib
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DBUILD_GMOCK=OFF
        -DCMAKE_BUILD_TYPE=${THIRD_PARTY_BUILD_TYPE}
        -DCMAKE_PREFIX_PATH=${prefix_path}
        ${EXTERNAL_OPTIONAL_ARGS}
)

ADD_LIBRARY(gtest STATIC IMPORTED GLOBAL)
SET_PROPERTY(TARGET gtest PROPERTY IMPORTED_LOCATION ${GTEST_LIBRARIES})
ADD_DEPENDENCIES(gtest extern_gtest)