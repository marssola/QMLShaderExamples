import QtQuick
import QtQuick.Controls.Material

import Rask.ShaderEffects
import "../components/" as Components

Page {
    id: page

    title: qsTr("Blur Effect")
    padding: 0

    ItemBlur {
        id: itemBlur

        width: page.width
        height: page.height

        radius: sliderRadius.slider.value
        maxRadius: sliderRadius.slider.to
        source: Image {
            width: page.width
            height: page.height

            source: "qrc:/App/imgs/simon.jpg"
            fillMode: Image.PreserveAspectCrop
        }
    }

    Rectangle {
        width: 250
        height: 100

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        radius: 10
        color: "#AA000000"

        Components.SliderChannel {
            id: sliderRadius

            width: parent.width * 0.8
            anchors.centerIn: parent

            text: qsTr("Radius: " + sliderRadius.value.toFixed(2))

            slider.from: 0
            slider.to: 64.0
            slider.value: 0.0
            slider.stepSize: 1.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }
    }
}
