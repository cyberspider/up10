import QtQuick 2.0

Item{
    id:mainItem

    Image{
        id:bckButton
        source:"images/back.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }

    }

    TextItem{
        id:txtActivity
        anchors.top: bckButton.bottom
        text: selectedActivity
    }
}
