cmake_minimum_required(VERSION 3.20)
enable_testing()
include(cmake/Ruler.cmake)

project(Ruler VERSION 0.1.3 LANGUAGES C CXX)

if(NOT TARGET ${PROJECT_NAME})
    ae2f_CoreUtilityDocTent(Ruler cmake ae2f)
    add_library(${PROJECT_NAME} INTERFACE)
endif()