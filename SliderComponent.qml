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
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
        orientation: Qt.Horizontal
        onCurrentItemChanged: console.log("current item changed.")
        highlightMoveDuration: 100
    }
}
