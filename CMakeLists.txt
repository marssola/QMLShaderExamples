cmake_minimum_required(VERSION 3.16)

project(QMLShaderExamples VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 COMPONENTS ShaderTools)

if (ANDROID)
    include(/opt/Android/Sdk/android_openssl/CMakeLists.txt)
endif()

set(PROJECT ShadersExample)

qt_add_executable(${PROJECT}
    main.cpp
)

qt_add_qml_module(${PROJECT}
    URI QMLShaderExamples
    VERSION 1.0
    RESOURCES
        imgs/simon.jpg
        shaders/colorChannel.vert
        shaders/colorChannel.frag
        shaders/waveEffect.frag
        shaders/genieEffect.vert
        shaders/roundItem.frag
        shaders/itemBlur.frag
        shaders/fastblur.frag
    QML_FILES
        main.qml
        pages/ColorChannelPage.qml
        pages/WaveEffectPage.qml
        pages/GenieEffectPage.qml
        pages/RoundImagePage.qml
        pages/BlurPage.qml
        components/SliderChannel.qml
        components/GenieEffect.qml
        components/RoundItem.qml
        components/ScrollablePage.qml
        components/ItemBlur.qml
)

qt_add_shaders(${PROJECT} "shaders"
    GLSL    "100es,120,150"
    HLSL    "50"
    MSL     "12"
    PREFIX  "/"
    FILES
        shaders/colorChannel.vert
        shaders/colorChannel.frag
        shaders/waveEffect.frag
        shaders/genieEffect.vert
        shaders/roundItem.frag
        shaders/itemBlur.frag
        shaders/fastblur.frag
)

set_target_properties(${PROJECT} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(${PROJECT}
    PRIVATE Qt6::Quick)

set_property(TARGET ${PROJECT}
    PROPERTY QT_ANDROID_EXTRA_LIBS
        ${ANDROID_EXTRA_LIBS}
)

install(TARGETS ${PROJECT}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
