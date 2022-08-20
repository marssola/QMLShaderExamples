import QtQuick
import QtQuick.Controls.Material

import "../components"

ScrollablePage {
    id: page

    title: qsTr("Blur Effect")
    padding: 5

    Column {
        width: parent.width
        spacing: 20

        RoundItem {
            id: roundItem

            width: page.width - parent.spacing * 2
            height: width

            radius: sliderBorderRadius.value.toFixed(1)
            source: ItemBlur {
                id: itemBlur

                width: roundItem.width
                height: width
                radius: sliderRadius.value.toFixed(1)
                source: Image {
                    source: "qrc:/QMLShaderExamples/imgs/simon.jpg"
                    sourceSize.width: itemBlur.remap(itemBlur.radius, sliderRadius.slider.to, sliderRadius.slider.from, 10, itemBlur.width)
                    sourceSize.height: itemBlur.remap(itemBlur.radius, sliderRadius.slider.to, sliderRadius.slider.from, 10, itemBlur.height)
                }
            }
        }

        ItemBlur {
            id: itemBlur2

            width: parent.width - parent.spacing * 2
            height: 200

            radius: sliderRadius.value.toFixed(1)
            source:  Item {
                id: layered

                width: itemBlur2.width
                height: itemBlur2.height

                layer.enabled: true

                Rectangle {
                    id: rectangle1
                    x: 30
                    y: 50
                    width: 80
                    height: 80
                    radius: sliderBorderRadius.value.toFixed(1)

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "lightsteelblue" }
                        GradientStop { position: 1.0; color: "darkgrey" }
                    }

                    ParallelAnimation {
                        running: true
                        loops: Animation.Infinite

                        SequentialAnimation {
                            NumberAnimation { target: rectangle1; property: "x"; from: 30; to: 200; duration: 1800 }
                            NumberAnimation { target: rectangle1; property: "x"; from: 200; to: 30; duration: 1800 }
                        }

                        SequentialAnimation {
                            NumberAnimation { target: rectangle1; property: "rotation"; from: 0; to: 360; duration: 1800 }
                            NumberAnimation { target: rectangle1; property: "rotation"; from: 360; to: 0; duration: 1800 }
                        }
                    }
                }

                Rectangle {
                    id: rectangle2
                    x: 20
                    y: 20
                    width: 80
                    height: 80
                    radius: sliderBorderRadius.value.toFixed(1)

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "lightsteelblue" }
                        GradientStop { position: 1.0; color: "blue" }
                    }

                    ParallelAnimation {
                        running: true
                        loops: Animation.Infinite

                        SequentialAnimation {
                            NumberAnimation { target: rectangle2; property: "x"; from: 20; to: 300; duration: 2500 }
                            NumberAnimation { target: rectangle2; property: "x"; from: 300; to: 20; duration: 2500 }
                        }

                        SequentialAnimation {
                            NumberAnimation { target: rectangle2; property: "y"; from: 20; to: 120; duration: 2500 }
                            NumberAnimation { target: rectangle2; property: "y"; from: 120; to: 20; duration: 2500 }
                        }

                        SequentialAnimation {
                            NumberAnimation { target: rectangle2; property: "rotation"; from: 0; to: 360; duration: 2500 }
                            NumberAnimation { target: rectangle2; property: "rotation"; from: 360; to: 0; duration: 2500 }
                        }
                    }
                }
            }
        }

        SliderChannel {
            id: sliderRadius

            width: 250
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Radius: " + sliderRadius.value.toFixed(2))

            slider.from: 0
            slider.to: 64.0
            slider.value: 0.0
            slider.stepSize: 1.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }

        SliderChannel {
            id: sliderBorderRadius

            width: 250
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Border radius: " + sliderBorderRadius.value.toFixed(1))

            slider.from: 0
            slider.to: itemBlur.width / 2
            slider.value: 10
            slider.stepSize: 1.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }
    }
}
