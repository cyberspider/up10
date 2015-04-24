import QtQuick 2.0

Rectangle{
    color: clrBackground
    Image{
        id:bckButton
        source:"images/back.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {screen.state = ""}
        }
    }

    Column{
        id:frmAddAvtivity
        anchors.top: bckButton.bottom
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        Text{
            id:lblAddActivity
            font.family: "Impact"
            text:"  Activity name:"
            color: clrFont
        }
        BorderImage{
            id:txtbg
            source:"images/txtBox.png"
            border.left: 20
            border.right: 20
            border.top: 20
            border.bottom: 20
            width: parent.width
            TextInput {
                id: textInput
                color: clrFont
                text: clrBackground
                font.family: "Arial"
                width:parent.width - 50
                anchors.centerIn: parent
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
                    onPressAndHold: textInput.closeSoftwareInputPanel();
                }
            }
        }
        Image{
            id:btnAddActivity
            source:"images/back.png"
            anchors.right: parent.right
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    screen.state = ""
                    console.log("this gets executed none the less")
                }
            }
        }
    }
}

