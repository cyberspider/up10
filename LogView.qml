import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "localStorage.js" as DB

Rectangle{
    id:screen
    color: clrBackground
    anchors.fill: parent
    opacity: 0

    signal lvaddActivity()
    signal lvdeleteActivity()
    onLvaddActivity: {
        activityListView.amaddActivity()

    }
    onLvdeleteActivity: {
        activityListView.amdeleteActivity()
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
            Text {
                //anchors.left:imgLV.right
                text: activityName
                color: clrFont
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 5
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    screen.state = "stateActivtyView"
                    selectedActivity = activityName
                    selectedActivityUnit = activityUnit
                    console.log(selectedActivityUnit + "<--here")
                }
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
                width:screen.width - 10
                height:screen.height - topBar.height
                model: ActivityModel{id:activityModel}
                delegate: activityDelegate
                clip: true
                focus: true
                spacing: 3
                anchors.horizontalCenter: parent.horizontalCenter
                boundsBehavior: Flickable.DragAndOvershootBounds
                highlightFollowsCurrentItem:true
                function amaddActivity(){
                    activityModel.append({"activityName":newActivity})
                    newActivity = ""
                }
                function amdeleteActivity(){
                    activityModel.clear()
                    activityModel.append(DB.getActivityModel())

                    deletedActivity = ""
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

