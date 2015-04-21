import QtQuick 2.0

Rectangle{

    color: "Red"
    anchors.fill: parent
    opacity: 0
    Row{
        anchors.right: parent.right

        Rectangle{
            id:dayView
            color: "Darkred"
            height: 40
            width: 40
            MouseArea{
                anchors.fill: parent
                onClicked: topPanel.state = "helpViewState"
            }
        }
        Rectangle{
            id:weekView
            color: "Darkgreen"
            height: 40
            width: 40
        }
        Rectangle{
            id:monthView
            color: "DarkBlue"
            height: 40
            width: 40
        }
        Rectangle{
            id:yearView
            color: "Silver"
            height: 40
            width: 40
        }
    }
}
