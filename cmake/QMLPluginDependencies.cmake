include(FetchContent)

FetchContent_Declare(
    RaskShaderEffects
    GIT_REPOSITORY https://github.com/rask-project/ShaderEffects.git
    GIT_TAG main
)
FetchContent_MakeAvailable(RaskShaderEffects)
set(RASK_SHADER_EFFECTS_PATH ${FETCHCONTENT_BASE_DIR}/raskshadereffects-build)
list(APPEND QT_QML_IMPORT_PATH ${RASK_SHADER_EFFECTS_PATH})

if (NOT ANDROID)
    add_custom_command(
        TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_directory
            ${RASK_SHADER_EFFECTS_PATH}
            ${CMAKE_BINARY_DIR}/
    )
endif()
