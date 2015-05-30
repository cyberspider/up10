/*
import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "localStorage.js" as DB

ListModel {

    signal refresh()

    Component.onCompleted: refresh()

    onRefresh: {
        monthsModel.clear()
        monthsModel.append(DB.getMonthsModel())
    }
 }
*/
import QtQuick 2.0
ListModel {
    ListElement {
        month: "February"
        year: "2015"
    }
    ListElement {
        month: "September"
        year: "2015"
    }
    ListElement {
        month: "January"
        year: "2015"
    }
    ListElement {
        month: "November"
        year: "2015"
    }
    ListElement {
        month: "October"
        year: "2015"
    }
    ListElement {
        month: "January"
        year: "2015"
    }
    ListElement {
        month: "December"
        year: "2015"
    }
    ListElement {
        month: "October"
        year: "2015"
    }
    ListElement {
        month: "January"
        year: "2015"
    }
    ListElement {
        month: "December"
        year: "2015"
    }
    ListElement {
        month: "October"
        year: "2015"
    }
}
