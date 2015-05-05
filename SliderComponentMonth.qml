import QtQuick 2.0


Rectangle {
    width: parent.width; height: 25

    Component {
        id: monthDelegate
        Rectangle{
            anchors.fill: parent
            color: clrBackground
            Item {
                width: 100; height: 25

                Column {
                    Text { text: month; color:clrFont}
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        lvwMonth.currentIndex = index
                    }
                }
            }
        }
    }

    ListView {
        id:lvwMonth
        anchors.fill: parent
        model: MonthModel {}
        delegate: monthDelegate
        highlight: monthhighlight
        orientation: Qt.Horizontal
        onCurrentItemChanged: console.log("current item changed in month.")
        highlightMoveDuration: 100
    }

    Component {
        id: monthhighlight
        Rectangle {
            width: 100; height: 25
            color: "lightsteelblue"; //radius: 5
            x: lvwMonth.currentItem.x
            Behavior on x {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }
    }

}
