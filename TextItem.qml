import QtQuick 2.0

BorderImage{
    id:txtbg
    width:parent.width
    source:"images/txtBox.png"
    border.left: 20
    border.right: 20
    border.top: 20
    border.bottom: 20
    property alias text: textInput.text

    TextInput {
        id: textInput
        color: clrFont
        text: parent.text
        font.family: "Arial"
        font.pixelSize: 20
        anchors.margins: 25
        anchors.fill: parent
        clip:true
        activeFocusOnPress: false
        cursorVisible: true

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
