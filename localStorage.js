var db;
var today = new Date();

function openDB() {

    if(db !== undefined) return;
    console.log("opening db")
    // db = LocalStorage.openDatabaseSync(identifier, version, description, estimated_size, callback(db))
    db = LocalStorage.openDatabaseSync("Up10v1", "0.1", "Simple Up10 app", 100000);

    try {
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS activities(activity TEXT UNIQUE, measurement TEXT, usedecimal NUMBER)');
            //measurement can be D - Distance, T - Time, R - Reps
            var table  = tx.executeSql("SELECT * FROM activities");
            // Seed the table with default values
            if (table.rows.length === 0) {
                tx.executeSql('INSERT INTO activities VALUES(?, ?, ?)', ["Swimming", "D", 1]);

                console.log('Activities table added');
            };

            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(key TEXT UNIQUE, value TEXT)');
            if (table.rows.length == 0) {
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["Use Metric System", "1"]);
                tx.executeSql('INSERT INTO settings VALUES(?, ?)', ["TimePeriod", "2"]);
                console.log('Settings table added');
            }

            tx.executeSql('CREATE TABLE IF NOT EXISTS logbook(id NUMBER UNIQUE, day TEXT, month TEXT, year TEXT, activity TEXT, value NUMBER)');

            console.log('Logbook table added');

        });
    } catch (err) {
        console.log("Error creating table in database: " + err);
    };
}

function getActivityModel(){

    var activities = []
    openDB();
    console.log("attempting to get model:")

    db.transaction(function(tx) {
//        tx.executeSql('Delete from activities;')
        var rs = tx.executeSql('SELECT activity FROM activities;')

        for(var i = 0; i < rs.rows.length; i++) {
            activities.push({"activityName": "" + rs.rows.item(i).activity }); //+ "", "icon": "images/logo.png"})
        }
    });

    return activities;
}

function saveActivity(value) {
    openDB();
    console.log("attempting to create value:" + value)
    if(value === "") {
        console.log("can't insert empty string")
        return;
    }
    db.transaction( function(tx){
        var rs = tx.executeSql('INSERT OR REPLACE INTO activities VALUES(?, ?, ?)', [value, "D", 0]);
        console.log("inserted id:" + rs.insertId);

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
        var rs = tx.executeSql('SELECT value FROM settings WHERE key=?;', [key]);
        res = rs.rows.item(0).value;

    });

    return res;
}

function getToday() {

    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();
    var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    var MMMM = months[mm]
    /*
    if(dd<10) {
        dd='0'+dd
    }

    if(mm<10) {
        mm='0'+mm
    }
*/
    today = dd + ' ' + MMMM + ' ' + yyyy;
    return today;
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
