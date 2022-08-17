import QtQuick
import QtQuick.Controls.Material

import "../components"

Page {
    id: page

    title: qsTr("Wave Effect")

    Column {
        width: parent.width
        spacing: 20

        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 250
            height: width

            Image {
                id: sourceImage

                visible: false
                width: parent.width
                height: width

                source: "https://st2.depositphotos.com/6544740/9337/i/600/depositphotos_93376372-stock-photo-sunset-over-sea-pier.jpg"
            }

            ShaderEffect {
                id: effect

                property variant source: sourceImage
                property real frequency: sliderFrequency.value.toFixed(2)
                property real amplitude: sliderAmplitude.value.toFixed(2)
                property real time: sliderTime.value.toFixed(2)

                enabled: sourceImage.status === Image.Ready
                width: sourceImage.width
                height: width

                fragmentShader: "/shaders/waveEffect.frag.qsb"

                BusyIndicator {
                    visible: !effect.enabled
                    anchors.centerIn: parent
                }
            }
        }

        Row {
            id: rowControls

            property int itemWidth: (width / 3) - spacing

            width: parent.width >= 500 ? 500 : parent.width
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            SliderChannel {
                id: sliderFrequency

                width: rowControls.itemWidth

                text: qsTr("Frequency: " + sliderFrequency.value.toFixed(2))

                slider.from: 0
                slider.to: 8.0
                runningAnimation: checkBoxFrequency.checked
            }

            SliderChannel {
                id: sliderAmplitude

                width: rowControls.itemWidth

                text: qsTr("Amplitude: " + sliderAmplitude.value.toFixed(2))
                slider.to: 0.1
                runningAnimation: checkBoxAmplitude.checked
            }

            SliderChannel {
                id: sliderTime

                width: rowControls.itemWidth

                text: qsTr("Time: " + sliderTime.value.toFixed(2))
                slider.to: Math.PI * 2
                enabledAnimationDesc: false
                runningAnimation: checkBoxTime.checked
                durationAnimation: 1000
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5
            enabled: sourceImage.status === Image.Ready

            Column {
                ButtonGroup {
                    id: childGroup
                    exclusive: false
                    checkState: parentBox.checkState
                }

                CheckBox {
                    id: parentBox
                    text: qsTr("Wave Animation")
                    checkState: childGroup.checkState
                }

                CheckBox {
                    id: checkBoxFrequency
                    text: qsTr("Frequency")
                    leftPadding: indicator.width
                    ButtonGroup.group: childGroup
                }

                CheckBox {
                    id: checkBoxAmplitude
                    text: qsTr("Amplitude")
                    leftPadding: indicator.width
                    ButtonGroup.group: childGroup
                }

                CheckBox {
                    id: checkBoxTime

                    text: qsTr("Time")
                    leftPadding: indicator.width
                    ButtonGroup.group: childGroup
                    checked: true
                }
            }
        }
    }
}
