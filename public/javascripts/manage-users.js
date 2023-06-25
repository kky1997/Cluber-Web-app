const vueinst = new Vue({
    el: '#app',
    data: {
        filtered_users: [],
        all_users: [],
        selected_user: -1,
        delete_modal_visible: false,
        edit_modal_visible: false,
        edit_username: "",
        edit_first_name: "",
        edit_last_name: "",
        edit_email: "",
        edit_phone_number: "",
        edit_is_admin: "",
        username_filter: "",
        user_role_filter: "all roles"
    },
    methods: {
        getUsers: function() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.filtered_users = JSON.parse(req.responseText);
                    vueinst.all_users = JSON.parse(req.responseText);
                }
            };

            req.open('GET', '/admin/users');
            req.setRequestHeader('Content-Type','application/json');
            req.send();
        },
        getRoles: function(userId) {
            let user = this.all_users[this.all_users.findIndex((u) => u.id === userId)];
            if (user.isAdmin && user.isClubManager) {
                return "ADMIN, CLUB MANAGER";
            }
            if (user.isAdmin) {
                return "ADMIN";
            }
            if (user.isClubManager) {
                return "CLUB MANAGER";
            }
            return "CLUB MEMBER";
        },
        deleteUser: function() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.getUsers();
                    vueinst.filterUsers();
                    vueinst.selected_user = -1;
                    vueinst.delete_modal_visible = false;
                }
            };

            req.open('DELETE', '/admin/users/' + this.selected_user);
            req.setRequestHeader('Content-Type','application/json');
            req.send();
        },
        showEditModal: function(userId) {
            this.edit_modal_visible = true;
            this.selected_user = userId;

            this.setEditValues();
        },
        setEditValues: function() {
            if (this.selected_user === -1) {
                this.edit_username = "";
                this.edit_first_name = "";
                this.edit_last_name = "";
                this.edit_email = "";
                this.edit_phone_number = "";
                this.edit_is_admin = "";
            } else {
                this.edit_username = this.getSelectedUser().username;
                this.edit_first_name = this.getSelectedUser().firstName;
                this.edit_last_name = this.getSelectedUser().lastName;
                this.edit_email = this.getSelectedUser().email;
                this.edit_phone_number = this.getSelectedUser().phoneNumber;
                this.edit_is_admin = this.getSelectedUser().isAdmin;
            }
        },
        editUser: function() {
            let requestData = {
                username: this.edit_username,
                first_name: this.edit_first_name,
                last_name: this.edit_last_name,
                email: this.edit_email,
                phone_number: this.edit_phone_number,
                is_admin: this.edit_is_admin
            };

            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.getUsers();
                    vueinst.filterUsers();
                    vueinst.edit_modal_visible = false;
                    vueinst.selected_user = -1;
                    vueinst.setEditValues();
                }
            };

            req.open('POST', '/admin/users/' + this.selected_user);
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(requestData));
        },
        filterUsers: function() {
            this.filtered_users = this.all_users.filter(
                (user) => user.username.includes(this.username_filter)
            );
            if (this.user_role_filter === "ADMIN") {
                this.filtered_users = this.filtered_users.filter(
                    (user) => user.isAdmin
                );
            } else if (this.user_role_filter === "CLUB MANAGER") {
                this.filtered_users = this.filtered_users.filter(
                    (user) => user.isClubManager
                );
            } else if (this.user_role_filter === "CLUB MEMBER") {
                this.filtered_users = this.filtered_users.filter(
                    (user) => !user.isAdmin && !user.isClubManager
                );
            }
        },
        getSelectedUserIndex: function() {
            return this.all_users.findIndex((user) => user.id === this.selected_user);
        },
        getSelectedUser: function() {
            return this.all_users[this.getSelectedUserIndex()];
        },
        getUserInfo() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    vueinst.user_id = req.responseText;
                    let res = JSON.parse(req.responseText);
                    if (res.user_id === "") {
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
        }
    },
    mounted: function() {
        this.getUsers();
        this.getUserInfo();
    }
});

// Marks the current link page as active
document.getElementById("manage-users-nav").className = "current-page";

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

//logout AJAX function called when user clicks logout button (implemented in the nav.js folder for feed.html)
function logout()
{

    let xhttp = new XMLHttpRequest();
    xhttp.open('POST','/logout');
    xhttp.send();
}

updateNotificationBadge();

const vapidPublicKey = "BJDu8opIvUamtiZsKy5XZka2YxuOBNWxd6nKyYt2Cy1GQAl00ts9EdMJoxt9POBxyy0iEyZXmb-uvjaHUeey0XI";

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
