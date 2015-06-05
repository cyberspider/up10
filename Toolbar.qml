import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
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
                id: mouseArea
                anchors.fill: parent
                onClicked: {

                    topPanel.state = "dataViewState"

                }
//                states: State {
//                    name: "pressed"; when: mouseArea.pressed
//                    PropertyChanges { target: btnToolBar1; scale: 2.8 }
//                }

//                transitions: Transition {
//                    NumberAnimation { properties: "scale"; duration: 10; easing.type: Easing.InOutQuad }
//                }
            }
            ShaderEffectSource {
                id:buf1;
                recursive:true;
                sourceItem: btnToolBar1;
            }
            ColorOverlay {
                id:clroverlay1
                anchors.fill: btnToolBar1
                color: clrStats
                opacity: staticOpacity
                source: buf1

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
            ShaderEffectSource {
                id:buf2;
                recursive:true;
                sourceItem: btnToolBar2;
            }
            ColorOverlay {
                id:clroverlay2
                anchors.fill: btnToolBar2
                color: clrEdit
                opacity: staticOpacity
                source: buf2

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
            ShaderEffectSource {
                id:buf4;
                recursive:true;
                sourceItem: btnToolBar4;
            }
            ColorOverlay {
                id:clroverlay4
                anchors.fill: btnToolBar4
                color: clrHelp
                opacity: staticOpacity
                source: buf4

            }
        }
        Image {
            id: btnToolBar3
            source: "images/btnToolBar_about.png"
            opacity: 1
            MouseArea{
                anchors.fill: parent
                onClicked: topPanel.state = "settingsViewState"
            }
            ShaderEffectSource {
                id:buf3;
                recursive:true;
                sourceItem: btnToolBar3;
            }
            ColorOverlay {
                id:clroverlay3
                anchors.fill: btnToolBar3
                color: clrSettings
                opacity: staticOpacity
                source: buf3

            }
        }

    }

}
