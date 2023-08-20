import QtQuick 2.0

Rectangle {
//    border.color: "black"
//    radius: 20
    clip: true

    property alias textInputed: ayinput.text
    readonly property string password: "12345"

    signal aleTextChanged()

    TextInput {
        id: ayinput
        font.family: "cmu concrete"
        font.pixelSize: 30
        color: focus ? "black" : "grey"
        anchors.fill: parent
        anchors.leftMargin: 10
        verticalAlignment: Text.AlignVCenter
        onTextChanged: parent.aleTextChanged()
    }

    Keys.onReturnPressed: {
        textEntered = ayinput.text
        console.log(textEntered)
    }
}
