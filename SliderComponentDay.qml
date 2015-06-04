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
                    if (typeof dataViewDaysModel === "undefined"){}else{
                        dataViewDaysModel.clear()
                        dataViewDaysModel.append(DB.getDataViewDayModel())
                    }
                }
            }
        }
    }

    ListView {
        id:lvwDays
        anchors.fill: parent
        model: DaysModel{id:daysModel}
        delegate: dayDelegate
        highlight: dayhighlight
        orientation: Qt.Horizontal
        onCurrentItemChanged: {
            sldHund_i = 1
            sldDec_i = 1
            sldOne_i = 1
            sldTen_i = 1
            console.log("set variables for sliders...")
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

        selectedDateDay = lvwDays.model.get(lvwDays.currentIndex).day
        selectedDateMonth = lvwDays.model.get(lvwDays.currentIndex).month
        selectedDateYear = lvwDays.model.get(lvwDays.currentIndex).year
        selectedDate = lvwDays.model.get(lvwDays.currentIndex).day + "/" + lvwDays.model.get(lvwDays.currentIndex).month + "/" + lvwDays.model.get(lvwDays.currentIndex).year
        var tempMonth = new Date((DB.getMonthNumber(selectedDateMonth) + "/" + selectedDateDay + "/" + selectedDateYear).toString())
        selectedDateWeek = DB.getWeekNumber(tempMonth)

        var munique = (selectedDateDay + selectedDateMonth + selectedDateYear).toString()
        munique += selectedActivity.toString().toUpperCase()
        //console.log("munique:" + munique)

        sldHund_i = DB.getSliderHundred(munique)
        sldTen_i = DB.getSliderTen(munique)
        sldOne_i = DB.getSliderOne(munique)
        sldDec_i = DB.getSliderDecimal(munique)
        var selectedYesterDateDay = 0
        var selectedYesterDateMonth = 0
        var selectedYesterDateYear = 2012
        var selectedYesterDate = 0

        if (lvwDays.currentIndex + 1 < lvwDays.model.count) {
            selectedYesterDateDay = lvwDays.model.get(lvwDays.currentIndex + 1).day
            selectedYesterDateMonth = lvwDays.model.get(lvwDays.currentIndex + 1).month
            selectedYesterDateYear = lvwDays.model.get(lvwDays.currentIndex+ 1).year
        }

        selectedYesterDate = selectedYesterDateDay + "/" + selectedYesterDateMonth + "/" + selectedYesterDateYear

        var muniqueYesterday = (selectedYesterDateDay + selectedYesterDateMonth + selectedYesterDateYear).toString()
        muniqueYesterday += selectedActivity.toString().toUpperCase()
        //console.log(muniqueYesterday)

    }

}
