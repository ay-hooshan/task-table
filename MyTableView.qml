import QtQuick
import QtQuick.Controls 2.15

TableView {
    id: tableView

    property double spaceBetweenRows: 2
    property double spaceBetweenColumns: 2

    property double delegateWidth: 200
    property double delegateHeight: 50

    property double delegateBorderWidth: 2

    anchors.fill: parent
    anchors.topMargin: delegateHeight + spaceBetweenRows

    model: mymodel

    rowSpacing: spaceBetweenRows
    columnSpacing: spaceBetweenColumns

//    resizableColumns: true

    delegate: Rectangle {
        id: tableDelegate

        implicitWidth: delegateWidth
        implicitHeight: delegateHeight

        border.color: "black"
        border.width: delegateBorderWidth

        color: stylus.hovered ? "grey" : "white"

        HoverHandler {
            id: stylus
        }

        MouseArea {
            anchors.fill: parent

            AyText {
                text: model.display
            }

            onClicked: () => {
                console.log(model.index)
            }
        }
    }

    Row {
        id: columnsHeader
        y: tableView.contentY - (delegateHeight + spaceBetweenRows)
        z: 2
        spacing: spaceBetweenColumns
        Repeater {
            model: tableView.columns > 0 ? tableView.columns : 1
            Rectangle {
                width: delegateWidth
                height: delegateHeight
                border.color: "blue"
                border.width: delegateBorderWidth

                AyText {
                    text: mymodel.headerData(model.index, Qt.Horizontal)
                    font.bold: true
                }
            }
        }
    }
}
