# Cluber-Web-app

Web app called "cluber" which allows Uni students to create/find clubs, as well as access a news feed with events posted by clubs.

The app is optimised for mobile as well.

Uses: Express.js, Node.js, Vue.js, mySQL, as well as css, html, and client-side AJAX.

Full sign-up and sign-in implemented, using both traditional sign-up and sign-in structures as well as Google's sign-in API.

notification are set up to use Ethereal.
Login details for Ethereal mail

    user: ike88@ethereal.email

    pass: enDbPF1FrRWbXFAFmT

The following user is a system administrator. They can be used to test all functionaility.

    Username: queenofhearts
    Password: Rgb78@#9kmngt

All users in the system can be used to test. Another user that is a club manager is:

    Username:lady_death
    Password: Rgb78@#9kmngt

All users currently in the system have the same password for easy testing. We would expect as for an actual site this isn't the case.

Passwords are hashed using Argon2 hashing.

To run on a unix-like system:
    1. install node.js as well as the dependencies (express, mySQL)

    2. use the sql query file to create the database and run a few basic queries to populate database

    $ mysql < database/queries.sql (We are assuming you are in the parent directory)

    3. start mySQL database

    $ service mysql start

    4. start express server

    $ npm start

    5. access web app through http://localhost:8080


