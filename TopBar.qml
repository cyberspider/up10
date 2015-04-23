import QtQuick 2.0

Rectangle{
    id:topBar
    width:screen.width
    height:75
    color: "Orange"

    Image {
        id: imgToolBarBack
        source: "images/back.png"
    }
    Image {
        id: imgToolBarAdd
        source: "images/add.png"
        anchors.right: parent.right
    }

}
