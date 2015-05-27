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
                function reloadMeSliders(){
                    reLoadMainDataView()
                }
            }
            Text { text: "Day"; color:clrFont; font.bold: true; anchors.centerIn: parent }
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
