import QtQuick
import QtQuick.Controls

Item {
    id: control

    property variant source
    property real radius: 0.0
    property real direction: 16.0
    property real quality: 3.0

    ShaderEffectSource {
        id: effectSource

        width: control.width
        height: control.height

        visible: false
        sourceItem: control.source
        hideSource: control.visible
        smooth: true
    }

    ShaderEffect {
        id: effect

        property variant source: effectSource
        property real radius: control.radius
        property real direction: control.direction
        property real quality: control.quality

        width: control.width
        height: control.height

        fragmentShader: "/shaders/blurImage.frag.qsb"
        vertexShader: "/shaders/blurImage.vert.qsb"
    }
}
