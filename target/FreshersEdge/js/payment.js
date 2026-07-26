window.onload = function () {

	const service = localStorage.getItem("service");

	if(service){

	    document.getElementById("service").value = service;

	}

};

function continuePayment() {

    let name = document.getElementById("name").value.trim();
    let mobile = document.getElementById("mobile").value.trim();
    let email = document.getElementById("email").value.trim();
    let service = document.getElementById("service").value;
    let amount = document.getElementById("amount").value.trim();

    if (name == "") {

        alert("Please enter your Full Name");
        return;

    }

    if (mobile == "") {

        alert("Please enter your Mobile Number");
        return;

    }

    if (!/^[0-9]{10}$/.test(mobile)) {

        alert("Mobile Number must contain exactly 10 digits");
        return;

    }

    if (email == "") {

        alert("Please enter your Email");
        return;

    }

    if (service == "") {

        alert("Please select the Service");
        return;

    }

    if (amount == "") {

        alert("Please enter the Amount");
        return;

    }

    amount = parseInt(amount);

    if (amount <= 0) {

        alert("Please enter a valid Amount");
        return;

    }

    /* Save customer details */

    localStorage.setItem("customerName", name);
    localStorage.setItem("mobile", mobile);
    localStorage.setItem("email", email);
    localStorage.setItem("service", service);
    localStorage.setItem("amount", amount);

    /* Select Bank Automatically */

    let bank = "";
    let qr = "";
    let upi = "";

    if (amount < 1000) {

        bank = "State Bank of India";
        qr = "images/sbi.jpeg";
        upi = "jayhelp@ybl";

    }
    else if (amount < 2000) {

        bank = "ICICI Bank";
        qr = "images/icici.jpeg";
        upi = "jayicicib@ybl";

    }
    else {

        bank = "APGB Bank";
        qr = "images/apgb.jpeg";
        upi = "jayinter@ybl";

    }

    localStorage.setItem("bank", bank);
    localStorage.setItem("qr", qr);
    localStorage.setItem("upi", upi);

    window.location.href = "scanqr.html";

}