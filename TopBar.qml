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
        //opacity: 0
        MouseArea{
            anchors.fill: parent
            onClicked: {
                screen.state = "stateActivityAdd"
            }
        }
    }

    ColorOverlay {
        anchors.fill: btnAdd
        source: buf1
        color: staticClrGreen
        opacity: staticOpacity
    }
    ShaderEffectSource {
        id:buf1;
        recursive:true;
        sourceItem: btnAdd;
    }
}
