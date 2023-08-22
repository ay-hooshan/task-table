import QtQuick
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

                onCurrentIndexChanged: () => {
                                           console.log(currentIndex)
                                           myproxymodel.searchedID = ""
                                           myproxymodel.searchedName = ""
                                           myproxymodel.searchedFamily = ""
                                           myproxymodel.searchedAddress = ""
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

                                           if (myCombo.currentIndex === 0) {
                                               myproxymodel.searchedID = text
                                           } else if (myCombo.currentIndex === 1) {
                                               myproxymodel.searchedName = text
                                           } else if (myCombo.currentIndex === 2) {
                                                myproxymodel.searchedFamily = text
                                           } else if (myCombo.currentIndex === 3) {
                                                myproxymodel.searchedAddress = text
                                           } else {
                                               console.log("Errrrrrrrrorrrrrrr!!!!!!!!")
                                           }
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

            selectionBehavior: TableView.SelectRows

            function getRow(delegateIndex) {
                return delegateIndex % tableView.rows
            }

            function myIsRowSelected(delegateIndex) {
                for (let i = 0; i < mySelectionModel.selectedIndexes.length; i++) {
//                    console.log(i + ", " + mySelectionModel.selectedIndexes[i].row + ", " + getRow(delegateIndex))
                    if (mySelectionModel.selectedIndexes[i].row === getRow(delegateIndex)) {
                        return true;
                    }
                }
                return false;
            }

            anchors.fill: parent
            anchors.margins: 2
            anchors.topMargin: tableFrame.delegateHeight + tableFrame.spaceBetweenRows

            model: myproxymodel

            selectionModel: ItemSelectionModel {
                id: mySelectionModel
                model: myproxymodel
                onCurrentChanged: (cur, prv)=>{
                                      print("cur: ", cur)
                                      print("prv:", prv)
                                  }

//                onSelectedIndexesChanged: console.log("'onSelectedIndexesChanged' called!")
            }

            property var columnWidths: [tableFrame.delegateWidth, tableFrame.delegateWidth, tableFrame.delegateWidth, tableFrame.width - 3 * tableFrame.width]
            columnWidthProvider: function (column) { return columnWidths[column] }

            delegate: Rectangle {
                id: tableDelegate

                implicitWidth: tableFrame.width
                implicitHeight: tableFrame.delegateHeight
                color: tableView.myIsRowSelected(index) ? "grey" : tableView.getRow(index) % 2 == 0 ? "lightblue": "white"

                HoverHandler {
                    id: stylus
                    onHoveredChanged: () => {
                                          if (hovered)
                                            mySelectionModel.select(myproxymodel.index(tableView.getRow(index), 0), ItemSelectionModel.Select | ItemSelectionModel.Rows)
                                          else
                                            mySelectionModel.select(myproxymodel.index(tableView.getRow(index), 0), ItemSelectionModel.Deselect | ItemSelectionModel.Rows)
//                                          console.log(hovered)
//                                          console.log(mySelectionModel.selectedIndexes)
//                                          mySelectionModel.select(myproxymodel.index(index, i), ItemSelectionModel.Select | ItemSelectionModel.Current)
                                      }
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
//                                   console.log(myproxymodel.rowCount())
//                                   console.log("index " + model.index + " clicked!")
                                   mySelectionModel.setCurrentIndex(myproxymodel.index(tableView.getRow(index), 0), ItemSelectionModel.Select | ItemSelectionModel.Current)

//                                   console.log("mySelectionModel.selectedIndexes: " + mySelectionModel.selectedIndexes)

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
//                                             let rowIndex = model.index % tableView.rows
//                                             mymodel.myRemoveRow(rowIndex)
                                             myproxymodel.myRemoveRow(mySelectionModel.currentIndex)
                                         }
                        }
                    }
                }
            }
        }
    }
}

