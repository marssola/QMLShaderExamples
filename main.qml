import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "components"

ApplicationWindow {
    id: window

    visible: true
    width: 400
    height: 640
    title: qsTr("Shader Effect")

    Material.theme: Material.Dark
    Material.background: "#000"

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                id: toolButtonBack
                visible: stackView.depth > 1

                text: qsTr("< back")
                onClicked: stackView.pop()
            }

            Label {
                text: stackView.currentItem.title

                Layout.fillWidth: true
                elide: Label.ElideRight
                font.capitalization: Font.AllUppercase
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
            }

            Item {
                visible: toolButtonBack.visible
                Layout.preferredWidth: toolButtonBack.implicitWidth
                Layout.fillHeight: true
            }
        }
    }

    StackView {
        id: stackView

        anchors.fill: parent

        initialItem: ScrollablePage {
            title: qsTr("Shader Examples")

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Color channel")
                    onClicked: stackView.push("pages/ColorChannelPage.qml")
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Wave Effect")
                    onClicked: stackView.push("pages/WaveEffectPage.qml")
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Genie Effect")
                    onClicked: stackView.push("pages/GenieEffectPage.qml")
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Round Image")
                    onClicked: stackView.push("pages/RoundImagePage.qml")
                }

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Blur Image")
                    onClicked: stackView.push("pages/BlurPage.qml")
                }
            }
        }

        Keys.onPressed: function(event) {
            if ((event.key === Qt.Key_Back || event.key === Qt.Key_Escape) && stackView.depth > 1) {
                stackView.pop()
                event.accepted = true
            }
        }
    }
}
