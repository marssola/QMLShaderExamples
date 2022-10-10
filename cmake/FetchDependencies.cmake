include(FetchContent)

function(FetchDependencies DEPENDENCY_PKG)
    message(STATUS "Fetch dependency: ${DEPENDENCY_PKG}")

    set(oneValueArgs REPOSITORY BRANCH TARGET)
    cmake_parse_arguments(FetchDependencies "" "${oneValueArgs}" "" ${ARGN})
    set(REPOSITORY ${FetchDependencies_REPOSITORY})
    set(BRANCH ${FetchDependencies_BRANCH})
    set(TARGET ${FetchDependencies_TARGET})

    message(STATUS "Downloading from ${REPOSITORY} - ${BRANCH}")
    if (NOT REPOSITORY OR NOT BRANCH OR NOT TARGET)
        message(WARNING "Repository, branch or target not defined for ${DEPENDENCY_PKG}")
        return()
    endif()

    FetchContent_Declare(${DEPENDENCY_PKG}
        GIT_REPOSITORY ${REPOSITORY}
        GIT_TAG ${BRANCH}
    )
    FetchContent_MakeAvailable(${DEPENDENCY_PKG})
    string(TOLOWER ${DEPENDENCY_PKG}-build DEPENDENCY_BUILD)
    set(DEPENDENCY_BUILD_PATH ${FETCHCONTENT_BASE_DIR}/${DEPENDENCY_BUILD})

    if (NOT ANDROID)
        add_custom_command(
            TARGET ${TARGET} POST_BUILD
            COMMAND ${CMAKE_COMMAND} -E copy_directory
                ${DEPENDENCY_BUILD_PATH}
                ${CMAKE_BINARY_DIR}/
        )
    else ()
        list(APPEND QT_QML_IMPORT_PATH ${DEPENDENCY_BUILD_PATH})
    endif()
endfunction()
