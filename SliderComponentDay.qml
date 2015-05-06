import QtQuick 2.0


Rectangle {
    width: parent.width; height: 50
    color: clrBackground
    Component {
        id: contactDelegate
        Item {
            width: 200; height: 50
            //Column {

                Rectangle{
                    anchors.fill: parent
                    color: clrBackground
                }
                Text { text: name; color: clrFont }
            //    Text { text: icon; color: clrFont }
            //}
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
    }

    Component {
        id: dayhighlight
        Rectangle {
            z:3
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
