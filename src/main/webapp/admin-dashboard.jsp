<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1">

<title>FreshersEdge Admin Dashboard</title>

<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
rel="stylesheet">

<link
rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>

body{

background:#f5f5f5;

}

.navbar{

background:#212529;

}

.card{

border:none;

border-radius:12px;

box-shadow:0 3px 12px rgba(0,0,0,.15);

}

.table th{

background:#212529;

color:white;

}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg">

<div class="container">

<h2 class="text-white">

FreshersEdge Admin Dashboard

</h2>

<a
href="index.html"
class="btn btn-outline-light">

Logout

</a>

</div>

</nav>

<%

Connection con=null;

PreparedStatement ps=null;

ResultSet rs=null;

int totalPayments=0;

double totalAmount=0;

int examCount=0;

int interviewCount=0;

int pendingCount=0;

int approvedCount=0;

int rejectedCount=0;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con=DriverManager.getConnection(

"jdbc:mysql://localhost:3306/freshersedge",

"root",

"Ajay@123"

);

Statement st=con.createStatement();

ResultSet r1=st.executeQuery(

"SELECT COUNT(*) FROM payments");

if(r1.next())

totalPayments=r1.getInt(1);

ResultSet r2=st.executeQuery(

"SELECT SUM(amount) FROM payments");

if(r2.next())

totalAmount=r2.getDouble(1);

ResultSet r3=st.executeQuery(

"SELECT COUNT(*) FROM payments WHERE service='Exam Assistance'");

if(r3.next())

examCount=r3.getInt(1);

ResultSet r4=st.executeQuery(

"SELECT COUNT(*) FROM payments WHERE service='Interview Assistance'");

if(r4.next())

interviewCount=r4.getInt(1);

ResultSet r5=st.executeQuery(

"SELECT COUNT(*) FROM payments WHERE status='Pending'");

if(r5.next())

pendingCount=r5.getInt(1);

ResultSet r6=st.executeQuery(

"SELECT COUNT(*) FROM payments WHERE status='Approved'");

if(r6.next())

approvedCount=r6.getInt(1);

ResultSet r7=st.executeQuery(

"SELECT COUNT(*) FROM payments WHERE status='Rejected'");

if(r7.next())

rejectedCount=r7.getInt(1);

%>

<div class="container mt-4">

<div class="d-flex justify-content-between align-items-center mb-4">

<h2>

Dashboard

</h2>

<h5 id="clock" class="text-primary"></h5>

</div>

<div class="row">
<div class="col-md-3 mb-3">

<div class="card bg-primary text-white">

<div class="card-body text-center">

<h5>Total Payments</h5>

<h2><%=totalPayments%></h2>

</div>

</div>

</div>

<div class="col-md-3 mb-3">

<div class="card bg-success text-white">

<div class="card-body text-center">

<h5>Total Amount</h5>

<h2>₹ <%=totalAmount%></h2>

</div>

</div>

</div>

<div class="col-md-3 mb-3">

<div class="card bg-info text-white">

<div class="card-body text-center">

<h5>Exam Help</h5>

<h2><%=examCount%></h2>

</div>

</div>

</div>

<div class="col-md-3 mb-3">

<div class="card bg-secondary text-white">

<div class="card-body text-center">

<h5>Interview Help</h5>

<h2><%=interviewCount%></h2>

</div>

</div>

</div>

<div class="col-md-4 mb-3">

<div class="card bg-warning">

<div class="card-body text-center">

<h5>Pending</h5>

<h2><%=pendingCount%></h2>

</div>

</div>

</div>

<div class="col-md-4 mb-3">

<div class="card bg-success text-white">

<div class="card-body text-center">

<h5>Approved</h5>

<h2><%=approvedCount%></h2>

</div>

</div>

</div>

<div class="col-md-4 mb-3">

<div class="card bg-danger text-white">

<div class="card-body text-center">

<h5>Rejected</h5>

<h2><%=rejectedCount%></h2>

</div>

</div>

</div>

</div>

<hr>

<div class="row mb-3">

<div class="col-md-6">

<input
type="text"
id="searchInput"
class="form-control"
placeholder="Search by Name, Mobile, Email, UTR..."
onkeyup="searchTable()">

</div>

</div>

<h3 class="mb-3">

Payment Records

</h3>

<div class="table-responsive">

<table class="table table-bordered table-hover align-middle">

<thead>

<tr>

<th>ID</th>

<th>Name</th>

<th>Mobile</th>

<th>Email</th>

<th>Service</th>

<th>Amount</th>

<th>Bank</th>

<th>UPI</th>

<th>UTR</th>

<th>Date & Time</th>

<th>Status</th>

<th>Action</th>

</tr>

</thead>

<tbody>

<%

String sql="SELECT * FROM payments ORDER BY id DESC";

ps=con.prepareStatement(sql);

rs=ps.executeQuery();

while(rs.next()){

String status=rs.getString("status");

%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><%=rs.getString("full_name")%></td>

<td><%=rs.getString("mobile")%></td>

<td><%=rs.getString("email")%></td>

<td><%=rs.getString("service")%></td>

<td>₹ <%=rs.getDouble("amount")%></td>

<td><%=rs.getString("bank_name")%></td>

<td><%=rs.getString("upi_id")%></td>

<td><%=rs.getString("utr")%></td>
<td>
<%=new java.text.SimpleDateFormat("hh:mm a")
.format(rs.getTimestamp("payment_date"))%>
</td>
<td>

<%

if(status.equalsIgnoreCase("Pending")){

%>

<span class="badge bg-warning text-dark">

Pending

</span>

<%

}
else if(status.equalsIgnoreCase("Approved")){

%>

<span class="badge bg-success">

Approved

</span>

<%

}
else{

%>

<span class="badge bg-danger">

Rejected

</span>

<%

}

%>

</td>

<td>

<a
href="ApprovePaymentServlet?id=<%=rs.getInt("id")%>"
class="btn btn-success btn-sm mb-1">

Approve

</a>

<br>

<a
href="RejectPaymentServlet?id=<%=rs.getInt("id")%>"
class="btn btn-warning btn-sm mb-1">

Reject

</a>

<br>

<a
href="DeletePaymentServlet?id=<%=rs.getInt("id")%>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete this payment?');">

Delete

</a>

</td>

</tr>

<%

}

}
catch(Exception e){

%>

<tr>

<td colspan="11" class="text-center text-danger">

<%=e.getMessage()%>

</td>

</tr>

<%

}
finally{

try{

if(rs!=null)
rs.close();

if(ps!=null)
ps.close();

if(con!=null)
con.close();

}
catch(Exception ex){}

}

%>

</tbody>

</table>

</div>

</div>

<footer class="bg-dark text-white text-center mt-5 py-4">

<div class="container">

<h5>

FreshersEdge Admin Panel

</h5>

<p>

Manage Customer Payments Efficiently

</p>

<hr>

<p class="mb-0">

© 2026 FreshersEdge. All Rights Reserved.

</p>

</div>

</footer>

<script>

function searchTable(){

let input=document.getElementById("searchInput");

let filter=input.value.toUpperCase();

let table=document.querySelector("table");

let tr=table.getElementsByTagName("tr");

for(let i=1;i<tr.length;i++){

let found=false;

let td=tr[i].getElementsByTagName("td");

for(let j=0;j<td.length-1;j++){

if(td[j]){

let txt=td[j].textContent||td[j].innerText;

if(txt.toUpperCase().indexOf(filter)>-1){

found=true;

}

}

}

tr[i].style.display=found?"":"none";

}

}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>

function updateClock(){

const now = new Date();

document.getElementById("clock").innerHTML =
now.toLocaleString();

}

setInterval(updateClock,1000);

updateClock();

</script>
</body>

</html>
