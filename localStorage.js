var db;
var today = new Date();
var daysModel = [];
var weeksModel = [];
var monthsModel = [];
var yearsModel = [];

var dataViewDaysModel = [];
var dataViewWeeksModel = [];
var dataViewMonthsModel = [];
var dataViewYearsModel = [];

var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
var slider1 = 0
function openDB() {

    if(db !== undefined) return;
    //console.log("opening db")
    // db = LocalStorage.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
    db = LocalStorage.openDatabaseSync("Up10v1", "0.1", "Simple Up10 app", 100000);
    //setupDB()

}

function setupDB(){
    try {
        db.transaction(function(tx){
            //Create tables first
            //tx.executeSql('DROP TABLE activities');
            //tx.executeSql('DROP TABLE settings');
            //tx.executeSql('DROP TABLE logbook');
            //tx.executeSql('CREATE TABLE IF NOT EXISTS activities(activity varchar(50) UNIQUE, measurement TEXT)');
            //measurement can be D - Distance, T - Time, R - Reps
            var table  = tx.executeSql("SELECT * FROM activities");
            // Seed the table with default values
            if (table.rows.length === 0) {
                tx.executeSql('INSERT INTO activities VALUES(?, ?)', ["Swimming", "laps"]);
                tx.executeSql('INSERT INTO activities VALUES(?, ?)', ["Running", "km"]);
                tx.executeSql('INSERT INTO activities VALUES(?, ?)', ["Cycling", "km"]);

                //console.log('Activities table added.');
            };

            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(mkey TEXT, mvalue TEXT)');
            table = tx.executeSql('SELECT * from settings');
            if (table.rows.length === 0) {
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["Use Metric System", "1"]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["TimePeriod", "2"]);
                //First Run - set start date if not found
                var strtdt = new Date(Date.now());
                strtdt.setDate(1);
                strtdt.setMonth(strtdt.getMonth()-1);
                //console.log("startdate:" + strtdt)
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["Startdate", strtdt]);
                console.log('Settings table added');

            }

            tx.executeSql('CREATE TABLE IF NOT EXISTS logbook(mid TEXT, day NUMERIC, week NUMERIC, month NUMERIC, year NUMERIC, activity TEXT, value NUMERIC)');

            doInitialSettings()
        });
    } catch (err) {
        console.log("Error creating table in database: " + err);
    };
}

function doInitialSettings(){

    var start = new Date(getSetting("Startdate"))
    var end = new Date();
    end.setDate(end.getDate() + 1);

    // console.log("building daysModel from:" + start + " to:" + end)
    while(start < end){
        //console.log("adding a day")
        daysModel.push({"day": "" + start.getDate()  , "month": "" + months[start.getMonth()], "year": "" + start.getFullYear()})
        //increment while loop
        var newDate = start.setDate(start.getDate() + 1);
        start = new Date(newDate);
    }
    daysModel.reverse()
}

function getActivityModel(){
    var initialActivity = ""
    var activities = []
    openDB();
    //console.log("attempting to get model:")
    db.transaction(function(tx) {
        //      tx.executeSql('Delete from activities;')
        var rs = tx.executeSql('SELECT activity, measurement FROM activities;')

        for(var i = 0; i < rs.rows.length; i++) {
            if (initialActivity == "") initialActivity = rs.rows.item(i).activity
            activities.push({"activityName": "" + rs.rows.item(i).activity , "activityUnit": "" + rs.rows.item(i).measurement + ""})
        }
    });
    selectedActivity = initialActivity
    return activities;
}

function getDaysModel(){
    if (daysModel.length <=0){
        doInitialSettings()
    }

    return daysModel;
}

function getWeeksModel(){

    if (weeksModel.length <=0){

        var startDate = new Date(getSetting("Startdate"))
        var today = new Date()
        var fromWeek = getWeekNumber(startDate)
        var toWeek = getWeekNumber(today)
        //check if year is not the same, start from first week
        if (startDate.getFullYear() !== today.getFullYear()) fromWeek = 1
        //console.log("weeks from:" + fromWeek + " to: " + toWeek)
        for (var x=parseInt(fromWeek);x <= parseInt(toWeek);x++){
            weeksModel.push({"week": x, "month":"Week", "year":today.getFullYear()})
        }
    }
    weeksModel.reverse()
    return weeksModel;
}

function getMonthsModel(){

    if (monthsModel.length <=0){
        var startDate = new Date(getSetting("Startdate"))
        var today = new Date()
        var fromMonth = startDate.getMonth()//0 based
        var toMonth = today.getMonth()
        //check if year is NOT the same, then we start from January
        if (startDate.getFullYear() !== today.getFullYear()) fromMonth = 1
        //console.log("months from:" + fromMonth + " to: " + toMonth)
        for (var x=parseInt(fromMonth);x <= parseInt(toMonth);x++){
            monthsModel.push({"month":months[x], "year":today.getFullYear()})
            //console.log(months[x])
        }
    }
    monthsModel.reverse()
    return monthsModel;
}

function getYearsModel(){
    if (yearsModel.length <=0){
        var startDate = new Date(getSetting("Startdate"))
        var today = new Date()
        var fromYear = startDate.getFullYear()
        var toYear = today.getFullYear()
        //check if year is NOT the same, then we start from January
        //console.log("from YEAR:" + fromYear + "To YEAR:" + toYear)

        for (var x=parseInt(fromYear);x <= parseInt(toYear);x++){
            yearsModel.push({"year":x})
        }
    }

    yearsModel.reverse()
    return yearsModel;
}

function getDataViewDayModel(){
    var str_activity = ""
    var str_max = ""
    var str_today = ""
    dataViewDaysModel = [];
    openDB()
    var res = ""

    if (selectedDateYear == "") selectedDateYear = today.getFullYear()
    if (selectedDateMonth == "") selectedDateMonth = months[today.getMonth()]
    if (selectedDateDay == "") selectedDateDay = today.getDay()

    //get yesterdays month and year etc.
    var tmp_today = new Date(getMonthNumber(selectedDateMonth.toString())  + "/" + selectedDateDay.toString() + "/" + selectedDateYear.toString());
    var tmp_yesterday = new Date(tmp_today)
    tmp_yesterday.setDate(tmp_today.getDate() - 1)

    var str_yesterday = tmp_yesterday.getDay()
    var str_yestermonth = tmp_yesterday.getMonth()
    var str_yesteryear = tmp_yesterday.getFullYear()

    //console.log("yesterday:" + str_yesterday + ",yestermonth:" + months[parseInt(str_yestermonth)] + ", yesteryear:" + str_yesteryear)
    //console.log("getDataViewDayModel:::::selected day:" + selectedDateDay + "-" + selectedDateMonth + "-" + selectedDateYear)

    db.transaction(function(tx) {
        var rsActivitites = tx.executeSql('SELECT * FROM activities');
        for(x=0;x<rsActivitites.rows.length;x++){
            str_activity = rsActivitites.rows.item(x).activity

            var rsYesterday = tx.executeSql('SELECT * FROM logbook WHERE day=? and month=? and year=? and activity=?;', [str_yesterday.toString(), months[parseInt(str_yestermonth)], str_yesteryear.toString(), str_activity]);
            var rsMax = tx.executeSql('SELECT MAX(value) as max FROM logbook WHERE activity=?;', [str_activity]);
            var rsToday = tx.executeSql('SELECT * FROM logbook WHERE day=? and month=? and year=? and activity=?;', [selectedDateDay.toString(), selectedDateMonth.toString(), selectedDateYear.toString(), str_activity]);

            if (rsToday.rows.length>0){
                str_today = rsToday.rows.item(0).value
            }else{
                str_today = 0
            }
            if (rsYesterday.rows.length>0){
                str_yesterday = rsYesterday.rows.item(0).value
            }else{
                str_yesterday = 0
            }
            if (rsMax.rows.length>0){
                str_max = rsMax.rows.item(0).max

            }else{
                str_max = 0
            }
            //console.log("name" + str_activity +", max" + str_max + ", today" + str_today + ", yesterday" + str_yesterday)
            dataViewDaysModel.push({"name": str_activity, "max":str_max, "today":str_today, "yesterday":str_yesterday})

        }
    });

    return dataViewDaysModel
}
function getDataViewWeekModel(){

    var str_activity = ""
    var str_maxWeek = 0
    var str_thisWeek = 0
    var str_yesterWeek = 0

    dataViewWeeksModel = [];
    openDB()
    var res = ""

    if (selectedDateYear == "") selectedDateYear = today.getFullYear()
    if (selectedDateWeek == "") selectedDateWeek = getWeekNumber(today)

    var yesterYear = selectedDateYear
    var yesterWeek = selectedDateWeek - 1

    var i = 31
    if (yesterWeek === 0){
        while (yesterWeek < 8){
            yesterYear = selectedDateYear - 1
            yesterWeek = getWeekNumber(new Date("12/" + i + "/" + yesterYear))
            i--
        }
    }
    //console.log(yesterWeek)
    //console.log(yesterYear)

    db.transaction(function(tx) {
        var rsActivitites = tx.executeSql('SELECT * FROM activities');
        for(x=0;x<rsActivitites.rows.length;x++){
            str_activity = rsActivitites.rows.item(x).activity

            var rsYesterWeek = tx.executeSql('SELECT SUM(value) as value FROM logbook WHERE week=? and year=? and activity=?;', [ yesterWeek, yesterYear, str_activity]);
            //console.log("SELECT SUM(value) as value FROM logbook WHERE week=" + yesterWeek + " and year=" + yesterYear + " and activity=" + str_activity)
            var rsMaxWeek = tx.executeSql('select max(weektotal) as max from (select activity, sum(value) as weektotal from logbook where activity=? group by year, week);', [str_activity]);
            var rsThisWeek = tx.executeSql('SELECT SUM(value) as value FROM logbook WHERE week=? and year=? and activity=?;', [ selectedDateWeek, selectedDateYear, str_activity]);
            //console.log("SELECT SUM(value) as value FROM logbook WHERE week=" + selectedDateWeek + " and year=" + selectedDateYear + " and activity=" + str_activity)

            if (rsThisWeek.rows.length>0){
                str_thisWeek = rsThisWeek.rows.item(0).value ? rsThisWeek.rows.item(0).value : 0
            }else{
                str_thisWeek = 0
            }
            if (rsYesterWeek.rows.length>0){
                str_yesterWeek = rsYesterWeek.rows.item(0).value ? rsYesterWeek.rows.item(0).value : 0
            }else{
                str_yesterWeek = 0
            }
            if (rsMaxWeek.rows.length>0){
                str_maxWeek = rsMaxWeek.rows.item(0).max ? rsMaxWeek.rows.item(0).max : 0
            }else{
                str_maxWeek = 0
            }

            //console.log("name:" + str_activity + ", maxweek:" + str_maxWeek + ", thisweek:" + str_thisWeek + ", yesterweek:" + str_yesterWeek)
            dataViewWeeksModel.push({"name":str_activity, "maxweek":str_maxWeek, "thisweek":str_thisWeek, "yesterweek":str_yesterWeek})
        }
    });

    return dataViewWeeksModel
}

function getDataViewMonthModel(){

    var str_activity = ""
    var str_maxMonth = ""
    var str_thisMonth = ""
    var str_yesterMonth = ""

    dataViewMonthsModel = [];
    openDB()
    var res = ""

    if (selectedDateYear == "") selectedDateYear = today.getFullYear()
    if (selectedDateMonth == "") selectedDateMonth = parseInt(today.getMonth() + 1)

    var yesterYear = selectedDateYear
    var yesterMonth = selectedDateMonth - 1

    if (selectedDateMonth == "1") {
        yesterMonth = 12
        yesterYear -= 1
    }

    //correct the month for the array
    selectedDateMonth = months[parseInt(selectedDateMonth - 1)]
    yesterMonth = months[parseInt(yesterMonth - 1)]

    db.transaction(function(tx) {
        var rsActivitites = tx.executeSql('SELECT * FROM activities');
        for(x=0;x<rsActivitites.rows.length;x++){
            str_activity = rsActivitites.rows.item(x).activity

            var rsYesterMonth = tx.executeSql('SELECT SUM(value) as value FROM logbook WHERE month=? and year=? and activity=?;', [ yesterMonth, yesterYear, str_activity]);
            var rsMaxMonth = tx.executeSql('select max(monthtotal) as max from (select activity, sum(value) as monthtotal from logbook where activity=? group by year, month);', [str_activity]);
            var rsThisMonth = tx.executeSql('SELECT SUM(value) as value FROM logbook WHERE month=? and year=? and activity=?;', [ selectedDateMonth, selectedDateYear, str_activity]);


            if (rsThisMonth.rows.length>0){
                str_thisMonth = rsThisMonth.rows.item(0).value ? rsThisMonth.rows.item(0).value : 0
            }else{
                str_thisMonth = 0
            }
            if (rsYesterMonth.rows.length>0){
                str_yesterMonth = rsYesterMonth.rows.item(0).value ? rsYesterMonth.rows.item(0).value : 0
            }else{
                str_yesterMonth = 0
            }
            if (rsMaxMonth.rows.length>0){
                str_maxMonth = rsMaxMonth.rows.item(0).max ? rsMaxMonth.rows.item(0).max : 0
            }else{
                str_maxMonth = 0
            }
            //console.log("name:" + str_activity + ", maxmonth:" + str_maxMonth + ", thismonth:" + str_thisMonth + ", yestermonth:" + str_yesterMonth)
            dataViewMonthsModel.push({"name":str_activity, "maxmonth":str_maxMonth, "thismonth":str_thisMonth, "yestermonth":str_yesterMonth})

        }
    });

    return dataViewMonthsModel
}
function getDataViewYearModel(){
    var str_activity = ""
    var str_maxYear = ""
    var str_thisYear = ""
    var str_yesterYear = ""

    dataViewYearsModel = [];
    openDB()
    var res = ""

    if (selectedDateYear == "") selectedDateYear = today.getFullYear()

    var yesterYear = selectedDateYear - 1

    db.transaction(function(tx) {
        var rsActivitites = tx.executeSql('SELECT * FROM activities');
        for(x=0;x<rsActivitites.rows.length;x++){
            str_activity = rsActivitites.rows.item(x).activity

            var rsYesterYear = tx.executeSql('SELECT SUM(value) as value FROM logbook WHERE year=? and activity=?;', [yesterYear, str_activity]);
            var rsMaxYear = tx.executeSql('select max(yeartotal) as max from (select activity, sum(value) as yeartotal from logbook where activity=? group by year);', [str_activity]);
            var rsThisYear = tx.executeSql('SELECT SUM(value) as value FROM logbook WHERE year=? and activity=?;', [selectedDateYear, str_activity]);

            if (rsThisYear.rows.length>0){
                str_thisYear = rsThisYear.rows.item(0).value ? rsThisYear.rows.item(0).value : 0
            }else{
                str_thisYear = 0
            }
            if (rsYesterYear.rows.length>0){
                str_yesterYear = rsYesterYear.rows.item(0).value ? rsYesterYear.rows.item(0).value : 0
            }else{
                str_yesterYear = 0
            }
            if (rsMaxYear.rows.length>0){
                str_maxYear = rsMaxYear.rows.item(0).max ? rsMaxYear.rows.item(0).max : 0
            }else{
                str_maxYear = 0
            }
            //console.log("name:" + str_activity + ", maxyear:" + str_maxYear + ", thisyear:" + str_thisYear + ", yesteryear:" + str_yesterYear)
            dataViewYearsModel.push({"name":str_activity, "maxyear":str_maxYear, "thisyear":str_thisYear, "yesteryear":str_yesterYear})
        }
    });

    return dataViewYearsModel
}

function saveActivity(value, unit) {
    openDB();
    //console.log("attempting to create value:" + value)
    if(value === "") {
        //console.log("can't insert empty activity string")
        return;
    }
    if(unit === "") {
        //console.log("can't insert empty unit string")
        return;
    }
    db.transaction( function(tx){
        var rs = tx.executeSql('INSERT OR REPLACE INTO activities VALUES(?, ?)', [value, unit]);
        //console.log("inserted id:" + rs.insertId);

    });
}
function deleteActivity(value) {
    openDB();

    db.transaction( function(tx){
        tx.executeSql('Delete from activities where activity=?;', [value]);
        //console.log("deleted:" + value);

    });
}

function saveSetting(key, value) {
    openDB();
    db.transaction( function(tx){
        tx.executeSql('INSERT OR REPLACE INTO settings VALUES(?, ?)', [key, value]);
    });
}

function getSetting(key) {
    openDB();
    //console.log("attempting to get key:" + key)
    var res = "nothing found."
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT mvalue FROM settings WHERE mkey=?;', [key]);
        res = rs.rows.item(0).mvalue;

    });
    //console.log("getSetting:" + key + ":" + res)
    return res;
}

function getToday() {

    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();
    var MMMM = months[mm]
    /*
    if(dd<10) {
        dd='0'+dd
    }
    if(mm<10) {
        mm='0'+mm
    }
   */
    return dd + ' ' + MMMM + ' ' + yyyy;

}

function leapYear(year)
{
    return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
}

function getWeekNumber(d) {
    // Copy date so don't modify original
    d = new Date(+d);
    d.setHours(0,0,0);
    //console.log("getWeekNumber:" + d)
    // Set to nearest Thursday: current date + 4 - current day number
    // Make Sunday's day number 7
    d.setDate(d.getDate() + 4 - (d.getDay()||7));
    // Get first day of year
    var yearStart = new Date(d.getFullYear(),0,1);
    // Calculate full weeks to nearest Thursday
    var weekNo = Math.ceil(( ( (d - yearStart) / 86400000) + 1)/7)
    // Return array of year and week number
    //return [d.getFullYear(), weekNo];
    return weekNo.toString()
}

function getMonthNumber(monthName){

    var monthNo = 0

    for (x=0;x<months.length;x++){
        if(monthName === months[x]){
            monthNo = x + 1 //array 0 based
        }
    }
    //console.log("month returned:" + monthNo)
    return monthNo
}
function getSliderHundred(munique){

    openDB()
    var res = 0
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM logbook WHERE mid=?;', [munique]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        }else{
            res = 0
        }
        console.log("res" + res)
        console.log("sldHund_i" + sldHund_i)
    });
    console.log("getSliderHundred db says:" + res)
    if (res > 99){
        var hundred = res.toString()
        hundred = hundred.substring(0, 1);
        sldHund_i = parseInt(hundred * 100)
        console.log("getSliderHundred returning: " + sldHund_i)
        return sldHund_i
    }else{       
        sldHund_i = 0
        console.log("getSliderHundred returning: " + sldHund_i)
        return sldHund_i
    }
}
function getSliderTen(munique){

    openDB()
    var res = 0
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM logbook WHERE mid=?;', [munique]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        }else{
            res = 0
        }
    });
    var ten = 0

    //console.log("getSliderTen db says:" + res)
    if (res > 99){
        ten = res.toString()
        ten = ten.substring(1, 2);
        //console.log("returning:" + parseInt(ten * 10))
        return parseInt(ten * 10)
    }else if (res > 9){
        ten = res.toString()
        ten = ten.substring(0, 1);
        //console.log("returning:" + parseInt(ten * 10))
        return parseInt(ten * 10)
    }else{
        //console.log("returning: 0")
        return 0
    }
}
function getSliderOne(munique){
    //console.log("munique" + munique)
    openDB()
    var res = 0
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM logbook WHERE mid=?;', [munique]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        }else{
            res = 0
        }
    });
    var one = 0
    //console.log("getsldone debugging:" + res)
    //console.log("getSliderOne db says:" + res)
    if (res > 99){
        one = res.toString()
        one = one.substring(2, 3);
        //console.log("returning:" + parseInt(one))
        return parseInt(one)
    }else if (res > 9){
        one = res.toString()
        one = one.substring(1, 2);
        //console.log("returning:" + parseInt(one))
        return parseInt(one)
    }else if (res > 0){
        one = res.toString()
        one = one.substring(0, 1);
        //console.log("returning:" + parseInt(one))
        return parseInt(one)
    }else{
        //console.log("returning: 0")
        return 0
    }
}
function getSliderDecimal(munique){

    openDB()
    var res = 0
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM logbook WHERE mid=?;', [munique]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        }else{
            res = 0
        }
    });
    var deci = 0
    var decicheck = Math.floor(res)

    //console.log("decimal debugging:" + res)

    if (res - decicheck == 0){
        //console.log("dezicheck 0")
        return 0
    }else{
        //console.log("remainder:" + res + "-" + decicheck + "=" + (res -decicheck).toFixed(1) * 10)
        //console.log("remainder:" + res + "-" + decicheck + "=" + parseFloat((res -decicheck)).toFixed(1))

        return (res -decicheck).toFixed(1) * 10
    }
}

function saveLogBookEntry(day, week, month, year, activity, value) {
    openDB();
    var munique = (day + month + year).toString()
    munique += activity.toString().toUpperCase()

    //delete the entry first because replace does not work on non-unique columns, and text cant be unique
    db.transaction( function(tx){
        tx.executeSql('Delete from logbook where mid=?;', [munique]);
    });

    db.transaction( function(tx){
        var rs = tx.executeSql('INSERT OR REPLACE INTO logbook VALUES(?, ?, ?, ?, ?, ?, ?)', [munique.toString(), day, week, month, year, activity, value]);
        //console.log("inserted log entry:" + rs.insertId);

    });

    db.transaction(function(tx) {

        var rs = tx.executeSql('SELECT * FROM logbook;')

        for(var i = 0; i < rs.rows.length; i++) {
            //activities.push({"activityName": "" + rs.rows.item(i).activity , "activityUnit": "" + rs.rows.item(i).measurement + ""})
            //console.log("items in db:" + rs.rows.item(i).mid + "-" + rs.rows.item(i).day + "-" + rs.rows.item(i).week + "-" + rs.rows.item(i).month + "-" + rs.rows.item(i).year + "-" + rs.rows.item(i).activity + "-" + rs.rows.item(i).value)
        }
    });
}
