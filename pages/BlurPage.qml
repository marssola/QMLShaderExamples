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



            source: Image {
                property size originalSize: Qt.size(0,0)
                source: "qrc:/QMLShaderExamples/imgs/simon.jpg"
                sourceSize.width: remap(blurImage.radius, sliderRadius.slider.to, sliderRadius.slider.from, 10, blurImage.width)
                sourceSize.height: remap(blurImage.radius, sliderRadius.slider.to, sliderRadius.slider.from, 10, blurImage.height)

                onSourceSizeChanged: console.log(sourceSize)

                Component.onCompleted: {
                    originalSize = Qt.size(sourceSize.width, sourceSize.height)
//                    console.log(originalSize)
//                    console.log(blurImage.width, blurImage.height)
                }
            }

            //image.source: "https://www.2net.com.br//Repositorio/251/Publicacoes/23883/3c2fd25f-c.jpg"
        }

        SliderChannel {
            id: sliderRadius

            width: 250
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("Radius: " + sliderRadius.value.toFixed(2))

            slider.from: 0
            slider.to: 64.0
            slider.value: 8.0
            slider.stepSize: 1.0
            slider.snapMode: Slider.SnapAlways
            runningAnimation: false
        }
    }




    function lerp( value: float, min: float, max: float ) {
        return ( 1.0 - value ) * min + max * value;
    }

    function inverseLerp( value: float, min: float, max: float ) {
        return ( value - min ) / ( max - min );
    }

    function remap( value: float, inMin: float, inMax: float, outMin: float, outMax: float ) {
        const t = inverseLerp( value, inMin, inMax );
        return lerp( t, outMin, outMax );
    }

}
