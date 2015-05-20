var db;
var today = new Date();
var daysModel = [];
var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

function openDB() {

    if(db !== undefined) return;
    //console.log("opening db")
    // db = LocalStorage.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
    db = LocalStorage.openDatabaseSync("Up10v1", "0.1", "Simple Up10 app", 100000);

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

                console.log('Activities table added');
            };

            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(mkey TEXT, mvalue TEXT)');
            table = tx.executeSql('SELECT * from settings');
            if (table.rows.length === 0) {
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["Use Metric System", "1"]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["TimePeriod", "2"]);
                console.log('Settings table added');
            }

            tx.executeSql('CREATE TABLE IF NOT EXISTS logbook(id NUMERIC UNIQUE, day NUMERIC, month NUMERIC, year NUMERIC, activity TEXT, value NUMERIC)');

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

                   console.log(JSON.stringify(daysModel))
                   console.log("@@@@@@@@@")
                }

            //2.Fill in gaps between today and start date

            //3.Load models
        });
    } catch (err) {
        console.log("Error creating table in database: " + err);
    };
}

function getActivityModel(){

    var activities = []
    openDB();
    //console.log("attempting to get model:")
    db.transaction(function(tx) {
        //      tx.executeSql('Delete from activities;')
        var rs = tx.executeSql('SELECT activity, measurement FROM activities;')

        for(var i = 0; i < rs.rows.length; i++) {
            activities.push({"activityName": "" + rs.rows.item(i).activity , "activityUnit": "" + rs.rows.item(i).measurement + ""})
        }
    });

    return activities;
}

function getDaysModel(){
    console.log(JSON.stringify(daysModel))
    console.log("RRRRRR")
    console.log(daysModel.length)
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
