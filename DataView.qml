import QtQuick 2.0


Rectangle {

    anchors.fill: parent
    opacity: 0
    VisualItemModel {
        id: itemModel
        Rectangle {
            width: view.width; height: view.height
            color: clrBackground
            SliderComponentDay{
                id:sldcompday2
                width: parent.width
                height: 75
                z:1
                //                function reloadMeSliders(){
                //                    reLoadMainDataView()
                //                }
            }
            ListView {
                anchors.top: sldcompday2.bottom
                width: parent.width -10
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                z:0
                snapMode: ListView.SnapToItem
                spacing: 5
                Component {
                    id: contactsDelegate
                    Rectangle {
                        id: wrapper
                        width: parent.width
                        height: 90
                        color: clrBackground
                        Rectangle{
                            id:spacer
                            height:20
                        }

                        Text {
                            id: activityName
                            anchors.top:spacer.bottom
                            text: name + ": "
                            font.family: fntMyraidPro.name
                            font.pixelSize: 25
                            color: clrFont
                            width: parent.width
                            Item{
                                id:txtBoxes
                                width:wrapper.width/3
                                anchors.top:activityName.bottom

                                Text{
                                    id:txtToday
                                    anchors.top:txtBoxes.bottom
                                    anchors.right:txtBoxes.right
                                    font.family: fntMyraidPro.name
                                    font.pixelSize: 15
                                    text: "Today: " + today
                                    color: clrFont
                                }

                                Text{
                                    id:txtYesterday
                                    anchors.top: txtToday.bottom
                                    anchors.right:txtBoxes.right
                                    font.family: fntMyraidPro.name
                                    font.pixelSize: 15
                                    color: clrFont
                                    text: "Yesterday: " + yesterday
                                }
                                Text{
                                    id:txtMax
                                    anchors.top:txtYesterday.bottom
                                    anchors.right:txtBoxes.right
                                    font.family: fntMyraidPro.name
                                    font.pixelSize: 15
                                    text: "Max: " + max
                                    color: clrFont
                                }

                            }

                            Rectangle{
                                id:rectToday
                                anchors.top:txtBoxes.bottom
                                anchors.left: txtBoxes.right
                                width:10 * today
                                height:10
                                color: "#7abdf3"
                                border.width: 2
                                anchors.margins: 4
                            }
                            Rectangle{
                                id:rectDayBefore
                                anchors.top: rectToday.bottom
                                anchors.left: txtBoxes.right
                                width:10 * yesterday
                                height:10
                                color: "#54a9ed"
                                border.width: 2
                                anchors.margins: 4
                            }
                            Rectangle{
                                id:rectMax
                                anchors.top: rectDayBefore.bottom
                                anchors.left: txtBoxes.right
                                anchors.right:parent.right
                                //width: 200
                                height:10
                                color: "#3782bf"
                                border.width: 2
                                anchors.margins: 4
                            }
                        }
                    }
                }
                model: MonthModel {}
                delegate: contactsDelegate
                focus: true
            }
            //            ListView {
            //                id:dayListView
            //                anchors.fill: parent
            //                Component {
            //                    id: dayViewDelegate
            //                    Rectangle{
            //                        id:item
            //                        anchors.fill: parent
            //                        color: "Yellow"

            //                    }
            //                }
            //                model: 20//MonthModel{id:mymonthmodel}
            //                delegate: dayViewDelegate

            //                //                clip: true
            //                //                focus: true
            //                //                spacing: 3
            //                //                contentHeight: screen.height
            //                //                anchors.horizontalCenter: parent.horizontalCenter
            //                //                boundsBehavior: Flickable.DragAndOvershootBounds

            //            }

        }
        Rectangle {
            width: view.width; height: view.height
            color: clrBackground
            Text { text: "Week"; color:clrFont; font.bold: true; anchors.centerIn: parent }
        }
        Rectangle {
            width: view.width; height: view.height
            color: clrBackground
            Text { text: "Month"; color:clrFont; font.bold: true; anchors.centerIn: parent }
        }
        Rectangle {
            width: view.width; height: view.height
            color: clrBackground
            Text { text: "Year"; color:clrFont; font.bold: true; anchors.centerIn: parent }
        }
    }

    ListView {
        id: view
        anchors {
            fill: parent;
            //bottomMargin: 30
        }
        model: itemModel
        preferredHighlightBegin: 0; preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem; flickDeceleration: 1000
    }

    Rectangle {
        width: parent.width;
        height: 30
        anchors { top: view.bottom; bottom: parent.bottom }
        //color: "Black"
        //opacity: 0.3

        Row {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -10
            spacing: 10

            Repeater {
                model: itemModel.count

                Rectangle {
                    width: 8; height: 8
                    radius: 4
                    color: view.currentIndex == index ? clrFont : "Gray"

                    MouseArea {
                        width: 20; height: 20
                        anchors.centerIn: parent
                        onClicked: view.currentIndex = index
                    }
                }
            }
        }
    }
}
