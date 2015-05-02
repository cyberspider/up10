import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "localStorage.js" as DB
Rectangle{
    color: clrBackground
    Image{
        id:bckButton
        source:"images/back.png"
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
        source:"images/back.png"
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
}


