import QtQuick 2.0

Rectangle{

    color: "Yellow"
    Image{
        id:bckButton
        source:"images/back.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }

    }
    Text {
        id: addActivityText
        text: qsTr("adding activities here..")
    }
}


