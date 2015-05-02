import QtQuick 2.0

Rectangle{
    id:screen
    color: clrBackground
    anchors.fill: parent
    opacity: 0

    signal lvaddActivity()
    onLvaddActivity: {
        activityListView.amaddActivity()
    }

    states: [
        State {
            name: "stateActivtyView"
            PropertyChanges {
                target: screenLayout
                x: -screen.width

            }
        },
        State {
            name: "stateActivityAdd"
            PropertyChanges {
                target: screenLayout
                x: -screen.width*2
            }
        }

    ]

    transitions: [
        Transition {

            NumberAnimation {
                target: screenLayout
                property: "x"
                duration: 500
                easing.type: Easing.InOutQuint
            }
        }
    ]

    Component {
        id: activityDelegate
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
                anchors.margins: 5
                anchors.verticalCenter: parent.verticalCenter            }
//            Image {
//                id: imgLV
//                width:70
//                height: 70
//                source: icon
//                anchors.verticalCenter: parent.verticalCenter
//            }
            Text {
                //anchors.left:imgLV.right
                text: activityName
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 5
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {screen.state = "stateActivtyView"}
            }
        }
    }

    Row{
        id:screenLayout
        Column{
            id:initScreen
            width:screen.width
            //height:screen.height
            TopBar{id:topBar}

            ListView {
                id:activityListView
                width:screen.width
                height:screen.height - topBar.height
                model: ActivityModel{id:activityModel}
                delegate: activityDelegate
                clip: true
                focus: true
                spacing: 3
                boundsBehavior: Flickable.DragAndOvershootBounds

                function amaddActivity(){
                    activityModel.append({"activityName":newActivity})
                }
            }
        }
        LogViewDetail{
            id:logViewDetail
            width:screen.width
            height: screen.height
        }
        AddActivityView{
            id:addActivityView
            width:screen.width
            height: screen.height
        }
    }

}

