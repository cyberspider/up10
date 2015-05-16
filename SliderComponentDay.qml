import QtQuick 2.0


Rectangle {
    width: parent.width
    height: parent.height
    color: clrBackground
    Component {
        id: contactDelegate
        Item {
            width: 200; height: 50
            Rectangle{
                anchors.fill: parent
                color: clrBackground
            }
            Text { text: name; color: clrFont; font.family: fntMyraidPro.name}

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
        model: ContactModel {}
        delegate: contactDelegate
        highlight: dayhighlight //Rectangle { color: "lightsteelblue"; radius: 0 }
        orientation: Qt.Horizontal
        onCurrentItemChanged: console.log("current item changed in day.")
        highlightMoveDuration: 100
        //snapMode: ListView.SnapOneItem
        Component.onCompleted: positionViewAtEnd()
    }

    Component {
        id: dayhighlight
        Rectangle {
            width: 100; height: 25
            color: "lightsteelblue"; opacity: 0.25
            x: lvwDays.currentItem.x
            Behavior on x {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }

    }

}
