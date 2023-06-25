var express = require('express');
const multer = require("multer");
var router = express.Router();
var path = require('path');

var nodemailer = require('nodemailer');

//Assure only images are uploaded
const checkFileType = function (file, cb) {
  //Allowed file extensions
  const fileTypes = /jpeg|jpg|png|gif|svg/;

  //check extension names
  const extName = fileTypes.test(path.extname(file.originalname).toLowerCase());

  const mimeType = fileTypes.test(file.mimetype);

  if (mimeType && extName) {
    return cb(null, true);
  } else {
    cb("Error: File not an image");
  }
};

//setting storage engine
const storageEngine = multer.diskStorage ({
  destination: "/workspaces/23S1_WDC_PG001_enjoyable-turns-super/public/images",
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}--${file.originalname}`);
  }
});

//initializing multer
const upload = multer({
  storage: storageEngine,
  limits: { filesize: 1000000 },
  fileFilter: (req, file, cb) => {
    checkFileType(file, cb);
  }
});

const transporter = nodemailer.createTransport({
  host: 'smtp.ethereal.email',
  port: 587,
  auth: {
      user: 'ike88@ethereal.email',
      pass: 'enDbPF1FrRWbXFAFmT'
  },
  tls: {
    rejectUnauthorized: false
  }
});

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

module.exports = router;

router.get("/info", function(req, res, next) {
  let response = {
    user_id: "",
    is_admin: false
  };
  if ('user_id' in req.session) {
    response = {
      user_id: req.session.user_id,
      is_admin: req.session.user.system_administrator
    };
  }

  res.json(response);
});

router.get("/info/club-manager", function(req, res, next) {
  if ('user_id' in req.session) {
    if (req.query.club_id !== "" && req.query.club_id !== -1) {
      req.pool.getConnection(function(cerr, connection) {
        if (cerr) {
          res.sendStatus(500);
          return;
        }

        const query = `SELECT Club_members.* FROM Club_members
        WHERE Club_members.user_id = ? AND Club_members.club_id = ?;`;

        connection.query(query, [req.session.user_id, req.query.club_id], function(qerr, rows, fields) {

          connection.release();

          if (qerr) {
            res.sendStatus(500);
            return;
          }
          if (rows.length === 1 && rows[0].club_manager === 1) {
            res.send("Both");
          } else if(rows.length === 1) {
            res.send("Member");
          } else {
            res.send("Neither");
          }
        });
      });
    }
  } else {
    res.send("Public");
  }
});

/* The below are for users that have an account, thus we will block access if they are not a user with an account */
router.use('/', function(req, res, next) {
  if (!('user_id' in req.session)){
    res.sendStatus(403);
  } else {
    next();
  }
});

router.post("/profile/upload", upload.single("image"), (req, res, next) => {
  if (req.file) {
    // Save the image path or filename in the SQL database
    let imagePath = req.file.path.replace('/workspaces/23S1_WDC_PG001_enjoyable-turns-super/public', '');

    req.pool.getConnection(function(cerr, connection) {
      if (cerr) {
        res.sendStatus(500);
        return;
      }

      // Update the user's profile in the database with the image path
      let query = 'UPDATE Users SET profile_pic_path = ? WHERE id = ?';

      connection.query(query, [imagePath, req.session.user_id], function(qerr, result) {
        connection.release();

        if (qerr) {
          res.sendStatus(500);
          return;
        }

        res.sendStatus(200);
      });
    });
  } else {
    res.status(400).send("Please upload a valid image");
  }
});


router.get("/profile", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    let query = `SELECT first_name, last_name, username, email, phone_number, profile_pic_path FROM Users WHERE id = ?`;

    connection.query(query, [req.session.user_id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      let user_data = rows;

      res.json(user_data);
    });
  });
});


router.post("/profile/edit", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    let query = `UPDATE Users SET first_name = ?, last_name = ?, username = ?, email = ?, phone_number = ? WHERE id = ?`

    connection.query(query, [req.body.first_name, req.body.last_name, req.body.username,req.body.email, req.body.phone_number, req.session.user_id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }
      res.send();
    });
  });
});

router.post("/clubs/join", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    let query = "";

    if (req.body.join) {
      query = `INSERT INTO Club_members (club_id, user_id, date_joined) VALUES (?, ?, NOW())`;
    } else {
      query = `DELETE FROM Club_members WHERE user_id = ${req.session.user_id} AND club_id = ?`;
    }

    connection.query(query, [req.body.club_id, req.session.user_id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }
      res.send();
    });
  });
});

router.post("/posts/rsvp", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    let query = `INSERT INTO Rsvps (post_id, user_id, rsvp, date_responded) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE rsvp = ?, date_responded = ?`;

    connection.query(query, [req.body.post_id, req.session.user_id, req.body.rsvp, req.body.date_responded, req.body.rsvp, req.body.date_responded], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      res.send();
    });
  });
});

router.post("/posts/mark-as-read", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    let query = `INSERT INTO Posts_viewed (post_id, user_id) VALUES (?, ?)`;

    connection.query(query, [req.body.post_id, req.session.user_id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }
      res.send();
    });
  });
});

router.get("/notifications", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    const query = `SELECT Clubs.id, Clubs.club_name, Notification.notification_setting FROM Clubs
    INNER JOIN Club_members ON Club_members.club_id = Clubs.id
    LEFT JOIN Notification ON Notification.club_id = Clubs.id AND Notification.user_id = Club_members.user_id WHERE Club_members.user_id = ?;`;

    connection.query(query, [req.session.user_id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      res.send(rows);
    });
  });
});

router.post("/notifications/update", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    let query = "";

    if (Number(req.query.notification_setting) === 0) {
      query = `DELETE FROM Notification WHERE user_id = ${req.session.user_id} AND club_id = ${req.query.club_id};`;
    } else if (Number(req.query.club_id) !== -1) {
      query = `INSERT INTO Notification (user_id, club_id, notification_setting) VALUES(${req.session.user_id}, ${req.query.club_id}, ${req.query.notification_setting}) ON DUPLICATE KEY UPDATE notification_setting = ${req.query.notification_setting}`;
    } else {
      query = `DELETE FROM Notification WHERE user_id = ${req.session.user_id};`;
    }

    connection.query(query, function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      res.send();
    });
  });
});

/* Will have a block if requestor is not a club admin */

const webPush = require('web-push');

router.post("/notifications/send", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    const query = "SELECT user_id FROM Club_members WHERE user_id = ? AND club_id = ? AND club_manager = 1;";

    connection.query(query, [req.session.user_id, req.body.club_id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      if (!rows) {
        res.sendStatus(403);
      }
    });
  });
  let recipients = [];
  let query = ``;
  if (req.body.tag === 'post') {
    query = `SELECT Users.email, Users.push_endpoint, Users.push_p256dh, Users.auth FROM Users
    INNER JOIN Club_members ON Club_members.user_id = Users.id
    INNER JOIN Notification ON Notification.user_id = Club_members.user_id AND Club_members.club_id = Notification.club_id
    INNER JOIN Clubs ON Clubs.id = Club_members.club_id
    WHERE Club_members.club_id = ? AND Notification.notification_setting IN (1, 3);`;
  } else {
    query = `SELECT Users.email, Users.push_endpoint, Users.push_p256dh, Users.auth FROM Users
    INNER JOIN Club_members ON Club_members.user_id = Users.id
    INNER JOIN Notification ON Notification.user_id = Club_members.user_id AND Club_members.club_id = Notification.club_id
    INNER JOIN Clubs ON Clubs.id = Club_members.club_id
    WHERE Club_members.club_id = ? AND Notification.notification_setting IN (2, 3);`;
  }

  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    connection.query(query, [req.body.club_id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      recipients = rows.map((a) => a.email);
      // Email Notification Portion
      for (let i = 0; i < recipients.length; i++) {
        if (req.body.tag === 'post') {
          let mailContent = {
            from: 'ike88@ethereal.email',
            to: recipients[i],
            subject: req.body.title,
            html: req.body.content
          };
          transporter.sendMail(mailContent, function (err, info) {
            if(err) {
              console.log(err);
            }
          });
        } else {
          let mailContent = {
            from: 'ike88@ethereal.email',
            to: recipients[i],
            subject: req.body.title,
            html: req.body.content
          };
          transporter.sendMail(mailContent, function (err, info) {
          if(err) {
            console.log(err);
          }
          });
        }
      }
      // Push Notification Portion
      let payload = {};

      if (req.body.tag === 'post') {
        payload = {
          title: "New Post on Cluber",
          main_content: req.body.push_content
        };
      } else {
        payload = {
          title: "New Event on Cluber",
          main_content: req.body.push_content
        };
      }

      let push_recipients = rows.map((a) => ({
        endpoint: a.push_endpoint,
        expirationTime: null,
        keys: {
          p256dh: a.push_p256dh,
          auth: a.auth
        }
      }));

      for (let i = 0; i < recipients.length; i++) {
        const recipient = push_recipients[i];
        if (recipient.endpoint) {
          webPush.sendNotification(push_recipients[i], JSON.stringify(payload)).catch((err) => console.error(err));
        }
      }
    });
  });
  res.send();
});

router.post("/posts/create", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    const query = "SELECT user_id FROM Club_members WHERE user_id = ? AND club_id = ? AND club_manager = 1;";

    connection.query(query, [req.session.user_id, req.body.clubId], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      if (!rows) {
        res.sendStatus(403);
      }
    });
  });

  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    let query = `INSERT INTO Posts (title, content, event_date_time, event_location, tag, event_type, club_id, creation_date_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;

    connection.query(query, [req.body.title, req.body.content, req.body.eventDate, req.body.location, req.body.tag, req.body.type, req.body.clubId, req.body.creation_date_time], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }
      res.send();
    });
  });
});

router.get("/posts/rsvp-users", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    const query = `SELECT user_id FROM Club_members
    INNER JOIN Clubs ON
    Club_members.club_id = Clubs.id
    INNER JOIN Posts ON
    Clubs.id = Posts.club_id WHERE user_id = ? AND Posts.id = ? AND club_manager = 1;`;

    connection.query(query, [req.session.user_id, req.query.id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      if (!rows) {
        res.sendStatus(403);
      }
    });
  });

  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    const query = `SELECT Users.username, Rsvps.date_responded FROM Rsvps
    INNER JOIN Users ON
    Users.id = Rsvps.user_id
    WHERE post_id = ? AND rsvp = 2;`;

    connection.query(query, [req.query.id], function(qerr, rows, fields) {
      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      let users = rows;
      res.json(users);
    });
  });
});

router.get("/clubs/members", function(req, res, next) {
  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    const query = "SELECT user_id FROM Club_members WHERE user_id = ? AND club_id = ? AND club_manager = 1;";

    connection.query(query, [req.session.user_id, req.query.id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      if (!rows) {
        res.sendStatus(403);
      }
    });
  });

  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    const query = `SELECT Users.username, Club_members.date_joined FROM Club_members
    INNER JOIN Users ON
    Users.id = Club_members.user_id
    WHERE club_id = ?;`;

    connection.query(query, [req.query.id], function(qerr, rows, fields) {
      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }

      let users = rows;
      res.json(users);
    });
  });
});

/* Push Notification setup */

const vapidKeys = {
  publicKey: 'BJDu8opIvUamtiZsKy5XZka2YxuOBNWxd6nKyYt2Cy1GQAl00ts9EdMJoxt9POBxyy0iEyZXmb-uvjaHUeey0XI',
  privateKey: 'fNPErbeqJ2_5XNfYmE9_UWBCj2GWB1KaO5f-MUTNITA'
};

webPush.setVapidDetails("mailto:test@test.com", vapidKeys.publicKey, vapidKeys.privateKey);

router.post("/subscribe", function(req, res, next) {
  const subscription = req.body;

  req.pool.getConnection(function(cerr, connection) {
    if (cerr) {
      res.sendStatus(500);
      return;
    }

    let query = `UPDATE Users SET push_endpoint = ?, push_p256dh = ?, auth = ? WHERE id = ?`;

    connection.query(query, [subscription.endpoint, subscription.keys.p256dh, subscription.keys.auth, req.session.user_id], function(qerr, rows, fields) {

      connection.release();

      if (qerr) {
        res.sendStatus(500);
        return;
      }
      res.sendStatus(201);
    });
  });
});
