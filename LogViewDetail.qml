import QtQuick 2.0

Item{

    Image {
        id: img
        source: "images/logo.png"
        width: screen.width
        height: screen.width
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
