import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.LocalStorage 2.0
import QtQuick.Controls.Styles 1.3
import QtQuick.Layouts 1.1
import QtSensors 5.3
import "localStorage.js" as DB

ApplicationWindow {
    id:main
    width:Screen.width
    height:Screen.height
    visible: true
    property int showSplash: 1
    property string clrBackground: "#000000"
    property string clrFont: "White"
    property string newActivity: ""
    property string newActivityUnit: ""
    property string selectedActivity: ""
    property string selectedActivityUnit: ""
    property string deletedActivity: ""
    property int sliderMonthVisible: 0
    property int sliderDayVisible: 0
    property string selectedDate: ""
    property string selectedDateDay: ""
    property string selectedDateWeek: ""
    property string selectedDateMonth: ""
    property string selectedDateYear: ""
    property string selectedSliderValue: ""

    property int sldHund_i: 0
    property int sldTen_i:0
    property int sldOne_i: 0
    property int sldDec_i:0

    signal addActivity()
    signal deleteActivity()

    onAddActivity: {
        logView.addActivity()
    }
    onDeleteActivity: {
        logView.deleteActivity()
    }

    FontLoader { id: fntMyraidPro; source: "font/Myriad Pro Regular.ttf" }

    Rectangle {
        id:bg
        width:Screen.height *1.5
        height: Screen.height*1.5
        anchors.centerIn: parent
        rotation: 75
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#3782bf";
            }
            GradientStop {
                position: 0.33;
                color: "#54a9ed";
            }
            GradientStop {
                position: 0.66;
                color: "#3782bf";
            }
            GradientStop {
                position: 1.00;
                color: "#7abdf3";
            }
        }
        opacity: 1
    }
    Image {
        id: splash
        width: Screen.width / 2
        height:Screen.width / 2
        source: "images/logo.png"
        opacity: showSplash
        anchors.centerIn: parent
    }


    Item{
        id:topPanel
        anchors{
            top:parent.top
            bottom: myToolBar.top
            left:parent.left
            right:parent.right
        }
        DataView{
            id:dataView
            width: Screen.width
        }
        LogView{
            id:logView

            function addActivity(){
                lvaddActivity()
            }
            function deleteActivity(){
                lvdeleteActivity()
            }
        }
        HelpView{
            id:helpView

        }
        SettingsView{
            id:settingsView

        }
//contr
        states: [
            State {
                name: "dataViewState"
                PropertyChanges {
                    target: splash
                    opacity: 0
                }
                PropertyChanges {
                    target: bg
                    opacity: 0
                }
                PropertyChanges {
                    target: myToolBar
                    opacity: 1
                }
                PropertyChanges {
                    target: dataView
                    opacity: 1
                    z:1
                }
            },
            State {
                name: "logViewState"
                PropertyChanges {
                    target: splash
                    opacity: 0
                }

                PropertyChanges {
                    target: myToolBar
                    opacity: 1
                }
                PropertyChanges {
                    target: bg
                    opacity: 1
                }
                PropertyChanges {
                    target: logView
                    opacity: 1
                    z:1
                }

            },
            State {
                name: "logViewDetailState"
                PropertyChanges {
                    target: splash
                    opacity: 0
                }

                PropertyChanges {
                    target: myToolBar
                    opacity: 1
                }
                PropertyChanges {
                    target: bg
                    opacity: 1
                }
                PropertyChanges {
                    target: logViewDetail
                    opacity: 1
                    z:1
                }

            },
            State {
                name: "addActivityViewState"
                PropertyChanges {
                    target: splash
                    opacity: 0
                }

                PropertyChanges {
                    target: myToolBar
                    opacity: 1
                }
                PropertyChanges {
                    target: bg
                    opacity: 1
                }
                PropertyChanges {
                    target: addActivityView
                    opacity: 1
                    z:1
                }
            },
            State {
                name: "settingsViewState"
                PropertyChanges {
                    target: splash
                    opacity: 0
                }

                PropertyChanges {
                    target: myToolBar
                    opacity: 1
                }
                PropertyChanges {
                    target: bg
                    opacity: 1
                }
                PropertyChanges {
                    target: settingsView
                    opacity: 1
                    z:1
                }
            },
            State {
                name: "helpViewState"
                PropertyChanges {
                    target: splash
                    opacity: 0
                }

                PropertyChanges {
                    target: myToolBar
                    opacity: 1
                }
                PropertyChanges {
                    target: bg
                    opacity: 1
                }
                PropertyChanges {
                    target: helpView
                    opacity: 1
                    z:1
                }

            }]
        transitions: [
            Transition {
                NumberAnimation { property: "opacity"; easing.type: Easing.InOutQuad; duration:1000}
            }

        ]
    }
    Item {
//        Timer {
//            interval: 3333; running: true; repeat: false
//            onTriggered: topPanel.state = "dataViewState"
//        }
    }
    Toolbar{
        opacity: 0
        id:myToolBar
        width: Screen.width
    }
    function hideSplashScreen(){

        topPanel.state = "dataViewState"
    }


}
