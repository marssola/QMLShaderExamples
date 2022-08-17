import QtQuick
import QtQuick.Controls

Item {
    id: control

    property alias image: sourceImage
    property real radius: 0.0
    property int clipWidth: sourceImage.width
    property int clipHeight: sourceImage.height
    property int clipX: control.clipWidth - control.width
    property int clipY: control.clipHeight - control.height

    ShaderEffect {
        id: effect

        property variant source: sourceImage
        property variant mask: maskRectangle

        width: control.width
        height: control.height

        fragmentShader: "/shaders/roundImage.frag.qsb"
        vertexShader: "/shaders/roundImage.vert.qsb"

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

        Rectangle {
            id: maskRectangle

            visible: false
            width: parent.width
            height: parent.height

            layer.enabled: true
            radius: control.radius
        }

        BusyIndicator {
            enabled: visible
            visible: sourceImage.status === Image.Loading
            anchors.centerIn: parent
        }

        ProgressBar {
            visible: sourceImage.status === Image.Loading
            width: parent.width
            from: 0.0
            to: 1.0
            value: sourceImage.progress
        }
    }
}
