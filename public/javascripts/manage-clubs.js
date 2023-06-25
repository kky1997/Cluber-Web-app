const vueinst = new Vue({
    el: '#app',
    data: {
        clubs: [],
        selected_club: -1,
        selected_club_managers: [],
        delete_modal_visible: false,
        edit_modal_visible: false,
        add_modal_visible: false,
        edit_color: "",
        edit_name: "",
        edit_managers: [],
        edit_description: "",
        manager_dropdown_visible: false,
        new_manager: "",
        available_managers: []
    },
    methods: {
        getClubs: function() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.clubs = JSON.parse(req.responseText);
                }
            };

            req.open('GET', '/admin/clubs');
            req.setRequestHeader('Content-Type','application/json');
            req.send();
        },
        getSelectedClubManagers: function() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.edit_managers = JSON.parse(req.responseText);
                    vueinst.selected_club_managers = JSON.parse(req.responseText);
                }
            };

            req.open('GET', '/admin/clubs/' + this.selected_club + '/club-managers');
            req.setRequestHeader('Content-Type','application/json');
            req.send();
        },
        deleteClub: function() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.getClubs();
                    vueinst.selected_club = -1;
                    vueinst.delete_modal_visible = false;
                }
            };

            req.open('DELETE', '/admin/clubs/' + this.selected_club);
            req.setRequestHeader('Content-Type','application/json');
            req.send();
        },
        showEditModal: function(clubId) {
            this.selected_club = clubId;
            this.setEditValues();
            this.edit_modal_visible = true;
        },
        editManager: function (user_id, club_manager) {
            let requestData = {
                user_id: user_id,
                club_manager: club_manager
            };

            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.getClubs();
                }
            };

            req.open('POST', '/admin/clubs/' + this.selected_club + '/club-managers');
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(requestData));
        },
        editManagers: function() {
            /* add managers */
            for (let i in this.edit_managers) {
                if (!this.selected_club_managers.map((m) => m.id)
                        .includes(this.edit_managers[i].id)) {
                    this.editManager(this.edit_managers[i].id, true);
                }
            }

            /* remove managers */
            for (let i in this.selected_club_managers) {
                if (!this.edit_managers.map((m) => m.id)
                        .includes(this.selected_club_managers[i].id)) {
                    this.editManager(this.selected_club_managers[i].id, false);
                }
            }
        },
        editClub: function() {
            let requestData = {
                name: this.edit_name,
                description: this.edit_description,
                color: this.edit_color
            };


            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.editManagers();
                    vueinst.getClubs();
                    vueinst.edit_modal_visible = false;
                    vueinst.selected_club = -1;
                    vueinst.resetEditValues();
                }
            };

            req.open('POST', '/admin/clubs/' + this.selected_club);
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(requestData));
        },
        setEditValues: function() {
            if (this.selected_club === -1) {
                this.resetEditValues();
            } else {
                this.edit_color = this.getSelectedClub().color;
                this.edit_name = this.getSelectedClub().name;
                this.new_manager = "";
                this.manager_dropdown_visible = false;
                this.available_managers = [];
                this.edit_description = this.getSelectedClub().description;
                this.getSelectedClubManagers();
            }
        },
        getSelectedClubIndex: function() {
            return this.clubs.findIndex((club) => club.id === this.selected_club);
        },
        getSelectedClub: function() {
            return this.clubs[this.getSelectedClubIndex()];
        },
        removeManager: function(index) {
            this.edit_managers.splice(index, 1);
            this.updateAvailableManagers();
        },
        updateAvailableManagers: function() {
            let not_available_managers = [];
            for (let manager of this.edit_managers) {
                not_available_managers.push(manager.username);
            }

            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    let users = JSON.parse(req.responseText);

                    vueinst.available_managers = users.filter(
                        (user) => !not_available_managers.includes(user.username)
                    );
                }
            };

            req.open('GET', '/admin/users');
            req.setRequestHeader('Content-Type','application/json');
            req.send();
        },
        showManagerDropdownOrAddManager: function() {
            if (this.new_manager === "") {
                this.updateAvailableManagers();
                this.manager_dropdown_visible = true;
            } else {
                this.addManager();
            }
        },
        addManager: function() {
            let manager = this.available_managers
                .find((user) => user.username === this.new_manager);
            this.edit_managers.push(manager);
            this.manager_dropdown_visible = false;
            this.new_manager = "";
        },
        resetEditValues: function() {
            this.edit_color = "#000000";
            this.edit_name = "";
            this.edit_managers = [];
            this.new_manager = "";
            this.manager_dropdown_visible = false;
            this.available_managers = [];
            this.edit_description = "";
        },
        showAddModal: function() {
            this.resetEditValues();
            this.add_modal_visible = true;
        },
        addClub: function() {
            let requestData = {
                name: this.edit_name,
                description: this.edit_description,
                color: this.edit_color
            };

            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200) {
                    vueinst.getClubs();
                    vueinst.selected_club = JSON.parse(req.responseText).at(0)['LAST_INSERT_ID()'];
                    vueinst.editManagers();
                    vueinst.add_modal_visible = false;
                    vueinst.selected_club = -1;
                    vueinst.resetEditValues();
                }
            };

            req.open('POST', '/admin/clubs');
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(requestData));
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
        this.getClubs();
        this.getUserInfo();
    }
});

// Marks the current link page as active
document.getElementById("manage-clubs-nav").className = "current-page";

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
