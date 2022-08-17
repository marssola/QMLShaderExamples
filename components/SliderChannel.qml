import QtQuick
import QtQuick.Controls.Material

Column {
    id: control

    property alias slider: channel
    property alias value: channel.value
    property alias text: label.text
    property bool runningAnimation: false
    property bool enabledAnimationAsc: true
    property bool enabledAnimationDesc: true
    property int durationAnimation: 2000

    spacing: 5

    Slider {
        id: channel

        enabled: !control.runningAnimation
        width: parent.width

        from: 0
        to: 1.0
        value: channel.to
    }

    Label {
        id: label
        width: parent.width
    }

    SequentialAnimation {
        running: control.runningAnimation
        loops: Animation.Infinite

        NumberAnimation {
            target: channel
            property: "value"

            from: control.enabledAnimationAsc ? channel.from : channel.value
            to: control.enabledAnimationAsc ? channel.to : channel.value
            duration: control.enabledAnimationAsc ? control.durationAnimation : 0
        }

        NumberAnimation {
            target: channel
            property: "value"

            from: control.enabledAnimationDesc ? channel.to : channel.value
            to: control.enabledAnimationDesc ? channel.from : channel.value
            duration: control.enabledAnimationDesc ? control.durationAnimation : 0
        }
    }
}
