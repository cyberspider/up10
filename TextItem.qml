import QtQuick 2.0

BorderImage{
    id:txtbg
    width:parent.width
    source:"images/txtBox.png"
    border.left: 18
    border.right: 18
    border.top: 18
    border.bottom: 18
    property alias text: textInput.text

    TextInput {
        id: textInput
        color: clrFont
        text: parent.text
        font.family: "Arial"
        font.pixelSize: 25
        anchors.margins: 20
        anchors.fill: parent
        clip:true
        activeFocusOnPress: false
        //cursorVisible: true

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!textInput.activeFocus) {
                    textInput.forceActiveFocus()
                    //textInput.openSoftwareInputPanel();
                } else {
                    textInput.focus = false;
                }
            }
            //onPressAndHold: textInput.closeSoftwareInputPanel();
        }
    }
}
