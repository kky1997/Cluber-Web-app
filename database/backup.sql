-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: cluber
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cluber`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cluber` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `cluber`;

--
-- Table structure for table `Club_members`
--

DROP TABLE IF EXISTS `Club_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Club_members` (
  `club_id` int NOT NULL,
  `user_id` int NOT NULL,
  `club_manager` int DEFAULT NULL,
  `date_joined` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`club_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Club_members_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Club_members_ibfk_2` FOREIGN KEY (`club_id`) REFERENCES `Clubs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Club_members`
--

LOCK TABLES `Club_members` WRITE;
/*!40000 ALTER TABLE `Club_members` DISABLE KEYS */;
INSERT INTO `Club_members` VALUES (1,1,1,'2023-6-8 12:41:3'),(1,2,NULL,'2023-06-08 14:14:49'),(1,3,NULL,'2023-06-08 14:15:24'),(1,10,NULL,'2023-06-08 14:17:21'),(1,12,1,'2023-6-8 14:9:19'),(1,13,NULL,'2023-06-08 14:17:43'),(2,1,1,'2023-6-8 12:41:13'),(2,2,NULL,'2023-06-08 14:14:51'),(2,3,NULL,'2023-06-08 14:15:26'),(2,13,NULL,'2023-06-08 14:17:45'),(2,15,1,'2023-6-8 14:9:24'),(3,1,1,'2023-6-8 12:41:18'),(3,2,NULL,'2023-06-08 14:14:53'),(3,3,NULL,'2023-06-08 14:15:32'),(3,4,NULL,'2023-06-08 14:15:53'),(3,9,1,'2023-6-8 14:9:33'),(3,13,NULL,'2023-06-08 14:17:47'),(4,1,1,'2023-6-8 12:41:22'),(4,6,NULL,'2023-06-08 14:16:50'),(4,8,1,'2023-6-8 14:9:39'),(4,13,NULL,'2023-06-08 14:17:49'),(5,1,1,'2023-6-8 12:41:26'),(5,2,NULL,'2023-06-08 14:14:56'),(5,3,NULL,'2023-06-08 14:15:35'),(5,4,NULL,'2023-06-08 14:15:55'),(5,5,NULL,'2023-06-08 14:16:32'),(5,6,1,'2023-6-8 14:9:45'),(6,1,1,'2023-6-8 12:41:30'),(6,5,1,'2023-6-8 14:9:50'),(6,10,NULL,'2023-06-08 14:17:18'),(7,1,1,'2023-6-8 12:41:34'),(7,4,1,'2023-6-8 14:9:56'),(8,1,1,'2023-6-8 12:41:38'),(8,3,NULL,'2023-06-08 14:15:29'),(8,5,NULL,'2023-06-08 14:16:34'),(8,20,1,'2023-6-8 14:10:1');
/*!40000 ALTER TABLE `Club_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Clubs`
--

DROP TABLE IF EXISTS `Clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Clubs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `club_name` varchar(255) DEFAULT NULL,
  `club_description` text,
  `club_color` varchar(255) DEFAULT NULL,
  `club_tag` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Clubs`
--

LOCK TABLES `Clubs` WRITE;
/*!40000 ALTER TABLE `Clubs` DISABLE KEYS */;
INSERT INTO `Clubs` VALUES (1,'Programming Enthusiasts','We are a club that is enthusiastic about programming.\n\nWe hold weekly meetups and a major event twice a year.\n\nIf you love programming join our club!','#43cba2','Technology'),(2,'Law Society','The club for law students. We discuss everything and anything related to the law.\n\nOur team posts weekly updates of what\'s new in law and beyond.\n\nOur networking events run twice semester. Join the club to stay notified of when they are occurring.\n\n','#cd1818','Faculty'),(3,'Sports United','Sports, get your sports here!\n\nDo you love sports? Well you\'ve found the right place. We don\'t discriminate whether you play soccer, basketball or tennis we love you all.\n\nJoin to stay up to date on anything sports on campus. \n\nFree cookie when you join (if you can find me)','#d110ca','Sport'),(4,'Book Club','This page keeps you in the loop with the weekly book club.\n\nWe meet every week to discuss this weeks book. We have several events outside of this that occur randomly.\n\nWe post book reviews at the weeks end.\n\nIf you love reading look no further.','#75b625','Hobby'),(5,'Chef\'s Club','Passionate about food? Want to learn skills that you already should have? Join our club and get regular recipes and food updates.\n\nWe hold a banquet once a year where we put all our hard work into practice.\n\nFollow the club to stay in the loop!','#eeff00','Hobby'),(6,'Nerds R Us','A group of people interested in gaming, comics, movies and anything considered stereo-typically \"nerdy\".\n\nWe hold regular meetups and movie nights so follow our club to stay up to date.','#000000','Hobby'),(7,'Hiking Collective','Calling all hikers! We love to hike and so should you. \n\nWeekly hikes (Saturday/Sunday) are organised to provide you with an escape from your strenuous study.\n\nWe also post trail guides and recommended routes so stay tuned!','#00e1ff','Sport'),(8,'Campus Life','This club is managed by your student representatives. We post updates concerning anything to do with the university. \n\nWe hold regular forums and a large array of other events.','#310bef','Faculty');
/*!40000 ALTER TABLE `Clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notification`
--

DROP TABLE IF EXISTS `Notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notification` (
  `club_id` int NOT NULL,
  `user_id` int NOT NULL,
  `notification_setting` int DEFAULT NULL,
  PRIMARY KEY (`club_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Notification_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `Clubs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Notification_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notification`
--

LOCK TABLES `Notification` WRITE;
/*!40000 ALTER TABLE `Notification` DISABLE KEYS */;
INSERT INTO `Notification` VALUES (1,1,1),(3,1,3),(4,1,1),(5,1,2),(6,1,3),(8,1,2);
/*!40000 ALTER TABLE `Notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Posts`
--

DROP TABLE IF EXISTS `Posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `creation_date_time` varchar(255) DEFAULT NULL,
  `event_date_time` varchar(255) DEFAULT NULL,
  `event_location` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `event_type` varchar(255) DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `Posts_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `Clubs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Posts`
--

LOCK TABLES `Posts` WRITE;
/*!40000 ALTER TABLE `Posts` DISABLE KEYS */;
INSERT INTO `Posts` VALUES (1,'Welcome!','Welcome to the club. This is our first post and we can\'t wait to make more. \n\nWe will try and hold a weekly meetup to discuss anything related to programming.\n\nCome along if you need help or just want to chew the fat.\n\nLook forward to keeping you all in the loop.','2023-06-08T12:42:55.215Z',NULL,NULL,'post','public',1),(2,'Meetup 1','Come along to our first meetup. We\'ll be holding a free BBQ afterwards so be sure to stick around.\n\nOur great leader (me) will be giving a presentation on the dangers of AI (Scary!).\n\nIt\'ll be brief but I\'ll also introduce the club and give you guys some introduction to the Computer Science part of the uni.\n\nLook forward to seeing you all there!','2023-06-08T12:44:51.511Z','2023-05-05T00:30:00.000Z','Computer Suite','event','private',1),(3,'Thanks Everyone for Coming','If you missed the event it was a blast.\n\nWe had a good group turn up and discuss a whole array of matters. Look forward to see you all again at the next event.\n\nFell free to shoot me an email if anyone needs anything : test@test.com\n\nThanks again and good luck with the rest of the semester.','2023-06-08T12:46:35.709Z',NULL,NULL,'post','public',1),(4,'Good Luck with Exams!','Hi everyone, want to wish you all well with your mid semester exams.\n\nI luckily only have assignments so I\'ll be slaving away don\'t you worry.\n\nIf anyone needs help/support over this period feel free to reach out to me as needed.\n\nI\'ll organise an event for after exams so use that as your carrot!','2023-06-08T12:48:24.392Z',NULL,NULL,'post','private',1),(5,'Exams are Over Come Over','Hope everyone aced their exams. We\'re having a get together to charge our batteries and prepare for the next half of the semester.\n\nI\'ll be taking a break from updates for the next two weeks but they\'ll start back up again on the first week back.\n\nEnjoy your break and look forward to seeing you!','2023-06-08T12:50:09.580Z','2023-05-31T08:30:00.000Z','Pub','event','public',1),(6,'Meetup 2','Another meetup this time to talk business. We\'re trying to organise a little event where you can network and talk about side projects. \n\nPeople that want to put their skills into practice make sure you attend.\n\nFor instance I\'ve always wanted to create a cooking website where people can share recipes. If anyone is interested let me know. I know a few people that will attend already and they range from AI enthusiasts, JAVA haters, python people and everyone inbetween.\n\nStart time is a little weird as I had to book a room and this was the only one available.\n\nBring your ideas and come prepare!','2023-06-08T12:53:34.552Z','2023-07-30T07:50:00.000Z','Computer Suites','event','public',1),(7,'Get Ready For the Semester','The semester is about to begin and we\'re here to help you out. The law building can be a confusing place so we\'ll be set up in the foyer ready to help you out. I won\'t let you know what I\'m wearing but you;ll know it\'s us don\'t you worry. If you\'re a bit nervous that\'s ok, I\'m in fourth year and I still get butterflies. What will the year hold? Who knows? Hopefully HDs.','2023-06-08T12:55:30.651Z',NULL,NULL,'post','private',2),(8,'Visit from the Honorable Judge ...','Honorable Judge ... will be visiting and is open to have a chat with students. This is a great opportunity to get some advice/knowledge from this great woman. She used to be involved in contract law before becoming a judge so if that interest you definitely attend. She has been before and is always a great person to chat with even outside of what the holds concerns. See you all there!','2023-06-08T12:57:36.242Z','2023-06-01T04:00:00.000Z','Law Building - Moot Court','event','private',2),(9,'Law Ball','The big one is here so don\'t miss it! Law ball tickets are now on sale for $.. so get them while you can. They usually sell out quickly so get on it. The theme this year is Pirates, you don\'t have to dress as one though but the venue will be dressed up as if you are in the Caribbean. Check out last years photos on Instagram. ','2023-06-08T12:59:27.480Z','2023-08-31T09:00:00.000Z','Adelaide Oval','event','public',2),(10,'What is consideration?','If you\'ve ever wandered what is consideration well I\'ve got you covered. It means in a contract each side must give something (Otherwise it\'s a gift). You\'ll no doubt hear from your lecturers/tutors about this bloody peppercorn. Why is it so special? Well it means that one side has given something, it doesn\'t matter what it is, just that something was given. Now if you\'re being paid in peppercorns I would advise consulting a layer.','2023-06-08T13:01:22.474Z',NULL,NULL,'post','private',2),(11,'Big Law News','Did I grab your attention? Well there\'s some big law news recently. Space is becoming an increasingly important topic. Who owns what? Who owns the moon? I can\'t answer that, much like most areas of law, but I can argue who owns it. That\'s a lot of what law is, arguments. If you\'re interested in space law look for a great article by Buzz Aldrin coming out tomorrow.','2023-06-08T13:03:07.656Z',NULL,NULL,'post','public',2),(12,'Soccer Match Week 1','Get up bright and early to see the uni soccer team take on another uni soccer team. You have never before seen such athletic prowess. Our star strike Tom Cruise is looking to grab the golden boot this year but will anyone stop him (Injuries did the previous years but who\'s keeping track). There will be drinks and a BBQ for purchase at your leisure. Weather is looking good so come on down and enjoy it.','2023-06-08T13:05:14.645Z','2023-06-03T09:30:00.000Z','Soccer Pitch','event','public',3),(13,'Snooker Tournament','The snooker hall is having a tournament so here\'s your reminder. Come on down for some okay tunes but exciting games of snooker. There will be some try hards that bring their own cues but don\'t let that put you off. Prize is a jug of beer/choice of your choice.','2023-06-08T13:06:59.642Z','2023-08-11T09:30:00.000Z','Snooker Hall','event','public',3),(14,'Self-Care','Hey everyone, it\'s important to keep physically but also mentally fit through life. I\'d like to take the time to say if you have issues with either of these the campus support office would love to hear/see you. They\'ve helped me out in the past and I can attest to their care/professionalism .If you have an injury or need a chat with someone about something (even the weather) hit them up. Hope everyone is enjoying the semester, it\'s coming to a close soon.','2023-06-08T13:09:09.475Z',NULL,NULL,'post','private',3),(15,'Grudge Match','The AFL. The Australian Football League. Uh.. Footy. Anyway there\'s a big game this week between top of the table Bulldogs and the Crows. Get yourselves out to the oval and see it. I can\'t get you tickets unfortunately but you can exchange currency for them. I\'ll be there cheering on the team (I\'m a bulldogs fan) if you can spot me congratulations (My name is Wally if you didn\'t know).','2023-06-08T13:11:35.904Z',NULL,NULL,'post','public',3),(16,'Nitro Racing','Drones flying quickly. Need I say more. Get your butts down to the park lands for a lat morning speed fest. I went last year and it was great. The drones and their pilots are very impressive so I highly recommend it. For those of you that are interested in photography there will be a lot of drone people there that film/photograph so it;s not just racers. I can\'t attend this year unfortunately for undisclosed reasons but hope those that attend enjoy it.','2023-06-08T13:14:40.377Z','2023-08-24T01:30:00.000Z','Parklands','event','private',3),(17,'War and Peace','This weeks book is not war and peace I thought it would grab your attention. This is our first post so welcome. We try to catch up every week to talk books. We try to get through books at about a rate of one every fortnight. This periods book will be Harry Potter. Not sure if it\'s technically a classic but it\'s very popular. We\'ll see how everyone feels but if we all enjoy it we\'ll try and do the whole series.','2023-06-08T13:17:00.690Z',NULL,NULL,'post','public',4),(18,'Weekly Meetup','Come to this week\'s book club meeting. The book is Harry Potter.','2023-06-08T13:17:45.925Z','2023-06-02T08:15:00.000Z','Library','event','private',4),(19,'Blade Runner','The book is actually \"Do Androids Dream of Electric Sheep\" but I think most people will recognise the movie title more. Anyway this week book is that so get reading.','2023-06-08T13:18:56.701Z',NULL,NULL,'post','public',4),(20,'Book Club Meeting','Come to this week\'s book club meeting. The book is Harry Potter.','2023-06-08T13:19:33.893Z','2023-06-16T03:30:00.000Z','Library','event','private',4),(21,'Famous Author ... Meetup','Famous Author ... will be coming and is spending some time doing book signings and a talk. If you\'re a fan of his work make sure you come down. He\'s also said he might tease his next project.','2023-06-08T13:21:18.059Z','2023-09-15T02:30:00.000Z','Library','event','public',4),(22,'How to handle a knife?','One of the most important skills to learn is how to use a knife. It\'s important to first have  good knife. A sharp knife may seem scary but it is actually safer than a dull one. You need less force to cut things so you\'re less likely to force it and injure yourself. After you get a good knife it\'s then learn the basics and practice, practice and more practice. Keep your fist closed and rest the knife against you knuckles. If you curl your fingers you\'ll never cut yourself. Start slow and progress from there. The speed will come.','2023-06-08T13:24:09.871Z',NULL,NULL,'post','private',5),(23,'How to pick a recipe','Recipe books and sites can be overwhelming. How do you know what to make? I always suggest alternating between comfort and excitement. Make a dish you know well but follow a different recipe one night. Another night go wild and make something crazy. I like to google a random word and food. You\'ll be surprised by what I\'ve made.','2023-06-08T13:25:57.574Z',NULL,NULL,'post','public',5),(24,'Banquet of the Gods','This is our yearly banquet. Club members will cook and then eat. It\'s that simple. We\'ll be doing menu planning well in advance so make sure you attend that event to be up to date. We\'ll s[lit you into teams. Starters, mains and Dessert. Hope everyone is hungry!','2023-06-08T13:27:20.041Z','2023-11-23T03:30:00.000Z','Dining Hall','event','private',5),(25,'Banquet Prep','We need to start prep for the yearly banquet. Make sure you attend this event for info. We\'ll be sorting out teams and the menu. It\'s any dietary requirements are brought up during this time.','2023-06-08T13:28:21.234Z','2023-08-24T01:30:00.000Z','Dining Hall','event','public',5),(26,'That\'s a Wrap','Last week we organised a little video shoot to show some of the skills of our members. You\'ll see it posted to the uni website soon. Thanks to everyone that contributed to it, it\'s looking great but still needs a few more tweaks. Thanks again.','2023-06-08T13:29:44.843Z',NULL,NULL,'post','public',5),(27,'The Shining','To start the semester we are doing a screening of the shining. This is a free event so come down and enjoy some cinematic mastery. We\'ll be holding a few free screenings throughout the year so join the club to stay up to date. ','2023-06-08T13:31:23.359Z','2023-06-01T10:30:00.000Z','Move Theatre','event','public',6),(28,'Comics, who read them?','The demographic of comic readers is very broad in our current time. This wasn\'t always the case but it\'s great to see the medium grow. If you\'re worried it\'s seen as nerdy don\'t be. The person next to you might be a comic aficionado. If you haven\';t read comics before we recommend finding a comic that in a setting that you already like. Google is your friend here.','2023-06-08T13:33:34.314Z',NULL,NULL,'post','public',6),(29,'Important Update','Hey guys, I\'ll be leaving for a few months to travel. I\'ll be leaving you in Tom\'s capable hands. Thanks for all the support you\'ve given the club and look forward to returning. I\'m organising a going away thing somewhere so stay tuned for that.','2023-06-08T13:34:46.136Z',NULL,NULL,'post','private',6),(30,'I\'m Leaving (For a few months)','If you didn\'t see the last post I\'m leaving soon. I\'ll be travelling in Europe for a few months so Tom will be taking over managing the club. This will be a little get together to see me off so I hope you can all make it. I\'ll be back don\'t worry, you can\'t get rid of me that easily.','2023-06-08T13:36:06.887Z','2023-08-17T09:30:00.000Z','Pub','event','private',6),(31,'I\'m in Charge Now','BOW DOWN BEFORE ME MORT... got a bit carried away there. Hi guys, Tom here. I\'ll be taking over managing the club whilst that guys is gone. Anyway we still will have regular events and I\'ll get a few different people to send through some things for me to post. If you have a topic you are passionate about then feel free to reach out to me.','2023-06-08T13:37:38.789Z',NULL,NULL,'post','public',6),(32,'Welcome Hike','We\'ll be doing a welcome hike in the hills to kick off the launch of the club. Make sure you click attending so we know who to expect. The hike should take 1-2 hours so plan for that. I usually grab a coffee after so feel free to tag along if you want. Dogs are welcome (Children are not, just kidding :) ).','2023-06-08T13:39:30.445Z','2023-05-25T01:40:00.000Z','Hills','event','public',7),(33,'Shoes - What to know?','Shoes are important generally, but they play a large roll in hiking. We are not walking on pavement so you need god support and something that can withstand the elements. A few good brands are \"Feet Clothes\", \"Swoosh\", \"Versecon\" and \"Tyrell\". There are surely more out there but these are the well known ones. You want something that is sturdy but comfortable. Comfort is key, if you like hiking you\'ll be in them a lot.','2023-06-08T13:42:19.553Z',NULL,NULL,'post','private',7),(34,'Overnight Hike','We\'re organising an overnight hike. We\'ll need numbers confirmed a week before hand so make sure you respond to this event. We\'ll meet at uni and drive to the starting point. Do the loop and then drive back. The route is 30km total. If you need a life let me know via email and I\'ll start getting people hooked up. If you have transport and free seats also hit me up.','2023-06-08T13:44:18.307Z','2023-07-30T20:30:00.000Z','Uni Carpark','event','private',7),(35,'Look After Nature','It\'s quite simple. Pick up after yourselves. I don\'t think it\'s any of our members but we\'ve been noticing a lot of rubbish on trails recently. Make sure you don\'t litter and if you can pick up rubbish when you see it. On our future walks we\'ll be carrying garbage bags to clean as we go. Leave it better than you found it!','2023-06-08T13:45:46.842Z',NULL,NULL,'post','public',7),(36,'Welcome back!','Welcome back guys. It\'s been a hard few months not seeing your lovely faces. No doubt many of you are interning at some exclusive places and I can\'t wait to hear about it. O\'Week kicks off starting next week so make sure you get out and sign up to any clubs you need. Most clubs will be on this very site so make sure you join those you want and turn those notifications on. ','2023-06-08T13:47:55.734Z',NULL,NULL,'post','public',8),(37,'Welcome Drinks','We\'ll be hosting welcome drinks for all students. Come on down, have chat and catch up after the break. We\'ll also be looking for anyone interested in helping us out to post regular updates and organise events. We\'ll have a table set up so come speak to us if you want to take us up on the offer. Welcome back and good to see you all!','2023-06-08T13:49:41.387Z','2023-06-08T09:30:00.000Z','Uni Bar','event','public',8),(38,'Events Team Planning Session','The events team is meeting to discuss potential events over the coming year. Attend if you want to give any input. Open to all club members. We ask that you treat this seriously. We\'re trying to give back to the uni and it helps us out if you participate respectfully. See you all there with your amazing ideas!','2023-06-08T13:51:38.885Z','2023-07-14T01:50:00.000Z','Student Lounge','event','private',8),(39,'Help Us Help You','We need people to send in suggestions via \"organisers@test.com\". We like to get members involved and this is how you can contact us. We usually reply within a week to any requests. One suggestion last year was a silent disco, another mini gold tournament. They turned out great and they were ideas directly from the students.','2023-06-08T13:53:48.101Z',NULL,NULL,'post','private',8),(40,'Thanks Everyone','Thanks everyone who worked on our project over the course of the semester. It\'s great to see us start from only an idea and turn it into a fully functioning site. I hope everyone continues to improve and pursue whatever it is they want. This club has gone from strength to strength and we couldn\'t have done it without our members. We look forward to keeping you all up to date and hope that you continue to follow us over this period. A big shout out to Kai, Blake, Petra and Ed for all the work they put in. We couldn\'t have done it without them, Also, a big thanks to Ian and the rest of the teaching staff for their support over the semester. If you haven\'t already we highly recommend doing the Web & Database Computing course. See you all later!','2023-06-09T07:55:03.069Z',NULL,NULL,'post','public',1);
/*!40000 ALTER TABLE `Posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Posts_viewed`
--

DROP TABLE IF EXISTS `Posts_viewed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Posts_viewed` (
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Posts_viewed_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `Posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Posts_viewed_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Posts_viewed`
--

LOCK TABLES `Posts_viewed` WRITE;
/*!40000 ALTER TABLE `Posts_viewed` DISABLE KEYS */;
INSERT INTO `Posts_viewed` VALUES (2,1),(3,1),(5,1),(12,1),(13,1),(16,1),(20,1),(24,1),(25,1),(27,1),(28,1),(30,1),(34,1),(38,1),(40,1),(6,2),(9,2),(13,2),(16,2),(24,2),(25,2),(13,3),(16,3),(24,3),(25,3),(16,4),(24,4),(25,4),(30,4),(34,4),(13,5),(16,5),(30,5),(38,5),(9,6),(20,6),(21,6),(24,6),(25,6),(2,10),(6,10),(9,10),(20,10),(21,10),(30,10),(6,13),(9,13),(13,13),(16,13),(20,13),(21,13);
/*!40000 ALTER TABLE `Posts_viewed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rsvps`
--

DROP TABLE IF EXISTS `Rsvps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rsvps` (
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rsvp` int DEFAULT NULL,
  `date_responded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Rsvps_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `Posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `Rsvps_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rsvps`
--

LOCK TABLES `Rsvps` WRITE;
/*!40000 ALTER TABLE `Rsvps` DISABLE KEYS */;
INSERT INTO `Rsvps` VALUES (6,2,2,'2023-06-08T14:15:14.868Z'),(6,10,2,'2023-06-08T14:17:21.895Z'),(6,13,2,'2023-06-08T14:18:00.881Z'),(9,2,2,'2023-06-08T14:15:12.236Z'),(9,6,2,'2023-06-08T14:16:55.742Z'),(9,10,2,'2023-06-08T14:17:08.995Z'),(9,13,2,'2023-06-08T14:17:59.491Z'),(13,1,1,'2023-06-08T13:54:12.504Z'),(13,2,2,'2023-06-08T14:15:05.467Z'),(13,3,2,'2023-06-08T14:15:33.644Z'),(13,5,2,'2023-06-08T14:16:28.504Z'),(13,13,2,'2023-06-08T14:17:58.208Z'),(16,1,0,'2023-06-08T13:14:44.068Z'),(16,2,2,'2023-06-08T14:15:04.099Z'),(16,3,2,'2023-06-08T14:15:31.734Z'),(16,4,2,'2023-06-08T14:15:52.724Z'),(16,5,2,'2023-06-08T14:16:27.100Z'),(16,13,2,'2023-06-08T14:17:56.998Z'),(20,1,2,'2023-06-08T13:19:37.360Z'),(20,6,2,'2023-06-08T14:16:52.079Z'),(20,10,2,'2023-06-08T14:17:13.056Z'),(20,13,2,'2023-06-08T14:17:54.072Z'),(21,6,2,'2023-06-08T14:16:51.299Z'),(21,10,2,'2023-06-08T14:17:12.502Z'),(21,13,2,'2023-06-08T14:17:53.302Z'),(24,1,0,'2023-06-08T14:14:21.934Z'),(24,2,2,'2023-06-08T14:14:59.182Z'),(24,3,2,'2023-06-08T14:15:37.794Z'),(24,4,2,'2023-06-08T14:15:57.649Z'),(24,6,2,'2023-06-08T14:16:47.515Z'),(25,1,2,'2023-06-08T14:14:19.996Z'),(25,2,2,'2023-06-08T14:14:58.260Z'),(25,3,2,'2023-06-08T14:15:36.450Z'),(25,4,2,'2023-06-08T14:15:56.981Z'),(25,6,2,'2023-06-08T14:16:46.547Z'),(30,1,2,'2023-06-08T13:36:12.352Z'),(30,4,2,'2023-06-08T14:16:03.441Z'),(30,5,2,'2023-06-08T14:16:19.800Z'),(30,10,2,'2023-06-08T14:17:17.434Z'),(34,1,2,'2023-06-08T13:44:21.170Z'),(34,4,2,'2023-06-08T14:15:49.980Z'),(38,1,1,'2023-06-08T13:51:41.649Z'),(38,5,2,'2023-06-08T14:16:35.721Z');
/*!40000 ALTER TABLE `Rsvps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `passwords` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `system_administrator` int DEFAULT NULL,
  `profile_pic_path` varchar(255) DEFAULT NULL,
  `push_endpoint` varchar(500) DEFAULT NULL,
  `push_p256dh` varchar(500) DEFAULT NULL,
  `auth` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `push_endpoint` (`push_endpoint`),
  UNIQUE KEY `push_p256dh` (`push_p256dh`),
  UNIQUE KEY `auth` (`auth`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'Queen','Regent','queenofhearts','test1@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',1,NULL,'https://fcm.googleapis.com/fcm/send/dEbT9XTx4TA:APA91bEJia-tR3lt17urRprKfm3k63yr1yG3YqaNmFPXPditud2OFkHfA_TmDj3PmmXmboTV4d8mgEQxONygUHFA8Tw3zx_OyY5V16ahe2-cQmd_hbf_3SNm-N66jY1D7F09mhW822ad','BPOov4ZU_VXS_cjX7lI5im-FE3R_-f9uJeoWVgGCBYK3fsdTgN29XbgnbtsMMUCOMWwfg_lyIE9MjcPLqFSS9W8','lybEvTM1SPb6WDT7-MNPEw'),(2,'Ed','Sellars','zombiekiller','test2@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(3,'Kai','Koo','ghostwriter','test3@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(4,'Petra','Curdova','visionarymindset','test4@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(5,'Blake','Hammond','beauty.and.the.beast','test5@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(6,'John','Smith','sunkissedbabe','test6@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(7,'Tom','Cruise','stardust','test7@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(8,'Victor','Strange','anarchist_girl','test8@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(9,'Bruce','Wayne','lady_death','test9@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(10,'Tom','Dickens','getfitnow','test10@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(11,'Chris','Columbus','zestyzenmaster','test11@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(12,'Sam','Smith','believeinyourself','test12@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(13,'Anna','Grand','babydaddy','test13@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(14,'Sarah','Dinkle','guru','test14@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(15,'Granny','Smith','steelersfan','test15@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(16,'Tim','Tam','lovelyladylumps','test16@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(17,'Barbie','Barbie','dragonslayer','test17@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(18,'Rose','Poppy','stormtrooper','test18@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(19,'Melissa','Maleficent','heynurse','test19@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(20,'Evil','Man','coolestchickontheplanet','test20@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL),(21,'Evil','Woman','angelic_one','test21@test.com','$argon2id$v=19$m=65536,t=3,p=4$2agvO88gocgXR/hbsETFog$AJUOqBni5qwYFEJHPbwxgl87PTQ1nx6CkUOQbW2vhKY','1234',0,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `SetAutoIncrement` BEFORE INSERT ON `Users` FOR EACH ROW BEGIN
    DECLARE max_id INT;
    SET max_id = (SELECT COALESCE(MAX(id), 0) FROM Users);
    SET NEW.id = max_id + 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-09  7:57:29
