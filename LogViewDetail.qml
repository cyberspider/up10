import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import QtGraphicalEffects 1.0
import "localStorage.js" as DB

Item{
    id:mainItem
    width: screen.width
    Image{
        id:btnBack
        source:"images/back_arrow.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }
        ColorOverlay {
            anchors.fill: btnBack
            source: btnBack
            color: "Orange"
            opacity: 0.5
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
        ColorOverlay {
            anchors.fill: btnDelete
            source: btnDelete
            color: "Red"
            opacity: 0.5
        }
    }
    Column{
        id:logviewdetailcolumn
        anchors.top: btnBack.bottom
        anchors.right: parent.right
        anchors.left:parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 10
        //        TextItem{
        //            id:txtActivity

        //            text: selectedActivity
        //        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            id:txtActivity
            text: selectedActivity
            color: clrFont
            font.family: fntMyraidPro.name
            font.pointSize: 40
        }
        SliderComponent{

        }
        SliderComponent{

        }
    }
}
