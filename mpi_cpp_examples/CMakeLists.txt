project (hello)

cmake_minimum_required(VERSION 2.8.9)

# Set the output folder where your program will be created
set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/bin)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(CMAKE_BUILD_TYPE Release)


#### MPI

find_package(MPI REQUIRED)
if (MPI_FOUND)
    include_directories(SYSTEM ${MPI_INCLUDE_PATH})
else (MPI_FOUND)
    message(SEND_ERROR "This application cannot compile without MPI")
endif (MPI_FOUND)


#aux_source_directory(. dir_srcs)

#add_executable(hello ${dir_srcs})
add_executable(hello hello.cpp)

target_include_directories(hello PRIVATE ${MPI_CXX_INCLUDE_PATH})
target_link_libraries(hello ${MPI_CXX_LIBRARIES})


