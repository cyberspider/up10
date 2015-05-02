import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "localStorage.js" as DB
Item{
    id:mainItem

    Image{
        id:btnBack
        source:"images/back.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }

    }

    TextItem{
        id:txtActivity
        anchors.top: btnBack.bottom
        text: selectedActivity
    }
    Image{
        id:btnDelete
        anchors.top:txtActivity.bottom
        source:"images/back.png"
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
}
