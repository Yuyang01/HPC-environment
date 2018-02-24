# Specify the minimum version for CMake

cmake_minimum_required(VERSION 2.8)

# Project's name

project(main)

# Set the output folder where your program will be created
#set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/bin)
#set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
#set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})
#set(CMAKE_BUILD_TYPE Release)

# use c++11 
#method 1: 
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED on)

#method 2:
#SET ( CMAKE_CXX_FLAGS "-std=c++0x" CACHE STRING "compile flags" FORCE)

#method 3:
#add_compile_options(-std=c++0x)

#method 4:
#if(CMAKE_COMPILER_IS_GNUCXX)
   # set(CMAKE_CXX_FLAGS " ${CMAKE_CXX_FLAGS} -std=c++11")
   # message(STATUS "optional:-std=c++11")   
#endif(CMAKE_COMPILER_IS_GNUCXX)


# find armadillo
find_package(Armadillo REQUIRED)
if(ARMADILLO_FOUND)
   include_directories(${ARMADILLO_INCLUDE_DIRS})
   message(STATUS "ARMADILLO_INCLUDE_DIRS= ${ARMADILLO_INCLUDE_DIRS}")
else(ARMADILLO_FOUND)
   message(STATUS "ERROR: Armadillo could not be found.")
endif(ARMADILLO_FOUND)

# find openmp
find_package(OpenMP REQUIRED)
if (OPENMP_FOUND)
    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}") #${OpenMP_CXX_FLAGS}
    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
endif()


file(GLOB SOURCES "*.cpp")

add_executable(main ${SOURCES})

#link armadillo library
target_link_libraries(main ${ARMADILLO_LIBRARIES})


