import QtQuick 2.0
import QtQuick.Window 2.0

Rectangle {
    width: view.width; height: view.height
    color: clrBackground
    function hideView(){
        sldcompweek.hideView()
    }
    function showView(){
        sldcompweek.showView()
    }
    SliderComponentWeek{
        id:sldcompweek
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
        id:sliderWeek
        anchors.top: sldcompweek.bottom
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
                            text: "This: " + thisweek
                            color: clrFont
                        }

                        Text{
                            id:txtYesterday
                            anchors.top: txtToday.bottom
                            anchors.right:txtBoxes.right
                            font.family: fntMyraidPro.name
                            font.pixelSize: 15
                            color: clrFont
                            text: "Prev: " + yesterweek
                        }
                        Text{
                            id:txtMax
                            anchors.top:txtYesterday.bottom
                            anchors.right:txtBoxes.right
                            font.family: fntMyraidPro.name
                            font.pixelSize: 15
                            text: "Max: " + maxweek
                            color: clrFont
                        }

                    }

                    Rectangle{
                        id:rectToday
                        anchors.top:txtBoxes.bottom
                        anchors.left: txtBoxes.right
                        width:(thisweek / maxweek) * graphBarWidth
                        height:10
                        color: "#b2fb64"
                        border.width: 2
                        anchors.margins: 4
                    }
                    Rectangle{
                        id:rectDayBefore
                        anchors.top: rectToday.bottom
                        anchors.left: txtBoxes.right
                        width:(yesterweek / maxweek) * graphBarWidth
                        height:10
                        color: "#7ded53"
                        border.width: 2
                        anchors.margins: 4
                    }
                    Rectangle{
                        id:rectMax
                        anchors.top: rectDayBefore.bottom
                        anchors.left: txtBoxes.right
                        width: (maxweek>0) ? graphBarWidth : 0
                        height:10
                        color: "#54bf36"
                        border.width: 2
                        anchors.margins: 4
                    }
                }
            }
        }
        model: DataViewWeeksModel{id:dataViewWeeksModel}
        delegate: contactsDelegate
        focus: true
    }
}
