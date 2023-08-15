import QtQuick

TableView {
    anchors.fill: parent
    model: mymodel
    rowSpacing: 2
    columnSpacing: 2
    delegate: Rectangle {
        implicitWidth: 200
        implicitHeight: 50
        border.color: "black"
        border.width: 2

        Text {
            id: delegateText
            text: model.display
            anchors.centerIn: parent
            font.family: "cmu concrete"
            font.pixelSize: 20
        }
    }
}
