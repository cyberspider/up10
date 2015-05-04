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
    Text{
        id:lblAddActivity
        anchors.bottom: txtItem.top
        font.family: "Impact"
        text:"  Activity name:"
        color: clrFont
    }
    TextItem{
        id:txtItem
        anchors.verticalCenter: parent.verticalCenter

    }
    Image{
        id:btnAddActivity
        anchors.top: txtItem.bottom
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
    ColorOverlay {
        anchors.fill: btnBack
        source: btnBack
        color: "Orange"
        opacity: 0.5
    }
}


