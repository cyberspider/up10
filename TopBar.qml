import QtQuick 2.0
import QtGraphicalEffects 1.0
Rectangle{
    id:topBar
    width:screen.width
    height:75
    color: clrBackground

    Image {
        id: btnAdd
        source: "images/new/btn_add.png" //"images/add.png"
        anchors.right: parent.right
        MouseArea{
            anchors.fill: parent
            onClicked: {
                screen.state = "stateActivityAdd"
            }
        }
    }
    ColorOverlay {
        anchors.fill: btnAdd
        source: btnAdd
        color: staticClrGreen
        opacity: staticOpacity
    }

}
