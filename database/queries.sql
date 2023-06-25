CREATE DATABASE cluber;

USE cluber;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE Users (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    username VARCHAR(255) UNIQUE,
    email VARCHAR(255) UNIQUE,
    passwords VARCHAR(255),
    phone_number VARCHAR(255),
    system_administrator INT,
    profile_pic_path VARCHAR(255),
    push_endpoint VARCHAR(500) UNIQUE,
    push_p256dh VARCHAR(500) UNIQUE,
    auth VARCHAR(500) UNIQUE,
    PRIMARY KEY(id)
);

/*
    use a trigger stored procedure to execute everytime an INSERT occurs
    before any INSERT on Users table set a max_id variable to the current max id in the table
    this is so that the AUTO_INCREMENT keyword will increment from the current max id in the table
    and not the previous max id (even if it was deleted).
*/
DELIMITER //
CREATE TRIGGER SetAutoIncrement
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    SET max_id = (SELECT COALESCE(MAX(id), 0) FROM Users);
    SET NEW.id = max_id + 1;
END //
DELIMITER ;

CREATE TABLE Clubs (
    id INT AUTO_INCREMENT,
    club_name VARCHAR(255),
    club_description TEXT,
    club_color VARCHAR(255),
    club_tag VARCHAR(20),
    PRIMARY KEY(id)
);

CREATE TABLE Club_members (
    club_id INT,
    user_id INT,
    club_manager INT,
    date_joined VARCHAR(255),
    PRIMARY KEY(club_id, user_id),
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (club_id) REFERENCES Clubs(id) ON DELETE CASCADE
);

CREATE TABLE Posts (
    id INT AUTO_INCREMENT,
    title VARCHAR(255),
    content TEXT,
    creation_date_time VARCHAR(255),
    event_date_time VARCHAR(255),
    event_location VARCHAR(255),
    tag VARCHAR(255),
    event_type VARCHAR(255),
    club_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY (club_id) REFERENCES Clubs(id) ON DELETE CASCADE
);

CREATE TABLE Posts_viewed (
    post_id INT,
    user_id INT,
    PRIMARY KEY (post_id, user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Notification (
    club_id INT,
    user_id INT,
    notification_setting INT,
    PRIMARY KEY (club_id, user_id),
    FOREIGN KEY (club_id) REFERENCES Clubs(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

CREATE TABLE Rsvps (
    post_id INT,
    user_id INT,
    rsvp INT,
    date_responded VARCHAR(255),
    PRIMARY KEY (post_id, user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS = 1;

USE cluber;

INSERT INTO Users (
    first_name,
    last_name,
    username,
    email,
    passwords,
    phone_number,
    system_administrator
) VALUES (
    "Ed",
    "Sellars",
    "edsell",
    "edsell@test.com",
    "$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY",
    "1234",
    0
);

INSERT INTO Users (
    first_name,
    last_name,
    username,
    email,
    passwords,
    phone_number,
    system_administrator
) VALUES (
    "Kai",
    "Koo",
    "Teetharecool",
    "kaikoo@test.com",
    "$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY",
    "1234",
    0
);

INSERT INTO Users (
    first_name,
    last_name,
    username,
    email,
    passwords,
    phone_number,
    system_administrator
) VALUES (
    "Blake",
    "Hammond",
    "Blake",
    "blake@test.com",
    "$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY",
    "1234",
    0
);

INSERT INTO Users (
    first_name,
    last_name,
    username,
    email,
    passwords,
    phone_number,
    system_administrator
) VALUES (
    "Petra",
    "Curdova",
    "Curdice",
    "petra@test.com",
    "$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY",
    "1234",
    1
);

INSERT INTO Clubs (
    club_name ,
    club_description,
    club_color,
    club_tag
) Values (
    "Programming Enthusiasts",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "#6CD4FF",
    "technology"
);

INSERT INTO Clubs (
    club_name ,
    club_description,
    club_color,
    club_tag
) Values (
    "Movie Night University Club",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "#251351",
    "entertainment"
);

INSERT INTO Clubs (
    club_name ,
    club_description,
    club_color,
    club_tag
) Values (
    "Mechanical Keyboard Society",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "#E6AA68",
    "technology"
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    tag,
    club_id
) Values (
    "Update 1",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    NOW(),
    "post",
    1
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    tag,
    club_id
) Values (
    "Update 1",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    NOW(),
    "post",
    2
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    tag,
    club_id
) Values (
    "Update 1",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "post",
    3
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    tag,
    club_id
) Values (
    "Update 2",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "post",
    1
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    tag,
    club_id
) Values (
    "Update 2",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "post",
    2
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    tag,
    club_id
) Values (
    "Update 2",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "post",
    3
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    event_date_time,
    event_location,
    tag,
    event_type,
    club_id
) Values (
    "Sports Day",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "Outside",
    "event",
    "public",
    1
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    event_date_time,
    event_location,
    tag,
    event_type,
    club_id
) Values (
    "Movie Night",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "Thu May 28 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "Cinema",
    "event",
    "private",
    2
);

INSERT INTO Posts (
    title,
    content,
    creation_date_time,
    event_date_time,
    event_location,
    tag,
    event_type,
    club_id
) Values (
    "Pub Night",
    "Lorem ipsum dolor sit amet consectetur adipisicing elit. Harum officiis sint, doloremque fugiat quia consequatur rem voluptatem aspernatur consectetur molestiae accusantium itaque explicabo, commodi dolor corporis sunt placeat voluptates. Corporis? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.Lorem ipsum dolor, sit amet consectetur adipisicing elit. Mollitia facere optio nulla consectetur iste recusandae quasi nisi, sit amet repellendus molestiae quis ut eos soluta hic ipsum ducimus, veritatis quos.",
    "Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)",
    "2024-05-24T09:31:15.168Z",
    "Inside",
    "event",
    "public",
    3
);

INSERT INTO Posts_viewed (
    post_id,
    user_id
) Values (
    5,
    1
);

INSERT INTO Rsvps (
    post_id,
    user_id,
    rsvp,
    date_responded
) Values (
    9,
    1,
    2,
    "2023-05-24T09:31:15.168Z"
);

INSERT INTO Club_members (
    club_id,
    user_id,
    club_manager,
    date_joined
) VALUES (
    1,
    1,
    1,
    'Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)'
);

INSERT INTO Club_members (
    club_id,
    user_id,
    club_manager,
    date_joined
) VALUES (
    2,
    2,
    1,
    'Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)'
);

INSERT INTO Club_members (
    club_id,
    user_id,
    club_manager,
    date_joined
) VALUES (
    2,
    3,
    1,
    'Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)'
);

INSERT INTO Club_members (
    club_id,
    user_id,
    club_manager,
    date_joined
) VALUES (
    3,
    4,
    1,
    'Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)'
);

INSERT INTO Club_members (
    club_id,
    user_id,
    club_manager,
    date_joined
) VALUES (
    3,
    1,
    0,
    'Thu Apr 13 2023 17:39:14 GMT+0930 (Australian Central Standard Time)'
);
