import QtQuick
import QtQuick.Controls.Material

import "../components"

Page {
    id: page

    title: qsTr("Color Channel")

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

                source: "qrc:/App/imgs/simon.jpg"
            }

            ShaderEffect {
                id: effect

                width: sourceImage.width
                height: width

                property variant source: sourceImage
                property real redChannel: redChannelSlider.value
                property real greenChannel: greenChannelSlider.value
                property real blueChannel: blueChannelSlider.value

                fragmentShader: "/shaders/colorChannel.frag.qsb"
                vertexShader: "/shaders/colorChannel.vert.qsb"
            }
        }

        Row {
            id: rowSliders

            property int itemWidth: (width / 3) - spacing

            width: parent.width >= 500 ? 500 : parent.width
            spacing: 20
            anchors.horizontalCenter: parent.horizontalCenter

            SliderChannel {
                id: redChannelSlider

                width: rowSliders.itemWidth
                text: qsTr("Red channel: " + redChannelSlider.value.toFixed(2))
                runningAnimation: checkBoxRed.checked
            }

            SliderChannel {
                id: greenChannelSlider

                width: rowSliders.itemWidth
                text: qsTr("Green channel: " + greenChannelSlider.value.toFixed(2))
                runningAnimation: checkBoxGreen.checked
            }

            SliderChannel {
                id: blueChannelSlider

                width: rowSliders.itemWidth
                text: qsTr("Blue channel: " + blueChannelSlider.value.toFixed(2))
                runningAnimation: checkBoxBlue.checked
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            Column {
                ButtonGroup {
                    id: childGroup
                    exclusive: false
                    checkState: parentBox.checkState
                }

                CheckBox {
                    id: parentBox
                    text: qsTr("Channel Animation")
                    checkState: childGroup.checkState
                }

                CheckBox {
                    id: checkBoxRed
                    text: qsTr("Red")
                    leftPadding: indicator.width
                    ButtonGroup.group: childGroup
                }

                CheckBox {
                    id: checkBoxGreen
                    text: qsTr("Green")
                    leftPadding: indicator.width
                    ButtonGroup.group: childGroup
                }

                CheckBox {
                    id: checkBoxBlue
                    text: qsTr("Blue")
                    leftPadding: indicator.width
                    ButtonGroup.group: childGroup
                }
            }
        }
    }
}
