cmake_minimum_required(VERSION 3.16)

project(QMLShaderExamples VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(FetchDependencies)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 COMPONENTS ShaderTools)

list(GET CMAKE_PREFIX_PATH 0 QT_PREFIX_PATH)
list(APPEND QT_QML_IMPORT_PATH ${QT_PREFIX_PATH}/qml)
list(REMOVE_DUPLICATES QT_QML_IMPORT_PATH)

if (ANDROID)
    list(APPEND QT_QML_IMPORT_PATH ${CMAKE_BINARY_DIR}/android-qml)
    include(/opt/Android/Sdk/android_openssl/CMakeLists.txt)
endif()

qt_add_executable(${PROJECT_NAME}
    main.cpp
)

FetchDependencies(RaskShaderEffects
    REPOSITORY https://github.com/rask-project/ShaderEffects.git
    BRANCH 1.0.0
    TARGET ${PROJECT_NAME}
)

qt_add_qml_module(${PROJECT_NAME}
    URI App
    VERSION 1.0
    RESOURCES
        imgs/simon.jpg
        shaders/colorChannel.vert
        shaders/colorChannel.frag
        shaders/waveEffect.frag
    QML_FILES
        main.qml
        pages/ColorChannelPage.qml
        pages/WaveEffectPage.qml
        pages/GenieEffectPage.qml
        pages/RoundImagePage.qml
        pages/BlurPage.qml
        components/SliderChannel.qml
        components/ScrollablePage.qml
)

qt_add_shaders(${PROJECT_NAME} "shaders"
    GLSL    "100es,120,150"
    HLSL    "50"
    MSL     "12"
    PREFIX  "/"
    FILES
        shaders/colorChannel.vert
        shaders/colorChannel.frag
        shaders/waveEffect.frag
)

set_target_properties(${PROJECT_NAME} PROPERTIES
    QT_QML_IMPORT_PATH "${QT_QML_IMPORT_PATH}"
    QT_ANDROID_EXTRA_LIBS "${ANDROID_EXTRA_LIBS}"
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt6::Quick
)
