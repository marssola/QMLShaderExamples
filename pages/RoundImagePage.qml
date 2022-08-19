import QtQuick
import QtQuick.Controls.Material

import "../components"

ScrollablePage {
    id: page

    title: qsTr("Round Image")
    padding: 5

    Column {
        width: parent.width
        spacing: 20

        RoundImage {
            id: roundImage

            width: page.width - parent.spacing * 2
            height: width

            radius: sliderRadius.value.toFixed(1)
            source: Image {
                property int clipWidth: sliderImageSize.value.toFixed(2)
                property int clipHeight: sliderImageSize.value.toFixed(2)
                property int clipX: clipWidth - roundImage.width
                property int clipY: clipHeight - roundImage.height

                source: "qrc:/QMLShaderExamples/imgs/simon.jpg"
                fillMode: Image.PreserveAspectCrop

                sourceSize.width: clipWidth
                sourceSize.height: clipHeight
                sourceClipRect: Qt.rect(clipX, clipY, roundImage.width, roundImage.height)
            }
        }

        SliderChannel {
            id: sliderRadius

            width: 250
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Border radius: " + sliderRadius.value.toFixed(1))

            slider.from: 0
            slider.to: roundImage.width / 2
            slider.value: 10
            slider.stepSize: 5.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }

        SliderChannel {
            id: sliderImageSize

            width: 250
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Image size: " + sliderImageSize.value.toFixed(2))
            slider.from: roundImage.width
            slider.to: roundImage.width * 1.5
            slider.value: roundImage.width
            slider.stepSize: 10.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }
    }
}
