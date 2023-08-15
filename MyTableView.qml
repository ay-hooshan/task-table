import QtQuick
import QtQuick.Controls 2.15

Column {
    property double tableFrameWidth: 800
    property double tableFrameHeight: 600

    property double spaceBetweenRows: 2
    property double spaceBetweenColumns: 2

    property double delegateWidth: 200
    property double delegateHeight: 50

    property double delegateBorderWidth: 2

    spacing: 10
    anchors.horizontalCenter: parent.horizontalCenter
    y: 10

    AyLineEdit {
        id: myale
        width: tableFrameWidth
        height: delegateHeight
    }

    Rectangle {
        width: tableFrameWidth
        height: tableFrameHeight
        clip: true

        TableView {
            id: tableView

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
                                   console.log("index " + model.index + " clicked!")
                                   //                console.log(mouse.button)
                                   if (mouse.button === Qt.RightButton) {
                                       //                    console.log("right click!")
                                       contextMenu.popup()
                                   }
                               }

                    Menu {
                        id: contextMenu
                        MenuItem {
                            text: "Delete"
                            onTriggered: () => {
                                             //                        console.log("delete trigger on index " + model.index)
                                             let rowIndex = model.index % tableView.rows
                                             mymodel.myRemoveRow(rowIndex)
                                         }
                        }
                        //                MenuItem { text: "Copy" }
                        //                MenuItem { text: "Paste" }
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
                                         //                console.log(rect.x)
                                         tableView.setColumnWidth(3, delegateWidth + (rect.x - 800))
                                         myHeaders.children[3].width = delegateWidth + (rect.x - 800)
                                     }
                }
            }

        }
    }
}









