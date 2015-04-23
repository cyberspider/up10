import QtQuick 2.0


Rectangle {
    color: "lightgray"
    anchors.fill: parent
    opacity: 0
    VisualItemModel {
        id: itemModel

        Rectangle {
            width: view.width; height: view.height
            color: "#f41340"
            Text { text: "Help Page 1"; font.bold: true; anchors.centerIn: parent }
        }
        Rectangle {
            width: view.width; height: view.height
            color: "#f41340"
            Text { text: "Help Page 2"; font.bold: true; anchors.centerIn: parent }
        }
        Rectangle {
            width: view.width; height: view.height
            color: "#f41340"
            Text { text: "Help Page 3"; font.bold: true; anchors.centerIn: parent }
            Behavior on opacity { NumberAnimation {} }
        }
        Rectangle {
            width: view.width; height: view.height
            color: "#f41340"

            Flow{
                anchors.centerIn: parent
                anchors.fill: parent

                Text {
                    text: "Help Page 4. Close button here. Help needs 2b modal";
                    clip: true
                    font.bold: true;
                    wrapMode: Text.WordWrap
                }
            }
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
                    color: view.currentIndex == index ? "White" : "Gray"

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
