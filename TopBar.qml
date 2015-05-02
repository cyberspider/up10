import QtQuick 2.0

Rectangle{
    id:topBar
    width:screen.width
    height:75
    color: clrBackground

    Image {
        id: imgToolBarAdd
        source: "images/add.png"
        anchors.right: parent.right
        MouseArea{
            anchors.fill: parent
            onClicked: {
                screen.state = "stateActivityAdd"
            }
        }
    }

}
