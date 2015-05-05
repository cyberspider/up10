import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import QtGraphicalEffects 1.0
import "localStorage.js" as DB
Rectangle{
    color: clrBackground
    width: parent.width - 10
    //anchors.horizontalCenter: parent.horizontalCenter
    Image{
        id:btnBack
        source:"images/back_arrow.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }
    }
    Item{
        id:spaceman
        anchors.top:btnBack.bottom
        height: 25
    }

    Rectangle{
        id:frmAddAvtivity
        width:parent.width
        anchors.top:spaceman.bottom
        color: "green"
        z:1

        Text{
            id:lblAddActivity
            font.family: fntMyraidPro.name
            text:"  Activity name:"
            color: clrFont
        }
        TextItem{
            id:txtItem
            anchors.top: lblAddActivity.bottom
            focus: true

        }
        Item{
            id:spaceman2
            anchors.top:txtItem.bottom
            height: 25
        }
        Text{
            id:lblAddActivityUnit
            anchors.top: spaceman2.bottom
            font.family: fntMyraidPro.name
            text:"  Measuring unit:"
            color: clrFont
        }
        TextItem{
            id:txtItemUnit
            anchors.top: lblAddActivityUnit.bottom
        }
        Image{
            id:btnAddActivity
            anchors.top: txtItemUnit.bottom
            source:"images/save.png"
            anchors.right: parent.right
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    DB.saveActivity(txtItem.text);
                    newActivity = txtItem.text;
                    main.addActivity();
                    screen.state = "";
                }
            }
        }
        ColorOverlay {
            anchors.fill: btnAddActivity
            source: btnAddActivity
            color: "Green"
            opacity: 0.5
        }
    }
    ColorOverlay {
        anchors.fill: btnBack
        source: btnBack
        color: "Orange"
        opacity: 0.5
    }
}


