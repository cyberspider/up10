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
        sldcompday.reloadMeSliders()
    }
    Image{
        id:btnBack
        source:"images/back_arrow.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }
    }
    Image{
        id:btnDelete
        source:"images/delete.png"
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
        color: "Orange"
        opacity: 0.5

    }
    ColorOverlay {
        anchors.fill: btnDelete
        source: btnDelete
        color: "Red"
        opacity: 0.5
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
                console.log("reload here?")
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
            source:"images/save.png"
            anchors.right:parent.right
            MouseArea{
                anchors.fill: parent
                onClicked: {

                    //save the slider values with date for the activity
                    selectedSliderValue = parseInt(sldHundred.value) + parseInt(sldTen.value) + parseInt(sldOne.value)
                    selectedSliderValue += "." + sldDecimal.value
                    //console.log(selectedSliderValue + "<-------------")
                    DB.saveLogBookEntry(selectedDateDay, selectedDateWeek, selectedDateMonth, selectedDateYear, selectedActivity, selectedSliderValue)
                    //console.log(txtActivity.text + ":" + selectedDate + ":" + sldHundred.value + sldTen.value + sldOne.value + sldDecimal.value)
                    reloadSlidersFE()
                }
            }
            ShaderEffectSource {
                id:buf1;
                recursive:true;
                sourceItem: btnAddActivity;
            }
            ColorOverlay {
                id:clroverlay
                anchors.fill: btnAddActivity
                color: "Green"
                opacity: 0.5
                source: buf1
                //property variant src: buf1;
            }
        }
    }

    MessageDialog {
        id: messageDialog
        title: "Delete Activity?"
        text: "Are you sure you want to delete " + selectedActivity + " and all its data?"
        standardButtons: StandardButton.Yes | StandardButton.No
        onYes: {
            console.log("deleting " + selectedActivity)
            //            //delete the item here
            DB.deleteActivity(selectedActivity)
            deletedActivity = selectedActivity
            main.deleteActivity();
            screen.state = ""
        }

        onNo: {console.log("not deleting")}
    }

}
