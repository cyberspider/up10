import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
Item {

    anchors.bottom: parent.bottom
    width: parent.width
    height:80

    Rectangle{
        anchors.fill: parent
        color: clrBackground
    }
    Row {
        id: toolBarRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: (parent.width / 4) - 77
        Image {
            id: btnToolBar1
            source: "images/btnToolBar_stats.png"
            opacity: 1
            MouseArea{
             anchors.fill: parent
             onClicked: topPanel.state = "dataViewState"
            }
        }
        Image {
            id: btnToolBar2
            source: "images/btnToolBar_edit.png"
            opacity: 1
            MouseArea{
             anchors.fill: parent
             onClicked: topPanel.state = "logViewState"
            }
        }
        Image {
            id: btnToolBar3
            source: "images/btnToolBar_settings.png"
            opacity: 1
            MouseArea{
             anchors.fill: parent
             onClicked: topPanel.state = "settingsViewState"
            }
        }
        Image {
            id: btnToolBar4
            source: "images/btnToolBar_question.png"
            opacity: 1
            MouseArea{
             anchors.fill: parent
             onClicked: {
                 topPanel.state = "helpViewState"
                 //clrBackground = "#a90e1d"
             }
            }
        }
    }
}
