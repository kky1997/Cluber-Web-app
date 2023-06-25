----------------------------------------------------

Our web application utilises both vue.js and express.js. In order to run the web application:

1. ensure node.js is installed

2. $ npm install (should install all modules required for the application to run specified in the package-lock.json)

3. ensure MySQL is installed and set up

4. $ mysql < database/backup.sql (We are assuming you are in the parent directory)

5. $ service mysql start (start up the MySQL database)

6. $ npm start (start up the express server)

The web application should now be live on http://localhost:8080

---------------------------------------------------
The following user is a system administrator. They can be used to test all functionaility.

Username: queenofhearts
Password: Rgb78@#9kmngt

All users in the system can be used to test. Another user that is a club manager is:

Username:lady_death
Password: Rgb78@#9kmngt

All users currently in the system have the same password for easy testing. We would expect as for an actual site this isn't the case.

---------------------------------------------------

notification are set up to use Ethereal.
Login details for Ethereal mail

user: ike88@ethereal.email

pass: enDbPF1FrRWbXFAFmT

---------------------------------------------------

The site is optimised for mobile as well.

Please note if you want push notifications you will need to unregister your service worker to get the working. We need a fresh one assigned as we assume someone using your device is only one user.

---------------------------------------------------

You can use the sql query file to create the database and run a few basic queries to populate database

Make sure you drop the existing cluber database beforehand

$ mysql < database/queries.sql (We are assuming you are in the parent directory)

---------------------------------------------------

You can use the database'queries.sql file to test our database implementation

mysql < database/queries.sql (We are assuming you are in the parent directory)

This will load dummy data in and that file is easier to read than the backup