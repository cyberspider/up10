import QtQuick 2.0

Rectangle{
    id:screen
    color: "Blue"
    anchors.fill: parent
    opacity: 0

    states: [
        State {
            name: "view"
            PropertyChanges {
                target: screenLayout
                x: -screen.width

            }
        }
    ]
    transitions: [
        Transition {

            NumberAnimation {
                target: screenLayout
                property: "x"
                duration: 500
                easing.type: Easing.InOutBack
            }

        }
    ]
    ListModel {
        id:activityModel
        ListElement {
            activityName: "Running"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Biking"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Yoga"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Swimming"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Jogging"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Climbing"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Yoga"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Swimming"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Jogging"
            icon: "images/logo.png"
        }
        ListElement {
            activityName: "Climbing"
            icon: "images/logo.png"
        }
    }

    Component {
        id: contactDelegate
        Item {
            id:lvItem
            width: parent.width; height: 70
            Image {
                id: itemBackground
                source: "images/item.png"
                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
            }
            Image {
                id: arrow
                height: 18
                width: 20
                source: "images/rarrow.png"
                anchors.right: lvItem.right
                //anchors.top:lvItem.top
                anchors.margins: 5
                anchors.verticalCenter: parent.verticalCenter            }
            Image {
                id: imgLV
                width:70
                height: 70
                //source: icon
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                anchors.left:imgLV.right
                //text: activityName
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 5
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {screen.state = "view"}
            }
        }
    }

    Row{
        id:screenLayout

        Column{
            id:initScreen
            width:screen.width
            height:screen.height
            TopBar{}

            ListView {
                id:activityListView
                //anchors.top:toolBar.bottom
                width:screen.width
                height:screen.height
                model: 20 //activityModel
                delegate: contactDelegate
                clip: true
                focus: true
                //boundsBehavior: Flickable.StopAtBounds

            }
        }
        Item{
            id:logViewDetail
            width:screen.width
            height: screen.height
            Image {
                id: img
                source: "images/logo.png"
                width: screen.width
                height: screen.width
            }
            Image{
                id:bckButton
                source:"images/back.png"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {screen.state = ""}
                }

            }
        }
    }
}

