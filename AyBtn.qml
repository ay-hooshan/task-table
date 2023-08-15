import QtQuick 2.15

Rectangle {
    property alias btnPressed: ayMa.pressed
    property alias btnText: buttonText.text

//    border.color: "black"
//    radius: 20

    signal btnClicked()

    Text {
        id: buttonText
        text: qsTr("Click Me!")
        font.family: "cmu concrete"
        font.pixelSize: ayMa.pressed ? parent.height / 2 : parent.height / 3
        anchors.centerIn: parent
        font.bold: ayMa.pressed
        color: ayMa.pressed ? 'red' : 'black'
    }

    MouseArea {
        id: ayMa
        anchors.fill: parent
        onClicked: () => {
            parent.btnClicked()
        }
    }
}

