import QtQuick
import QtQuick.Controls.Material

import "../components"

Page {
    id: page

    title: qsTr("Genie Effect")

    Column {
        width: parent.width
        spacing: 20

        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            height: width

            GenieEffect {
                id: effect

                width: parent.width
                height: width
                source: Image { source: "https://www.2net.com.br//Repositorio/251/Publicacoes/23883/3c2fd25f-c.jpg" }
                side: sliderMinimizeSide.value

                BusyIndicator {
                    visible: !effect.enabled
                    anchors.centerIn: parent
                }
            }
        }

        Column {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            Slider {
                id: sliderMinimizeSide

                width: parent.width

                from: 0.0
                to: 1.0
                value: from
                stepSize: 0.05
                snapMode: Slider.SnapAlways
            }

            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: {
                    let side = qsTr("Left")
                    const value = sliderMinimizeSide.value
                    if (value >= 0.25 && value < 0.5)
                        side = qsTr("Left-Center")
                    else if (value === 0.5)
                        side = qsTr("Center")
                    else if (value > 0.5 && value < 1.0)
                        side = qsTr("Center-Right")
                    else if (value === 1.0)
                        side = qsTr("Right")
                    return qsTr("Minimize side: " + side)
                }
            }
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter

            text: !effect.minimized ? qsTr("Minimize") : qsTr("Show")
            onClicked: effect.minimized = !effect.minimized
        }

    }
}
