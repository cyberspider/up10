import QtQuick 2.0


Rectangle {

    anchors.fill: parent
    opacity: 0
    VisualItemModel {
        id: itemModel
        Rectangle {
            width: view.width; height: view.height
            color: "Green"//clrBackground
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
                width: parent.width
                height: parent.height
                z:0
                snapMode: ListView.SnapToItem
                Component {
                    id: contactsDelegate
                    Rectangle {
                        id: wrapper
                        width: parent.width
                        height: 100
                        color: "red"//ListView.isCurrentItem ? "black" : "red"
                        Text {
                            id: contactInfo
                            text: name + ": "
                            font.family: fntMyraidPro.name
                            font.pixelSize: 25
                            color: "black"//wrapper.ListView.isCurrentItem ? "red" : "black"
                        }
                        Rectangle{
                            width:100
                            color: "Yellow"
                            Text{
                                font.family: fntMyraidPro.name
                                font.pixelSize: 15
                                anchors.fill:parent
                                text: "max:" + max
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
