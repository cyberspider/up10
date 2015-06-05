import QtQuick 2.0

Rectangle{
    color: clrBackground
    anchors.fill: parent
    opacity: 0


    Text {
        id: txtSettings
        anchors.fill: parent
        anchors.margins: 25
        wrapMode: Text.Wrap
        clip: true
        text: "This app was inspired by the 10% rule: It states that you should never increase your weekly mileage by more than 10 percent previous week, to avoid injury through over training (running). <br><br> It was created with love to replace the printed calendar paper on my girlfriend's closet door.<br><br>Oh, and it is in beta:V 0.0.1, twitter: @woltemade"
        font.family: fntMyraidPro.name
        font.pixelSize: 20
        color: clrFont
    }

}
