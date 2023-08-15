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

            acceptedButtons: Qt.LeftButton | Qt.RightButton

            AyText {
                text: model.display
            }

            onClicked: (mouse) => {
                           console.log(model.index)

                           if (mouse.button === Qt.RightButton) {
                                console.log("right click!")
                           }
            }
        }
    }

    Row {
        id: myHeaders
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

        Rectangle {
            id: rect

            property double dragLimit: delegateWidth

            width: 5; height: delegateHeight
            z: 3
            color: "grey"
//            x: myHeaders.width
            x: 800 + 2
            anchors.verticalCenter: myHeaders.verticalCenter

            MouseArea {
                anchors.fill: parent
                smooth: true
                drag.target: rect
                drag.axis: Drag.XAxis
                drag.minimumX: 800 - parent.dragLimit
                drag.maximumX: 800 + parent.dragLimit

                onMouseXChanged: () => {
//                                     console.log(rect.x)
                                     tableView.setColumnWidth(3, delegateWidth + (rect.x - 800))
                                     myHeaders.children[3].width = delegateWidth + (rect.x - 800)
                                 }
            }
        }

}
