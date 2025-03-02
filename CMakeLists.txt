cmake_minimum_required(VERSION 3.20.0)

project(braket-dialect LANGUAGES CXX C)
add_link_options("-fuse-ld=lld")

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")

set(CMAKE_BUILD_WITH_INSTALL_NAME_DIR ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_DEPS ON)

message(STATUS "CMAKE SRC DIR in: ${CMAKE_SOURCE_DIR}")
message(STATUS "CMAKE CURRENT SRC DIR in: ${CMAKE_CURRENT_SOURCE_DIR}")


find_package(MLIR REQUIRED CONFIG)

message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")


include(TableGen)
include(AddLLVM)
include(HandleLLVMOptions)
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(AddMLIR)

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR})
# include_directories(${PROJECT_SOURCE_DIR}/externals/llvm-project)
include_directories(${PROJECT_SOURCE_DIR}/../llvm-project)
include_directories(${PROJECT_BINARY_DIR})


message(STATUS "Using LLVM Include Dirs in: ${LLVM_INCLUDE_DIRS}")
message(STATUS "Using LLVM CMAKE Dirs in: ${LLVM_CMAKE_DIR}")
message(STATUS "Using MLIR Include Dirs in: ${MLIR_INCLUDE_DIRS}")
message(STATUS "Using MLIR CMAKE Dirs in: ${MLIR_CMAKE_DIR}")
message(STATUS "Using Project SRC Dirs in: ${PROJECT_SOURCE_DIR}")
message(STATUS "Using Project BIN Dirs in: ${PROJECT_BINARY_DIR}")


include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${PROJECT_BINARY_DIR}/include)
link_directories(${LLVM_BUILD_LIBRARY_DIR})
link_directories(${LLVM_LIBRARY_DIR})
add_definitions(${LLVM_DEFINITIONS})

message(STATUS "Linking: LLVM BUILD LIB Dirs in: ${LLVM_BUILD_LIBRARY_DIR}")
message(STATUS "Definitions: LLVM Definitions are: ${LLVM_DEFINITIONS}")
message(STATUS "Linking: LLVM  LIB Dir in: ${LLVM_LIBRARY_DIR}")


add_subdirectory(include)
#add_subdirectory(lib)


# =================

set(LLVM_LINK_COMPONENTS
  Support
  )

add_executable(toyc
    toyc.cpp parser/AST.cpp mlir/Dialect.cpp mlir/MLIRGen.cpp)

target_link_libraries(toyc
    PRIVATE
      MLIRAnalysis
      MLIRFunctionInterfaces
      MLIRIR
      MLIRParser
      MLIRSideEffectInterfaces
      MLIRTransforms)
