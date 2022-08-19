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

        BlurImage {
            id: blurImage

            width: parent.width - parent.spacing * 2
            height: width
            anchors.horizontalCenter: parent.horizontalCenter

            radius: sliderRadius.value.toFixed(1)
            quality: sliderQuality.value.toFixed(2)
            direction: sliderDirection.value.toFixed(2)
            source: Image {
                source: "qrc:/QMLShaderExamples/imgs/simon.jpg"
            }

            //image.source: "https://www.2net.com.br//Repositorio/251/Publicacoes/23883/3c2fd25f-c.jpg"
        }

        SliderChannel {
            id: sliderRadius

            width: 250
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Radius: " + sliderRadius.value.toFixed(2))

            slider.from: 0
            slider.to: 128.0
            slider.value: 8.0
            slider.stepSize: 1.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }

        SliderChannel {
            id: sliderDirection

            width: 250
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Direction: " + sliderDirection.value.toFixed(2))

            slider.from: 16.0
            slider.to: 64.0
            slider.value: 16.0
            slider.stepSize: 1.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }

        SliderChannel {
            id: sliderQuality

            width: 250
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Quality: " + sliderQuality.value.toFixed(2))

            slider.from: 3.0
            slider.to: 20.0
            slider.value: 3.0
            slider.stepSize: 1.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }
    }
}
