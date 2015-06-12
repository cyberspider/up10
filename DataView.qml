import QtQuick 2.0
import "localStorage.js" as DB

Rectangle {

    anchors.fill: parent
    opacity: 0
    color: clrBackground
    signal reloadTheDataView
    onReloadTheDataView: {
        console.debug("FReEEEEE AT LAST!!!!!!!")
        dataViewDay.reloadMe()
//        dataViewWeek.reloadMe()
//        dataViewMonth.reloadMe()
//        dataViewYear.reloadMe()
    }
    VisualItemModel {
        id: itemModel

        DataViewDay{
            id:dataViewDay
            function reloadMe(){
                console.debug("lets reload")
                letsReload()
            }

        }
        DataViewWeek{
            id:dataViewWeek
            function reloadMe(){
                letsReload()
            }
        }
        DataViewMonth{
            id:dataViewMonth
            function reloadMe(){
                letsReload()
            }

        }
        DataViewYear{
            id:dataViewYear
            function reloadMe(){
                letsReload()
            }

        }

    }

    ListView {
        id: view
        anchors {
            fill: parent;
            //bottomMargin: 30
        }
        model: itemModel
        clip: true
        preferredHighlightBegin: 0; preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem; flickDeceleration: 1000
        onCurrentIndexChanged: {

            var mindex = view.currentIndex
            if(mindex == 0){
                //console.debug("moving week to start")
                dataViewDay.showView()
                dataViewWeek.hideView()
            }else if(mindex == 1){
                //console.debug("moving month to week")
                dataViewWeek.showView()
                dataViewMonth.hideView()
            }else if(mindex == 2){
                //console.debug("moving year to start")
                dataViewMonth.showView()
                dataViewYear.hideView()
            }else{
                //console.debug("here we hide them from else")
                dataViewYear.showView()
            }
        }
    }

    Rectangle {
        width: parent.width;
        height: 30
        anchors { top: view.bottom; bottom: parent.bottom }
        //color: "Black"
        //opacity: 0.3

        Row {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -10
            spacing: 10

            Repeater {
                model: itemModel.count

                Rectangle {
                    width: 8; height: 8
                    radius: 4
                    color: view.currentIndex == index ? clrFont : "Gray"

                    MouseArea {
                        width: 20; height: 20
                        anchors.centerIn: parent
                        onClicked: view.currentIndex = index
                    }
                }
            }
        }
    }
}
