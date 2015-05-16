import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0
import "localStorage.js" as DB


Item{
    id:mainItem
    width: parent.width - 10
    property real milesDone: {
        if (sldDecimal.value > 0)  {
            sldHundred.value + sldTen.value + sldOne.value + (sldDecimal.value / 10)
        }else{
            sldHundred.value + sldTen.value + sldOne.value
        }
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
                //delete the item here
                DB.deleteActivity(selectedActivity)
                deletedActivity = selectedActivity
                main.deleteActivity();
                screen.state = ""
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
        anchors.top: btnBack.bottom
        anchors.right: parent.right
        anchors.left:parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        spacing: 10
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            id:txtActivity
            text: selectedActivity
            color: clrFont
            font.family: fntMyraidPro.name
            font.pointSize: 20
        }
        Text {
            id: txtUnits
            anchors.horizontalCenter: parent.horizontalCenter
            text: milesDone.toString()
            color: clrFont
            font.family: fntMyraidPro.name
            font.pointSize: 40

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
            value : 0

        }
        Slider {
            id:sldTen
            width: parent.width
            maximumValue: 90
            minimumValue : 0
            stepSize : 10
            //tickmarksEnabled : true
            updateValueWhileDragging : true
            value : 0

        }
        Slider {
            id:sldOne
            width: parent.width
            maximumValue: 9
            minimumValue : 0
            stepSize : 1
            //tickmarksEnabled : true
            updateValueWhileDragging : true
            value : 0

        }
        Slider {
            id:sldDecimal
            width: parent.width
            maximumValue: 9
            minimumValue : 0
            stepSize : 1
            tickmarksEnabled : true
            updateValueWhileDragging : true
            value : 0

        }

        Rectangle{
            id:spaceman
            color: clrBackground
            height: 15
            width: 20
        }


        SliderComponentMonth{
            id:sldcompmonth
            width: mainItem.width
            anchors.left: parent.left
            z:10
        }
        SliderComponentDay{
            id:sldcompday
            width: mainItem.width
            anchors.left: parent.left
            z:10
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
                    //DB.saveActivity(txtItem.text);
                    //newActivity = txtItem.text;
                    //main.addActivity();
                    //screen.state = "";
                    console.log("saving private Ryan.")
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
}
