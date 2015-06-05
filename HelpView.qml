import QtQuick 2.0


Rectangle {
    color: clrBackground
    anchors.fill: parent
    opacity: 0
    VisualItemModel {
        id: itemModel

        Rectangle {
            width: view.width; height: view.height
            color: clrBackground
            Image {
                id: imgbuttons1
                source: "images/help_buttons.png"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: view.width; height: view.height
            color: clrBackground
            Image {
                id: imgbuttons2
                source: "images/help_dataView.png"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: view.width; height: view.height
            color: clrBackground
            Image {
                id: imgbuttons3
                source: "images/help_calendar.png"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: view.width; height: view.height
            color: clrBackground
            Image {
                id: imgbuttons4
                source: "images/help_sliders.png"
                anchors.centerIn: parent
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
