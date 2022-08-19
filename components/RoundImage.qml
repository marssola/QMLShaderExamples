import QtQuick
import QtQuick.Controls

Item {
    id: control

    property variant source
    property real radius: 0.0

    ShaderEffectSource {
        id: shaderSource

        width: control.width
        height: control.height

        visible: false
        sourceItem: control.source
        hideSource: control.visible
        smooth: true
    }

    ShaderEffect {
        id: effect

        property variant source: shaderSource
        property variant mask: maskRectangle

        width: control.width
        height: control.height

        fragmentShader: "/shaders/roundImage.frag.qsb"
        vertexShader: "/shaders/roundImage.vert.qsb"

        /*
        Image {
            id: sourceImage
            visible: false

            width: effect.width
            height: effect.height

            sourceSize.width: control.clipWidth
            sourceSize.height: control.clipHeight
            sourceClipRect: Qt.rect(control.clipX, control.clipY, sourceImage.width, sourceImage.height)

            layer.enabled: true
        }
        */

        Rectangle {
            id: maskRectangle

            visible: false
            width: parent.width
            height: parent.height

            layer.enabled: true
            radius: control.radius
        }
    }
}
