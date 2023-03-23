cmake_minimum_required(VERSION 3.0)

project(Monopoly)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
add_executable(monopoly main.cpp
    board.cpp
    die.cpp
    game.cpp
    player.cpp
    square.cpp
    go_square.cpp
    property_square.cpp
    other_square.cpp
    lot_square.cpp
    railroad_square.cpp
    utility_square.cpp)

target_include_directories(monopoly PUBLIC "${PROJECT_SOURCE_DIR}/includes")
