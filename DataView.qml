import QtQuick 2.0

Rectangle{

    color: "Red"
    anchors.fill: parent
    opacity: 0
    Item{
        id:dvScroller
        anchors.fill: parent
        Rectangle{
            id:rectDay
            opacity: 0
            anchors.fill: parent
            color: "Red"
            Text {
                id: txtDay
                text: qsTr("Day")
                opacity: 0
            }

        }

        Rectangle{
            id:rectWeek
            opacity: 0
            anchors.fill: parent
            color: "Green"
            Text {
                id: txtWeek
                text: qsTr("Week")
                opacity: 0
            }

        }
        Rectangle{
            id:rectMonth
            opacity: 0
            anchors.fill: parent
            color: "Blue"
            Text {
                id: txtMonth
                text: qsTr("Month")
                opacity: 0
            }
        }
        Rectangle{
            id:rectYear
            opacity: 0
            anchors.fill: parent
            color: "Yellow"
            Text {
                id: txtYear
                text: qsTr("Year")
                opacity: 0
            }
        }


        states: [
            State {
                name: "dvStateDay"
                PropertyChanges {
                    target: rectDay
                    opacity: 1
                    z:1
                }
                PropertyChanges {
                    target: txtDay
                    opacity: 1
                    z:1
                }

            },
            State {
                name: "dvStateWeek"
                PropertyChanges {
                    target: rectWeek
                    opacity: 1
                    z:1
                }
                PropertyChanges {
                    target: txtWeek
                    opacity: 1
                    z:1
                }
            },
            State {
                name: "dvStateMonth"
                PropertyChanges {
                    target: rectMonth
                    opacity: 1
                    z:1
                }
                PropertyChanges {
                    target: txtMonth
                    opacity: 1
                    z:1
                }
            },
            State {
                name: "dvStateYear"
                PropertyChanges {
                    target: rectYear
                    opacity: 1
                    z:1
                }
                PropertyChanges {
                    target: txtYear
                    opacity: 1
                    z:1
                }
            }

        ]
        transitions: [
            Transition {
                NumberAnimation { property: "opacity"; easing.type: Easing.InOutQuad; duration:1000}
            }

        ]
    }

    Row{
        anchors.right: parent.right

        Rectangle{
            id:dayView
            color: "Red"
            height: 30
            width: 30
            MouseArea{
                anchors.fill: parent
                onClicked: dvScroller.state = "dvStateDay"
            }
        }
        Rectangle{
            id:weekView
            color: "Green"
            height: 30
            width: 30
            MouseArea{
                anchors.fill: parent
                onClicked: dvScroller.state = "dvStateWeek"
            }
        }
        Rectangle{
            id:monthView
            color: "Blue"
            height: 30
            width: 30
            MouseArea{
                anchors.fill: parent
                onClicked: dvScroller.state = "dvStateMonth"
            }
        }
        Rectangle{
            id:yearView
            color: "Yellow"
            height: 30
            width: 30
            MouseArea{
                anchors.fill: parent
                onClicked: dvScroller.state = "dvStateYear"
            }
        }
    }
}
