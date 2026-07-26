function login() {

    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value;

    const adminEmail = "freshersedge@gmail.com";
    const adminPassword = "Kumar@123";

    if (email === "") {
        alert("Please enter Email.");
        return;
    }

    if (password === "") {
        alert("Please enter Password.");
        return;
    }

    if (email === adminEmail && password === adminPassword) {

        sessionStorage.setItem("adminLoggedIn", "true");

        alert("Login Successful!");

        window.location.href = "admin-dashboard.html";

    } else {

        alert("Invalid Email or Password.");

    }

}