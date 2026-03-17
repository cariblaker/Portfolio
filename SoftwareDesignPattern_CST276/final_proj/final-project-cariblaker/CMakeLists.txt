cmake_minimum_required(VERSION 3.21)
project(final_proj LANGUAGES CXX)

include(FetchContent)
FetchContent_Declare(SFML
    GIT_REPOSITORY https://github.com/SFML/SFML.git
    GIT_TAG 2.6.x)
FetchContent_MakeAvailable(SFML)

add_executable(final_proj src/main.cpp src/enemyGraphicsComponent.cpp src/enemyPhysicsComponent.cpp src/playerGraphicsComponent.cpp src/playerInputComponent.cpp src/playerPhysicsComponent.cpp src/bulletGraphicsComponent.cpp src/bulletPhysicsComponent.cpp src/angryInputComponent.cpp src/angryPhysicsComponent.cpp)
target_link_libraries(final_proj PRIVATE sfml-graphics)
target_compile_features(final_proj PRIVATE cxx_std_20)
if (WIN32 AND BUILD_SHARED_LIBS)
    add_custom_command(TARGET final_proj POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:final_proj> $<TARGET_FILE_DIR:final_proj> COMMAND_EXPAND_LISTS)
endif()

install(TARGETS final_proj)
