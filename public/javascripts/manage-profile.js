const vueinst = new Vue({
    el: '#app',
    data: {
        username: 'Username',
        first_name: '...',
        last_name: '...',
        email: '...',
        phone: '...',
        image: '/images/icon.png',
        edit_profile: false,
        profile_page: true
    },
    methods: {
        editProfile() {
            let request = {
                username: this.username,
                first_name: this.first_name,
                last_name: this.last_name,
                email: this.email,
                phone_number: this.phone
            };

            let req = new XMLHttpRequest();

            req.onreadystatechange = function(){
                if(req.readyState === 4 && req.status === 200){
                    /* */
                }
            };
            req.open('POST','/users/profile/edit');
            req.setRequestHeader('Content-Type','application/json');
            req.send(JSON.stringify(request));

            this.edit_profile = !this.edit_profile;
        },
        fetchProfileData() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200){
                    const response = JSON.parse(req.responseText);
                    if (response.length > 0) {
                        const userData = response[0];
                        this.username = userData.username;
                        this.email = userData.email;
                        if (userData.first_name){
                            this.first_name = userData.first_name;
                        }
                        if (userData.last_name){
                            this.last_name = userData.last_name;
                        }
                        if (userData.phone_number){
                            this.phone = userData.phone_number;
                        }
                        if (userData.profile_pic_path){
                            this.image = userData.profile_pic_path;
                        }
                    }
                }
            }.bind(this);

            req.open('GET', '/users/profile', true);
            req.send();

        },
        fetchProfileImage() {
            let req = new XMLHttpRequest();

            req.onreadystatechange = function() {
                if(req.readyState === 4 && req.status === 200){
                    const response = JSON.parse(req.responseText);
                    if (response.length > 0) {
                        const userData = response[0];
                        this.image = userData.profile_pic_path;
                    }
                }
            }.bind(this);

            req.open('GET', '/users/profile/', true);
            req.send();

        },
        uploadImage() {
            const { fileInput } = this.$refs;
            const file = fileInput.files[0];

            if (!file) {
              // Handle case when no file is selected
              return;
            }

            // Create a FormData object to send the file
            const formData = new FormData();
            formData.append('image', file);

            // Send the file using an XMLHttpRequest
            const req = new XMLHttpRequest();
            req.onreadystatechange = () => {
              if (req.readyState === 4) {
                if (req.status === 200) {
                    this.fetchProfileImage();
                  // Handle successful upload
                  console.log('Image uploaded successfully');
                } else if (req.status == 400) {
                    // Handle bad request (invalid image)
                    console.error('Error uploading image: Invalid image');
                } else {
                  // Handle upload error
                  console.error('Error uploading image: Server error');
                }
              }
            };
            req.open('POST', '/users/profile/upload');
            req.onerror = function() {
                // Handle network errors
                console.error('Error uploading image: Network error');
              };
            req.send(formData);

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
        this.fetchProfileData();
        this.getUserInfo();
    }
});

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

updateNotificationBadge();

// Marks the current link page as active
document.getElementById("profile-nav").className = "current-page";

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

//logout AJAX function called when user clicks logout button (implemented in the nav.js folder for feed.html)
function logout()
{

    let xhttp = new XMLHttpRequest();
    xhttp.open('POST','/logout');
    xhttp.send();
}

hamburger.addEventListener("click", toggleMenuOn, false);
exit.addEventListener("click", toggleMenuOff, false);

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