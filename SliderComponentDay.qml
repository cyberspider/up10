import QtQuick 2.0


Rectangle {
    width: parent.width
    height: parent.height
    color: clrBackground
    Component {
        id: contactDelegate
        Item {
            width: 75; height: 75

            Text { id:txtmonth; text: month; color: clrFont; font.family: fntMyraidPro.name; font.pixelSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text { id:txtday; text: day; color: clrFont; font.family: fntMyraidPro.name; font.pixelSize: 40
                anchors.top:txtmonth.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text { id:txtyear; text: year; color: clrFont; font.family: fntMyraidPro.name; font.pixelSize: 15
                anchors.top:txtday.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lvwDays.currentIndex = index
                }
            }
        }
    }

    ListView {
        id:lvwDays
        anchors.fill: parent
        model: DaysModel{id:daysModel}//DaysModel {}
        delegate: contactDelegate
        highlight: dayhighlight
        orientation: Qt.Horizontal
        onCurrentItemChanged: console.log("current item changed in day.")
        highlightMoveDuration: 100
        //snapMode: ListView.SnapOneItem
        Component.onCompleted: positionViewAtEnd()
        z:0
    }

    Component {
        id: dayhighlight

        Rectangle {
            width: 100; height: 50
            color: "lightsteelblue"; opacity: 0.25
            x: lvwDays.currentItem.x
            z:10
            Behavior on x {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }

    }

}
