import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2
import "localStorage.js" as DB

Rectangle{
    color: clrBackground
    id:mainItem
    width: parent.width - 10

    property real milesDone: {

        if (sldDecimal.value > 0)  {
            sldHundred.value + sldTen.value + sldOne.value + (sldDecimal.value / 10)
        }else{
            sldHundred.value + sldTen.value + sldOne.value
        }

    }

    signal reloadSliders
    onReloadSliders: {
        //        sldDec_i = 1
        //        sldTen_i = 10
        //        sldOne_i = 1
        //        sldHund_i = 100

        sldcompday.reloadMeSliders()

    }
    Image{
        id:btnBack
        source: "images/new/btn_back.png" //"images/back_arrow.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }
    }

    Image{
        id:btnDelete
        source:"images/new/btn_delete.png" //"images/delete.png"
        anchors.right: parent.right
        MouseArea{
            anchors.fill: parent
            onClicked: {
                messageDialog.visible = true

            }
        }
    }

    ColorOverlay {
        anchors.fill: btnBack
        source: btnBack
        color: staticClrYellow
        opacity: staticOpacity

    }
    ColorOverlay {
        anchors.fill: btnDelete
        source: btnDelete
        color: staticClrRed
        opacity: staticOpacity
    }
    Column{
        id:logviewdetailcolumn
        anchors.top: btnDelete.bottom
        anchors.right: parent.right
        anchors.left:parent.left
        anchors.margins: 10
        spacing: 10
        Text{
            id:txtActivity
            text: selectedActivity
            color: clrFont
            font.family: fntMyraidPro.name
            font.pointSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: txtUnits
            text: milesDone.toString()
            color: clrFont
            font.family: fntMyraidPro.name
            font.pointSize: 40
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: txtUnitsMeasurement
                anchors.left: txtUnits.right
                anchors.bottom: txtUnits.bottom
                anchors.bottomMargin: 5
                text: " " + selectedActivityUnit
                color: clrFont
                font.family: fntMyraidPro.name
                font.pointSize: 20
            }
        }
        Slider {
            id:sldHundred
            width: parent.width
            maximumValue: 900
            minimumValue : 0
            stepSize : 100
            //tickmarksEnabled : true
            updateValueWhileDragging : true
            value : sldHund_i

        }
        Slider {
            id:sldTen
            width: parent.width
            maximumValue: 90
            minimumValue : 0
            stepSize : 10
            updateValueWhileDragging : true
            value : sldTen_i

        }
        Slider {
            id:sldOne
            width: parent.width
            maximumValue: 9
            minimumValue : 0
            stepSize : 1
            updateValueWhileDragging : true
            value : sldOne_i

        }
        Slider {
            id:sldDecimal
            width: parent.width
            maximumValue: 9
            minimumValue : 0
            stepSize : 1
            tickmarksEnabled : true
            updateValueWhileDragging : true
            value : sldDec_i

        }

        Rectangle{
            id:spaceman
            color: clrBackground
            height: 15
            width: 20
        }

        SliderComponentDay{
            id:sldcompday
            width: parent.width
            height: 75
            opacity: sliderDayVisible
            function reloadMeSliders(){

                reLoadSliders()
            }
        }
        Rectangle{
            id:spaceman2
            color: clrBackground
            height: 5
            width: 20
        }

        Image{
            id:btnAddActivity
            source: "images/new/btn_save.png"//"images/save.png"
            anchors.right:parent.right
            MouseArea{
                id:mouseArea
                anchors.fill: parent
                onClicked: {

                    //save the slider values with date for the activity
                    selectedSliderValue = parseInt(sldHundred.value) + parseInt(sldTen.value) + parseInt(sldOne.value)
                    selectedSliderValue += "." + sldDecimal.value
                    //console.debug(selectedSliderValue + "<-------------")
                    DB.saveLogBookEntry(selectedDateDay, selectedDateWeek, selectedDateMonth, selectedDateYear, selectedActivity, selectedSliderValue)
                    //console.debug(txtActivity.text + ":" + selectedDate + ":" + sldHundred.value + sldTen.value + sldOne.value + sldDecimal.value)
                    reloadSlidersFE()
                }

            }
            ColorOverlay {
                anchors.fill: btnAddActivity
                source: btnAddActivity
                color: staticClrBlue
                opacity: staticOpacity
            }
            states: State {
                name: "pressed"; when: mouseArea.pressed
                PropertyChanges { target: txtUnits; scale: 2.8 }
                //PropertyChanges { target: txtUnits; rotation: 360 }
            }

            transitions: Transition {
                NumberAnimation { properties: "scale"; duration: 10; easing.type: Easing.InOutQuad }
                //NumberAnimation { properties: ["scale", "rotation"]; duration: 10; easing.type: Easing.InOutQuad }
            }
        }
    }

    MessageDialog {
        id: messageDialog
        title: "Delete Activity?"
        text: "Are you sure you want to delete " + selectedActivity + " and all its data?"
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            console.debug("deleting " + selectedActivity)
            //            //delete the item here
            DB.deleteActivity(selectedActivity)
            deletedActivity = selectedActivity
            main.deleteActivity();
            screen.state = ""
        }

        onNo: {console.debug("not deleting")}
    }

}
