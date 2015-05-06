import QtQuick 2.0
import QtGraphicalEffects 1.0

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
                Text { text:month; color: clrFont}
            //}
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lvwMonth.currentIndex = index
                }
            }
        }
    }

    ListView {
        id:lvwMonth
        anchors.fill: parent
        model: MonthModel {}
        delegate: contactDelegate
        highlight: monthhighlight//Rectangle { color: "lightsteelblue"; radius: 0 }
        orientation: Qt.Horizontal
        onCurrentItemChanged: console.log("current item changed in month.")
        highlightMoveDuration: 100

    }

    Component {
        id: monthhighlight
        Rectangle {
            z:3
            width: 100; height: 25
            color: "lightsteelblue"; opacity: 0.25
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
