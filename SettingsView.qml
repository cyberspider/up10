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
        text: "This app was inspired by the 10% rule: It states that you should never increase your weekly mileage by more than 10 percent from the previous week, to avoid injury through over training. <br><br> It's still in beta:V 0.0.1, twitter: @woltemade"
        font.family: fntMyraidPro.name
        font.pixelSize: 20
        color: clrFont
    }

}
