import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "localStorage.js" as DB

Rectangle {
    width: parent.width
    height: parent.height
    color: clrBackground

    function hideVieW(){
        lvwDays.opacity = 0
    }
    function showVieW(){
        lvwDays.opacity = 1
    }

    Component {
        id: yearDelegate
        Item {
            width: 100; height: 50
            Text { id:txtyear; text: year; color: clrFont; font.family: fntMyraidPro.name; font.pixelSize: 40

                anchors.horizontalCenter: parent.horizontalCenter
            }


            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lvwDays.currentIndex = index


                }
            }
        }
    }

    ListView {
        id:lvwDays
        anchors.fill: parent
        model: YearsModel{id:yearsModel}
        delegate: yearDelegate
        highlight: dayhighlight
        orientation: Qt.Horizontal
        onCurrentItemChanged: {
            //reLoadSliders()
            console.log("nothing happening here3")
            hideSplashScreen()
        }
        highlightMoveDuration: 100
        Component.onCompleted: {

            positionViewAtBeginning()
            console.log("nothing happening here4")
        }
    }

    Component {
        id: dayhighlight

        Rectangle {
            width: 75; height: 75
            color: "lightsteelblue"; opacity: 0.25
            x: lvwDays.currentItem.x
            z:10
            Behavior on x {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }
    }

}
