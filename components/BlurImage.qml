import QtQuick
import QtQuick.Controls

Item {
    id: control

    property variant source
    property real radius: 0.0

    ShaderEffectSource {
        id: effectSource1

        width: control.width
        height: control.height

        visible: false
        sourceItem: control.source
        hideSource: control.visible
        smooth: true
    }

    ShaderEffect {
        id: effect1

        property variant source: effectSource1
        property real radius: control.radius

        width: control.width
        height: control.height

        fragmentShader: "/shaders/fastblur.frag.qsb"
    }
}
