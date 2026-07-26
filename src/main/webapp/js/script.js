/* ===========================
   Terms & Conditions
=========================== */

const agree = document.getElementById("agreeTerms");
const payBtn = document.getElementById("payBtn");

if (agree && payBtn) {

    payBtn.disabled = true;

    agree.addEventListener("change", function () {

        payBtn.disabled = !this.checked;

    });

}

/* ===========================
   Exam Page
=========================== */

function examPayment() {

    const agree = document.getElementById("agreeTerms");

    if (!agree.checked) {

        alert("Please accept the Terms & Conditions.");

        return;

    }

    localStorage.setItem("service", "Exam Assistance");

    window.location.href = "payment.html";

}

/* ===========================
   Interview Page
=========================== */

function interviewPayment() {

    const agree = document.getElementById("agreeTerms");

    if (!agree.checked) {

        alert("Please accept the Terms & Conditions.");

        return;

    }

    localStorage.setItem("service", "Interview Assistance");

    window.location.href = "payment.html";

}

/* ===========================
   Payment Page
=========================== */

window.addEventListener("load", function () {

    const service = localStorage.getItem("service");

    const serviceBox = document.getElementById("service");

    if (serviceBox && service) {

        serviceBox.value = service;

    }

});