import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
Item {
    anchors.verticalCenter: bg.bottom
    anchors.verticalCenterOffset: -100
    Row{
        id: toolBarRow
        spacing: 4
        //height:160

        Image {
            id: btnToolBar1
            source: "images/btnToolBar1.png"
            opacity: 1
            MouseArea{
             anchors.fill: parent
             onClicked: topPanel.state = "dataViewState"
            }
        }
        Image {
            id: btnToolBar2
            source: "images/btnToolBar2.png"
            opacity: 1
            MouseArea{
             anchors.fill: parent
             onClicked: topPanel.state = "logViewState"
            }
        }
        Image {
            id: btnToolBar3
            source: "images/btnToolBar3.png"
            opacity: 1
            MouseArea{
             anchors.fill: parent
             onClicked: topPanel.state = "settingsViewState"
            }
        }
        Image {
            id: btnToolBar4
            source: "images/btnToolBar4.png"
            opacity: 1
            MouseArea{
             anchors.fill: parent
             onClicked: topPanel.state = "helpViewState"
            }
        }
    }
}
