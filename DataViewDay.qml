import QtQuick 2.0
import QtQuick.Window 2.0

Rectangle {
    width: view.width; height: view.height
    color: clrBackground
    function hideView(){
        sldcompday2.hideView()
    }
    function showView(){
        sldcompday2.showView()
    }

    SliderComponentDay{
        id:sldcompday2
        z:5
        width: Screen.width
        height: 75
        function showView(){
            showVieW()
        }
        function hideView(){
            hideVieW()
        }

    }

    ListView {
        id: sliderDay
        anchors.top: sldcompday2.bottom
        width: parent.width -10
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        z:0
        snapMode: ListView.SnapToItem
        spacing: 5
        Component {
            id: contactsDelegate
            Rectangle {
                id: wrapper
                width: parent.width
                height: 90
                color: clrBackground
                Rectangle{
                    id:spacer
                    height:20
                }

                Text {
                    id: activityName
                    anchors.top:spacer.bottom
                    text: name + ": "
                    font.family: fntMyraidPro.name
                    font.pixelSize: 25
                    color: clrFont
                    width: parent.width
                    Item{
                        id:txtBoxes
                        width:wrapper.width/3
                        anchors.top:activityName.bottom

                        Text{
                            id:txtToday
                            anchors.top:txtBoxes.bottom
                            anchors.right:txtBoxes.right
                            font.family: fntMyraidPro.name
                            font.pixelSize: 15
                            text: "Today: " + today
                            color: clrFont
                        }

                        Text{
                            id:txtYesterday
                            anchors.top: txtToday.bottom
                            anchors.right:txtBoxes.right
                            font.family: fntMyraidPro.name
                            font.pixelSize: 15
                            color: clrFont
                            text: "Yesterday: " + yesterday
                        }
                        Text{
                            id:txtMax
                            anchors.top:txtYesterday.bottom
                            anchors.right:txtBoxes.right
                            font.family: fntMyraidPro.name
                            font.pixelSize: 15
                            text: "Max: " + max
                            color: clrFont
                        }

                    }

                    Rectangle{
                        id:rectToday
                        anchors.top:txtBoxes.bottom
                        anchors.left: txtBoxes.right
                        width: (today / max) * graphBarWidth
                        height:10
                        color: "#7abdf3"
                        border.width: 2
                        anchors.margins: 4
                    }

                    Rectangle{
                        id:rectDayBefore
                        anchors.top: rectToday.bottom
                        anchors.left: txtBoxes.right
                        width:(yesterday / max) * graphBarWidth
                        height:10
                        color: "#54a9ed"//#7abdf3
                        border.width: 2
                        anchors.margins: 4
                    }

                    Rectangle{
                        id:rectMax
                        anchors.top: rectDayBefore.bottom
                        anchors.left: txtBoxes.right
                        width: (max>0) ? graphBarWidth : 0
                        height:10
                        color: "#3782bf"//"#54a9ed"//#7abdf3
                        border.width: 2
                        anchors.margins: 4
                    }
                }
            }
        }
        model: DataViewDaysModel{id:dataViewDaysModel}
        delegate: contactsDelegate
        focus: true
    }
}

