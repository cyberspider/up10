var db;
var today = new Date();
var daysModel = [];
var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
var slider1 = 0
function openDB() {

    if(db !== undefined) return;
    //console.log("opening db")
    // db = LocalStorage.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
    db = LocalStorage.openDatabaseSync("Up10v1", "0.1", "Simple Up10 app", 100000);

}

function setupDB(){
    try {
        db.transaction(function(tx){
            //Create tables first
            //tx.executeSql('DROP TABLE activities');
            //tx.executeSql('DROP TABLE settings');
            //tx.executeSql('DROP TABLE logbook');
            tx.executeSql('CREATE TABLE IF NOT EXISTS activities(activity varchar(50) UNIQUE, measurement TEXT)');
            //measurement can be D - Distance, T - Time, R - Reps
            var table  = tx.executeSql("SELECT * FROM activities");
            // Seed the table with default values
            if (table.rows.length === 0) {
                tx.executeSql('INSERT INTO activities VALUES(?, ?)', ["Swimming", "laps"]);
                tx.executeSql('INSERT INTO activities VALUES(?, ?)', ["Running", "km"]);
                tx.executeSql('INSERT INTO activities VALUES(?, ?)', ["Cycling", "km"]);

                console.log('Activities table added.');
            };

            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(mkey TEXT, mvalue TEXT)');
            table = tx.executeSql('SELECT * from settings');
            if (table.rows.length === 0) {
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["Use Metric System", "1"]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["TimePeriod", "2"]);
                console.log('Settings table added');
            }

            tx.executeSql('CREATE TABLE IF NOT EXISTS logbook(mid TEXT, day NUMERIC, month NUMERIC, year NUMERIC, activity TEXT, value NUMERIC)');

            doInitialSettings()
        });
    } catch (err) {
        console.log("Error creating table in database: " + err);
    };
}

function doInitialSettings(){
    //1.First Run - set start date if not found
    //do this actually
    var start = new Date();
    start.setDate(1);
    start.setMonth(start.getMonth()-1);
    console.log(start)
    var end = new Date();

    while(start < end){
        daysModel.push({"day": "" + start.getDate()  , "month": "" + months[start.getMonth()], "year": "" + start.getFullYear()})
        //increment while loop
        var newDate = start.setDate(start.getDate() + 1);
        start = new Date(newDate);
    }
    daysModel.reverse()
    //console.log(JSON.stringify(daysModel))
    //console.log("@@@@@@@@@")

    //2.Fill in gaps between today and start date

    //3.Load models
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

    console.log(JSON.stringify(daysModel))
    console.log("RRRRRR")

    return daysModel;
}

function saveActivity(value, unit) {
    openDB();
    //console.log("attempting to create value:" + value)
    if(value === "") {
        console.log("can't insert empty activity string")
        return;
    }
    if(unit === "") {
        console.log("can't insert empty unit string")
        return;
    }
    db.transaction( function(tx){
        var rs = tx.executeSql('INSERT OR REPLACE INTO activities VALUES(?, ?)', [value, unit]);
        console.log("inserted id:" + rs.insertId);

    });
}
function deleteActivity(value) {
    openDB();

    db.transaction( function(tx){
        tx.executeSql('Delete from activities where activity=?;', [value]);
        console.log("deleted:" + value);

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
        res = rs.rows.item(0).value;

    });

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

function getSliderHundred(munique){
    console.log("munique" + munique)
    openDB()
    var res = "nothing found."
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM logbook WHERE mid=?;', [munique]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        }else{
            res = 0
        }
    });
    console.log("getSliderHundred db says:" + res)
    if (res > 99){
        var hundred = res.toString()
        hundred = hundred.substring(0, 1);
        console.log("returning:" + parseInt(hundred * 100))
        return parseInt(hundred * 100)
    }else{
        console.log("returning: 0")
        return 0
    }
}
function getSliderTen(munique){
    console.log("munique" + munique)
    openDB()
    var res = "nothing found."
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM logbook WHERE mid=?;', [munique]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        }else{
            res = 0
        }
    });
    var ten = 0

    console.log("getSliderTen db says:" + res)
    if (res > 99){
        ten = res.toString()
        ten = ten.substring(1, 2);
        console.log("returning:" + parseInt(ten * 10))
        return parseInt(ten * 10)
    }else if (res > 9){
        ten = res.toString()
        ten = ten.substring(0, 1);
        console.log("returning:" + parseInt(ten * 10))
        return parseInt(ten * 10)
    }else{
        console.log("returning: 0")
        return 0
    }
}
function getSliderOne(munique){
    console.log("munique" + munique)
    openDB()
    var res = "nothing found."
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM logbook WHERE mid=?;', [munique]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        }else{
            res = 0
        }
    });
    var one = 0

    console.log("getSliderOne db says:" + res)
    if (res > 99){
        one = res.toString()
        one = one.substring(2, 3);
        console.log("returning:" + parseInt(one))
        return parseInt(one)
    }else if (res > 9){
        one = res.toString()
        one = one.substring(1, 2);
        console.log("returning:" + parseInt(one))
        return parseInt(one)
    }else if (res > 0){
        one = res.toString()
        one = one.substring(0, 1);
        console.log("returning:" + parseInt(one))
        return parseInt(one)
    }else{
        console.log("returning: 0")
        return 0
    }
}
function getSliderDecimal(munique){
    console.log("munique" + munique)
    openDB()
    var res = "nothing found."
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

    if (res - decicheck == 0){
        console.log("dezicheck 0")
        return 0
    }else{
        console.log("remainder:" + res + "-" + decicheck + "=" + (res -decicheck).toFixed(1) * 10)
        console.log("remainder:" + res + "-" + decicheck + "=" + parseFloat((res -decicheck)).toFixed(1))

        return (res -decicheck).toFixed(1) * 10
    }
}

function saveLogBookEntry(day, month, year, activity, value) {
    openDB();
    var munique = (day + month + year).toString()
    munique += activity.toString().toUpperCase()
    console.log("munique:" + munique)
    //tx.executeSql('CREATE TABLE IF NOT EXISTS logbook(id TEXT UNIQUE, day NUMERIC, month NUMERIC, year NUMERIC, activity TEXT, value NUMERIC)');

    //delete the entry first because replace does not work on non-unique columns, and text cant be unique
    db.transaction( function(tx){
        tx.executeSql('Delete from logbook where mid=?;', [munique]);
    });

    db.transaction( function(tx){
        var rs = tx.executeSql('INSERT OR REPLACE INTO logbook VALUES(?, ?, ?, ?, ?, ?)', [munique.toString(), day, month, year, activity, value]);
        console.log("inserted log entry:" + rs.insertId);

    });

    db.transaction(function(tx) {

        var rs = tx.executeSql('SELECT * FROM logbook;')

        for(var i = 0; i < rs.rows.length; i++) {
            //activities.push({"activityName": "" + rs.rows.item(i).activity , "activityUnit": "" + rs.rows.item(i).measurement + ""})
            console.log("items in db:" + rs.rows.item(i).mid + "-" + rs.rows.item(i).day + "-" + rs.rows.item(i).month + "-" + rs.rows.item(i).year + "-" + rs.rows.item(i).activity + "-" + rs.rows.item(i).value)
        }
    });
}
