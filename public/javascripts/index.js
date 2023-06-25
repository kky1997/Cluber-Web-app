const vueinst = Vue.createApp({
    data() {
        return {
            signIn: true,
            username: "",
            password: "",
            repeatPassword: "",
            email: ""
        };
    }
}).mount("#app");

function login(event)
{
    //use the event object to prevent the form executing it's default behaviour (POST to / since no "action" property is specifed in the html)
    //this way, if the login is unsucessful, the page will just remain the same so the user can try again
    //if the login is successful, they will be redirect to feed.html by the window.location.href below.
    event.preventDefault();

    var xhttp = new XMLHttpRequest();
    var errorDiv = document.getElementById('login-error-message'); // get the login error message div

    let userData = {
        username: document.getElementById('username').value,
        password: document.getElementById('password').value
    };

    xhttp.onreadystatechange = function()
    {
        if(xhttp.readyState === 4 && xhttp.status === 200)
        {
            window.location.href = '/feed.html'; // Redirect to feed.html
        }
        else if(xhttp.readyState === 4 && xhttp.status === 401)
        {
           errorDiv.textContent = "Password or Username is incorrect. Please try again.";
           errorDiv.style.display = 'block';
        }
    };

    xhttp.open('POST', '/login');
    xhttp.setRequestHeader('Content-Type','application/json');
    xhttp.send(JSON.stringify(userData));
}

// helper function that will return a promise
// used inthe submitSignupForm() function below
function signup()
{
    return new Promise(function(resolve, reject)
    {
        var xhttp = new XMLHttpRequest();
        let password = document.getElementById('password-creation');
        let repeatPassword = document.getElementById('password-repeat');
        var errorDiv = document.getElementById('creation-error-message'); // get the account creation error message div


        if(password.value !== repeatPassword.value)
        {
            errorDiv.textContent = "Password don't match. Please try again.";
            errorDiv.style.display = 'block';
            return;
        }

        //create JSON payload
        let userData ={
            email: document.getElementById('email').value,
            username: document.getElementById('username-creation').value,
            password: password.value
        };

        xhttp.onreadystatechange = function()
        {
            if(xhttp.readyState === 4 && xhttp.status === 200)
            {
                resolve(true); // if everything is fine, return promise (true) to the awaiting submitSignupForm()
            }
            else if(xhttp.readyState === 4 && xhttp.status === 401)
            {
                resolve(false); //else return promise (false) to to the awaiting submitSignupForm()
            }
            else if(xhttp.readyState === 4 && xhttp.status === 422) //400 error if password too short (< 12 characters)
            {
                errorDiv.textContent = "Password too short. Please enter a password that is at least 12 characters long.";
                errorDiv.style.display = 'block';
                resolve(false); //else return promise (false) to to the awaiting submitSignupForm()
            }
            else if(xhttp.readyState === 4 && xhttp.status === 409) //409 username/email already exists
            {
                errorDiv.textContent = "Email or username alreaddy exists. Please ensure that you do not already have an account or use another email or username.";
                errorDiv.style.display = 'block';
                resolve(false); //else return promise (false) to to the awaiting submitSignupForm()
            }
        };

        xhttp.open('POST', '/signup');
        xhttp.setRequestHeader('Content-Type','application/json');
        xhttp.send(JSON.stringify(userData));
        });
}

// async function that will actually be called in index.html
// stops the default post event (making a post request that redirects back to login)
// await signup() method's promise, if it's successful, then submit the form and redirect user to login
// if not succesful, user stays on the signup page and can try to signup again
async function submitSignupForm(event) {
    event.preventDefault(); // Prevent default form submission
    const success = await signup();
    if (success) {
      event.target.submit(); // Submit the form
    }
  }

function google_login(response)
{
    var xhttp = new XMLHttpRequest();
    var errorDiv = document.getElementById('login-error-message'); // get the login error message div
    console.log(response);

    xhttp.onreadystatechange = function() {
        if(xhttp.readyState === 4 && xhttp.status === 200)
        {
            window.location.href = '/feed.html'; // Redirect to feed.html
        } else if(xhttp.readyState === 4 && xhttp.status === 401)
        {
            errorDiv.textContent = "Google sign-in failed. Please try again.";
            errorDiv.style.display = 'block';
        }
    };

    xhttp.open('POST', '/login');
    xhttp.setRequestHeader('Content-Type','application/json');
    xhttp.send(JSON.stringify(response));
}

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
