import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "localStorage.js" as DB

Rectangle {
    width: parent.width
    height: parent.height
    color: clrBackground
    Component {
        id: dayDelegate
        Item {
            width: 75; height: 75

            Text { id:txtmonth; text: month; color: clrFont; font.family: fntMyraidPro.name; font.pixelSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text { id:txtday; text: day; color: clrFont; font.family: fntMyraidPro.name; font.pixelSize: 40
                anchors.top:txtmonth.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text { id:txtyear; text: year; color: clrFont; font.family: fntMyraidPro.name; font.pixelSize: 15
                anchors.top:txtday.bottom
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    lvwDays.currentIndex = index
                    //day item click here

                }
            }
        }
    }

    ListView {
        id:lvwDays
        anchors.fill: parent
        model: DaysModel{id:daysModel}//DaysModel {}
        delegate: dayDelegate
        highlight: dayhighlight
        orientation: Qt.Horizontal
        onCurrentItemChanged: {
            reLoadSliders()
        }
        highlightMoveDuration: 100
        Component.onCompleted: {

            positionViewAtBeginning()

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
    signal reLoadSliders()
    onReLoadSliders: {

        //lets get the values from DB here and set interface
        //            console.log(lvwDays.model.get(lvwDays.currentIndex).day)
        //            console.log(lvwDays.model.get(lvwDays.currentIndex).month)
        //            console.log(lvwDays.model.get(lvwDays.currentIndex).year)
        selectedDateDay = lvwDays.model.get(lvwDays.currentIndex).day
        selectedDateMonth = lvwDays.model.get(lvwDays.currentIndex).month
        selectedDateYear = lvwDays.model.get(lvwDays.currentIndex).year
        selectedDate = lvwDays.model.get(lvwDays.currentIndex).day + "/" + lvwDays.model.get(lvwDays.currentIndex).month + "/" + lvwDays.model.get(lvwDays.currentIndex).year

        var munique = (selectedDateDay + selectedDateMonth + selectedDateYear).toString()
        munique += selectedActivity.toString().toUpperCase()
        console.log("munique:" + munique)

        sldHundred.value = DB.getSliderHundred(munique)
        sldTen.value = DB.getSliderTen(munique)
        sldOne.value = DB.getSliderOne(munique)
        sldDecimal.value = DB.getSliderDecimal(munique)
    }
}
