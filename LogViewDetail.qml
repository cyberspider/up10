import QtQuick 2.0

Item{
    id:mainItem
    Image {
        id: img
        source: "images/logo.png"
        width: screen.width/2
        height: screen.width/2
    }
    Image{
        id:bckButton
        source:"images/back.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }

    }
}
