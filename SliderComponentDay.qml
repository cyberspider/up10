import QtQuick 2.0


Rectangle {
    width: parent.width; height: 50

    Component {
        id: contactDelegate
        Item {
            width: 200; height: 50
            Column {
                Text { text: '<b>N:</b> ' + name }
                Text { text: '<b>I:</b> ' + icon }
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
        model: ContactModel {}
        delegate: contactDelegate
        highlight: dayshighlight
        orientation: Qt.Horizontal
        onCurrentItemChanged: console.log("current item changed in day.")
        highlightMoveDuration: 100
    }

    Component {
        id: dayshighlight
        Rectangle {
            width: 100; height: 25
            color: "lightsteelblue"; //radius: 5
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
