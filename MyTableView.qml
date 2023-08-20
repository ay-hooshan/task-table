import QtQuick 2.15
import QtQuick.Controls.Basic
import QtQuick.Layouts


ColumnLayout {
    anchors.fill: parent
    anchors.margins: 15

    spacing: 15

    Rectangle {
        Layout.fillWidth: true
        Layout.preferredHeight: 40
        radius: 15

        RowLayout {
            anchors.fill: parent

            ComboBox {
                id: myCombo
                leftPadding: 10
                Layout.maximumWidth: 150
                Layout.fillWidth: true
                Layout.fillHeight: true

                model: ["ID", "Name", "Family", "Address"]

                background: Rectangle {
                    width: myCombo.width
                    height: myCombo.height
                    radius: 20
                    border.width: 1
                    border.color: 'grey'
                }

                contentItem: Text {
                    text: myCombo.displayText
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Roboto"
                    font.pixelSize: 20
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 100
                border.color: 'grey'
                border.width: 1
                radius: 20

                RowLayout {
                    anchors.fill: parent
                    Rectangle {
                        Layout.fillHeight: true
                        Layout.preferredWidth: height
                        Layout.margins: 5
                        radius: 10
                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            source: "qrc:/icons/search2.png"
                        }
                    }

                    TextInput {
                        id: ayinput
                        font.family: "cmu concrete"
                        font.pixelSize: 20
                        color: focus ? "black" : "grey"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.margins: 5
                        anchors.leftMargin: 10
                        verticalAlignment: Text.AlignVCenter
                        onTextChanged: () => {
                            console.log(myproxymodel.searchedWord)
                            myproxymodel.searchedWord = text
                            myproxymodel.myFilterEnabled = true
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: tableFrame

        property double spaceBetweenRows: 2
        property double spaceBetweenColumns: 2

        property double delegateWidth: 200
        property double delegateHeight: 50

        property double delegateBorderWidth: 2

        Layout.fillWidth: true
        Layout.fillHeight: true
        radius: 15

        border.color: 'lightblue'
        border.width: 2
        clip: true

        Rectangle {
            color: "#6495ED"
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.right: parent.right
            anchors.top: parent.top
            height: parent.delegateHeight
            radius: 15

            CustomRadius {}
            z: 1
        }

        Row {
            id: myHeaders
            x: -tableView.contentX
            z: 2

            Repeater {
                model: tableView.columns > 0 ? tableView.columns : 1
                Rectangle {
                    id: roundRect
                    color: "transparent"
                    width: tableFrame.delegateWidth
                    height: tableFrame.delegateHeight

                    RowLayout {
                        anchors.fill: parent
                        Text {
                            color: 'white'
                            text: myproxymodel.headerData(model.index, Qt.Horizontal)
                            verticalAlignment: Text.AlignVCenter
                            font.family: "Inter"
                            font.pixelSize: 20
                            leftPadding: 40
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.bold: true
                        }

                        Button {
                            icon.color: 'white'
                            Layout.fillHeight: true
                            Layout.preferredWidth: height
                            icon.source: 'qrc:/icons/sort.png'
                            onClicked: () => {
                                           console.log("header index " + model.index + " clicked!")
                                           myproxymodel.sort(model.index, Qt.AscendingOrder)
                                       }

                            background: Rectangle {
                                color: "transparent"
                            }
                        }
                    }
                }
            }
        }

        TableView {
            id: tableView

            clip: true

            anchors.fill: parent
            anchors.margins: 2
            anchors.topMargin: tableFrame.delegateHeight + tableFrame.spaceBetweenRows

            model: myproxymodel

            property var columnWidths: [tableFrame.delegateWidth, tableFrame.delegateWidth, tableFrame.delegateWidth, tableFrame.width - 3 * tableFrame.width]
            columnWidthProvider: function (column) { return columnWidths[column] }

            delegate: Rectangle {
                id: tableDelegate

                implicitWidth: tableFrame.width
                implicitHeight: tableFrame.delegateHeight

                color: stylus.hovered ? "grey" : (model.index % tableView.rows) % 2 == 0 ? "#F0F0F6" : "white"

                HoverHandler {
                    id: stylus
                }

                MouseArea {
                    anchors.fill: parent

                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    Text {
                        text: model.display
                        font.family: "Roboto"
                        leftPadding: 40
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
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
                    }
                }
            }
        }
    }
}

