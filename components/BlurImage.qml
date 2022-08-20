import QtQuick
import QtQuick.Controls

Item {
    id: control

    property variant source
    property real radius: 0.0

    ShaderEffect {
        id: effect1

        property variant source: control.source
        property real radius: control.radius
        property variant resolution: Qt.size(width, height)

        width: control.width
        height: control.height

        fragmentShader: "/shaders/blurImage.frag.qsb"
    }
}
