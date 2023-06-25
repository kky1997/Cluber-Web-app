// In menu shows number of unread posts
function updateNotificationBadge() {
    let req = new XMLHttpRequest();

    req.onreadystatechange = function(){
        if(req.readyState === 4 && req.status === 200){
            const notificationBadge = document.querySelector("#notifications");
            notificationBadge.innerText = req.responseText;
        }
    };
    req.open('GET',`/posts/unread`);
    req.send();
}

const vueinst = Vue.createApp({
    data() {
        return {
            // Multiple clubs component
            numberOfClubsDisplaying: 0,
            clubs: [],
            clubTags: [],
            tag_filter_value: "",
            club_filter_value: "",
            viewing_club: -1,
            viewing_club_name: "",
            // Club posts component
            posts: [],
            post_tag_filter_value: "",
            numberOfPostsDisplaying: 0,
            unreadPostImage: "./images/unread.svg",
            unreadPostHoverImage: "./images/mark_as_read.svg",
            clubs_obtained: false,
            club_manager: false,
            // The following capture info for post creation
            show_post_creation: false,
            post_creation_type: "",
            post_type: "",
            title: "",
            eventDate: "",
            location: "",
            post_content: "",
            // The following will reveal club members
            show_club_members: false,
            users: [],
            numberOfUsersDisplaying: 0,
            // The following will show rsvps for certain events
            show_rsvps: false,
            // Misc
            user_id: ""
        };
    },
    methods: {
        filterClubs() {
            this.getClubs();
        },
        filterPosts() {
            this.getPosts();
        },
        getPostsInitial() {
            document.getElementById("clubs-nav").classList.remove("current-page");
            // This will be an Ajax call to get the correct posts corresponding to the club
            this.filterPosts();
            if (this.user_id === "") {
                const filter = document.querySelector("#tags");
                filter.remove();
            }
            window.scroll(0,0);
            this.checkClubManagerAndMember();
        },
        getPosts() {
            const requestData = {
                club_id: this.viewing_club,
                tag: this.post_tag_filter_value,
                event_type: "",
                club_page: true
            };

            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    vueinst.posts = JSON.parse(req.responseText).map((item) => {
                        let post = item;

                        const formatter = new Intl.DateTimeFormat(navigator.language, {
                            dateStyle: "short",
                            timeStyle: "short"
                        });

                        if (post.tag === "event" && new Date(post.event_date_time) < new Date()) {
                            post.disable_rsvp = true;
                        }

                        post.creation_date_time = formatter.format(new Date(post.creation_date_time));
                        if (post.tag === 'event') {
                            post.event_date_time = formatter.format(new Date(post.event_date_time));
                        }

                        return post;
                    });
                    vueinst.numberOfPostsDisplaying = JSON.parse(req.responseText).length;

                    if (!vueinst.clubs_obtained) {
                        const map = new Map();

                        let clubsOfPosts = JSON.parse(req.responseText).filter((club) => {
                            if (map.get(club.club_id)) {
                            return false;
                            }
                            map.set(club.club_id, club);
                            return true;
                        });

                        vueinst.userFollowedClubs = clubsOfPosts.map((item) => {
                            let club = item;
                            return { id: club.club_id, name: club.club_name };
                        });
                        vueinst.clubs_obtained = true;
                    }
                }
            };
            req.open('POST','/posts');
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(requestData));
        },
        async createPost() {
            let post = "";
            if (this.post_creation_type === "post") {
                post = {
                        clubId: this.viewing_club,
                        eventDate: null,
                        location: null,
                        title: this.title,
                        tag: this.post_creation_type,
                        type: this.post_type,
                        content: this.post_content,
                        creation_date_time: new Date().toISOString()
                };
            } else {
                post = {
                        clubId: this.viewing_club,
                        eventDate: new Date(this.eventDate).toISOString(),
                        location: this.location,
                        title: this.title,
                        tag: this.post_creation_type,
                        type: this.post_type,
                        content: this.post_content,
                        creation_date_time: new Date().toISOString()
                };
            }

            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    vueinst.filterPosts();
                    const notificationBadge = document.querySelector("#notifications");
                    notificationBadge.innerText = Number(notificationBadge.innerText) + 1;
                }
            };
            req.open('POST','/users/posts/create');
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(post));

            let emailContent = ``;
            let event_date_formatted = "";
            let push_content = "";

            if (this.post_creation_type === 'post') {
                emailContent = `<h2>There is a new post for ${this.viewing_club_name}</h2><p>${this.post_content}</p>`;
                push_content = `There is a new post for ${this.viewing_club_name}`;
            } else {
                event_date_formatted = new Date(this.eventDate).toLocaleString();
                emailContent = `<h2>There is a new event for ${this.viewing_club_name}</h2><h3>Where: </h3><p>${this.location}</p><br><h3>When: </h3><p>${event_date_formatted}</p><br><p>${this.post_content}</p>`;
                push_content = `There is a new event for ${this.viewing_club_name} at ${this.location} on ${event_date_formatted}`;
            }

            let req2 = new XMLHttpRequest();

            let email = {
                tag: this.post_creation_type,
                title: `(Cluber) ${this.viewing_club_name} - ${this.title}`,
                content: emailContent,
                club_id: this.viewing_club,
                push_content: push_content
            };

            req2.onreadystatechange = await function(){
                if(req2.readyState === 4 && req2.status === 200){
                    /* */
                }
            };
            req2.open('POST','/users/notifications/send');
            req2.setRequestHeader('Content-Type','application/json');
            req2.send(JSON.stringify(email));

            this.post_creation_type = "";
            this.show_post_creation = false;
            this.eventDate = "";
            this.location = "";
            this.title = "";
            this.post_type = "";
            this.post_content = "";
        },
        getClubs() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    vueinst.clubs = JSON.parse(req.responseText);
                    vueinst.numberOfClubsDisplaying = JSON.parse(req.responseText).length;
                }
            };
            req.open('GET',`/clubs?tag=${vueinst.tag_filter_value}&club=${vueinst.club_filter_value}`);
            req.send();
        },
        rsvp(id, rsvp_number) {
            if (vueinst.posts[vueinst.posts.findIndex((x) => x.id === id)].rsvp === rsvp_number) {
                return;
            }

            vueinst.posts[vueinst.posts.findIndex((x) => x.id === id)].rsvp = rsvp_number;

            const requestData = {
                post_id: id,
                rsvp: rsvp_number,
                date_responded: new Date()
            };

            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    /* */
                }
            };
            req.open('POST','/users/posts/rsvp');
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(requestData));
        },
        markPostAsRead(id) {
            if (vueinst.posts[vueinst.posts.findIndex((x) => x.id === id)].Post_viewed === 1) {
                return;
            }
            vueinst.posts[vueinst.posts.findIndex((x) => x.id === id)].Post_viewed = 1;

            const requestData = {
                post_id: id
            };

            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    /* */
                }
            };
            req.open('POST','/users/posts/mark-as-read');
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(requestData));

            const notificationBadge = document.querySelector("#notifications");
            notificationBadge.innerText = Number(notificationBadge.innerText) - 1;
        },
        getClubMembers() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    vueinst.users = JSON.parse(req.responseText).map((item) => {
                        let user = item;
                        const formatter = new Intl.DateTimeFormat(navigator.language, {
                            dateStyle: "short",
                            timeStyle: "short"
                        });

                        user.date_joined = formatter.format(new Date(user.date_joined));

                        return user;
                    });
                    vueinst.numberOfUsersDisplaying = JSON.parse(req.responseText).length;
                }
            };
            req.open('GET',`/users/clubs/members?id=${vueinst.viewing_club}`);
            req.send();
        },
        getRsvps(id) {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    vueinst.users = JSON.parse(req.responseText).map((item) => {
                        let user = item;
                        const formatter = new Intl.DateTimeFormat(navigator.language, {
                            dateStyle: "short",
                            timeStyle: "short"
                        });

                        user.date_responded = formatter.format(new Date(user.date_responded));

                        return user;
                    });
                    vueinst.numberOfUsersDisplaying = JSON.parse(req.responseText).length;
                }
            };
            req.open('GET',`/users/posts/rsvp-users?id=${id}`);
            req.send();
        },
        getUserInfo() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    vueinst.user_id = req.responseText;
                    let res = JSON.parse(req.responseText);
                    if (res.user_id === "") {
                        const filter = document.querySelector("#club-filter");
                        filter.remove();

                        const profile = document.querySelector("#profile-nav");
                        profile.remove();

                        const notifications = document.querySelector("#notifications-nav");
                        notifications.remove();

                        const manage_users = document.querySelector("#manage-users-nav");
                        manage_users.remove();

                        const manage_clubs = document.querySelector("#manage-clubs-nav");
                        manage_clubs.remove();

                        const logout = document.querySelector("#logout");
                        logout.innerText = "Log In/Sign Up";
                        logout.title = "Log In or Sign Up";
                    } else if (!res.is_admin) {
                        const manage_users = document.querySelector("#manage-users-nav");
                        manage_users.remove();

                        const manage_clubs = document.querySelector("#manage-clubs-nav");
                        manage_clubs.remove();
                    }
                }
            };
            req.open('GET',`/users/info`);
            req.send();
        },
        checkClubManagerAndMember() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    const result = req.responseText;
                    if (result === "Neither") {
                        const club_manager_add = document.querySelector("#add-club-button");
                        club_manager_add.remove();

                        const club_manager_view = document.querySelector("#view-members-button");
                        club_manager_view.remove();

                        const rsvp_buttons = document.querySelectorAll(".view-rsvps-button");
                        for (const button of rsvp_buttons) {
                            button.remove();
                        }
                        vueinst.club_manager = false;
                    } else if(result === "Member" || result === "Public") {
                        const club_manager_add = document.querySelector("#add-club-button");
                        club_manager_add.remove();

                        const club_manager_view = document.querySelector("#view-members-button");
                        club_manager_view.remove();

                        const rsvp_buttons = document.querySelectorAll(".view-rsvps-button");
                        for (const button of rsvp_buttons) {
                            button.remove();
                        }
                        vueinst.club_manager = false;
                        const join_club = document.querySelector("#join-club-button");

                        if (result === "Member") {
                            join_club.style.display = "none";
                            document.querySelector("#leave-club-button").style.display = "block";
                        } else {
                            join_club.remove();
                        }
                    } else if (result === "Both") {
                        const join_club = document.querySelector("#join-club-button");
                        join_club.style.display = "none";
                        document.querySelector("#leave-club-button").style.display = "block";
                        vueinst.club_manager = true;
                    }
                }
            };
            req.open('GET',`/users/info/club-manager?club_id=${this.viewing_club}`);
            req.send();
        },
        joinClub() {

            let request = {
                club_id: this.viewing_club
            };

            const join_club = document.querySelector("#join-club-button");

            if (join_club.style.display !== "none") {
                request.join = true;
                join_club.style.display = "none";
                document.querySelector("#leave-club-button").style.display = "block";
            } else {
                request.join = false;
                document.querySelector("#leave-club-button").style.display = "none";
                join_club.style.display = "block";
                if (vueinst.club_manager) {
                    document.querySelector("#add-club-button").remove();
                    document.querySelector("#view-members-button").remove();
                }
            }

            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    updateNotificationBadge();
                }
            };
            req.open('POST','/users/clubs/join');
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(request));

            if (!request.join) {
                let req2 = new XMLHttpRequest();

                req2.onreadystatechange = function(){
                    if(req2.readyState === 4 && req2.status === 200){
                        /* */
                    }
                };
                req2.open('POST',`/users/notifications/update?club_id=${this.viewing_club}&notification_setting=0`);
                req2.send();
            }
        }
    },
    mounted() {
        function uniqueClubTags(tag, index, array) {
            return array.indexOf(tag) === index;
        }

        let req = new XMLHttpRequest();

        req.onreadystatechange = function(){
            if(req.readyState === 4 && req.status === 200){
                vueinst.clubs = JSON.parse(req.responseText);
                vueinst.numberOfClubsDisplaying = JSON.parse(req.responseText).length;

                vueinst.clubTags = JSON.parse(req.responseText).map((item) => {
                    let club = item;
                    return club.club_tag;
                });

                vueinst.clubTags = vueinst.clubTags.filter(uniqueClubTags);
            }
        };
        req.open('GET',`/clubs?tag=&club=`);
        req.send();
        this.getUserInfo();
    }
}).mount("#app");

// Marks the current link page as active
document.getElementById("clubs-nav").className = "current-page";

// Hamburger Menu Behaviour

const hamburger = document.querySelector("#hamburger");
const exit = document.querySelector("#exit-menu");
const menu = document.querySelector("#popout-menu");

function toggleMenuOn() {
    hamburger.style.display = "none";
    exit.style.display = "inline";
    menu.style.display = "flex";
    document.body.classList.add("stop-scrolling");
}

function toggleMenuOff() {
    menu.style.display = "none";
    exit.style.display = "none";
    hamburger.style.display = "inline";
    document.body.classList.remove("stop-scrolling");
}

hamburger.addEventListener("click", toggleMenuOn, false);
exit.addEventListener("click", toggleMenuOff, false);

// To reveal the back to top button
function revealBackToTop() {
    const backButton = document.querySelector("#back-to-top");
    if (window.scrollY > 1000) {
        backButton.style.display = "unset";
    } else {
        backButton.style.display = "none";
    }
}

document.addEventListener("scroll", revealBackToTop, false);

updateNotificationBadge();

async function send() {
    const register = await navigator.serviceWorker.register("./javascripts/service-worker.js");

    const subscription = await register.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: "BJDu8opIvUamtiZsKy5XZka2YxuOBNWxd6nKyYt2Cy1GQAl00ts9EdMJoxt9POBxyy0iEyZXmb-uvjaHUeey0XI"
    });

    let xhttp = new XMLHttpRequest();

    xhttp.onreadystatechange = function() {
        if(xhttp.readyState === 4 && xhttp.status === 200) {
            /* */
        }
    };

    xhttp.open('POST', '/users/subscribe');
    xhttp.setRequestHeader('Content-Type','application/json');
    xhttp.send(JSON.stringify(subscription));
}


if ("serviceWorker" in navigator) {
    send().catch((err) => console.error(err));
}

//logout AJAX function called when user clicks logout button (implemented in the nav.js folder for feed.html)
function logout()
{

    let xhttp = new XMLHttpRequest();
    xhttp.open('POST','/logout');
    xhttp.send();
}

updateNotificationBadge();

