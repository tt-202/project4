<!--
Name: Tuyen Tran
Course: CNT 4714 – Summer 2025 – Project Four
Assignment title: A Three-Tier Distributed Web-Based Application Date: July 31, 2025
Class: accountantHome.jsp
    
-->




<%
    String result = (String) session.getAttribute("result");
    if (result == null) result = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Accountant Home</title>
    <link rel="stylesheet" type="text/css" href="./style.css" />
    <style>
      .accountant-btn {
        background: none;
        border: none;
        color: #fff;
        font-size: 1.5em;
        padding: 0;
        margin: 0 10px;
        cursor: pointer;
        text-decoration: underline;
        transition: color 0.2s;
      }
      .accountant-btn.execute:hover {
        color: #2ecc40 !important;
      }
      .accountant-btn.clear:hover {
        color: #ff4136 !important;
      }
    </style>
</head>
<body>
  <div style="text-align: center;">
    <h1 style="font-size: 2.5em; font-weight: lighter; color: #fff;">Wellcome to the Summer 2025 Project 4 Enterpries System</h1>
    <h2 style="font-style: italic; font-size: medium; color: #fff;">A Servlet/JSP Based Multi-Tiered Enterprise Application</h2>
    <h3 style="color: #fff;">You are connected to the Accountant Home Page</h3>
    <form action="/accountantUserApp" method="post" style="margin-top: 15px; text-align: center;">
      <div style="color: white;">
        <p style="font-style: italic; font-size: medium;">Please select one of the following queries to execute:</p>
        <div style="text-align: left; color: white;">
          <input type="radio" id="maxStatus" name="query" value="maxStatus">
          <label for="maxStatus" style="font-size: 0.95em;">Get the Maximum Status Value of all Suppliers (returns a maximum value)</label><br>
          <input type="radio" id="totalWeight" name="query" value="totalWeight">
          <label for="totalWeight" style="font-size: 0.95em;">Get the Total Weight of all Parts (returns a sum)</label><br>
          <input type="radio" id="totalShipments" name="query" value="totalShipments">
          <label for="totalShipments" style="font-size: 0.95em;">Get the Total Number of Shipments (returns the current number of shipments in total)</label><br>
          <input type="radio" id="mostWorkers" name="query" value="mostWorkers">
          <label for="mostWorkers" style="font-size: 0.95em;">Get the Name and the Number of Workers of the Job with the Most Workers (returns two values)</label><br>
          <input type="radio" id="listSuppliers" name="query" value="listSuppliers">
          <label for="listSuppliers" style="font-size: 0.95em;">List the Name and Status of Every Supplier (returns a list of supplier names with their current status)</label><br>
        </div>
        <br>
        <div style="font-style: italic; font-size: medium; color: white;">All execution results will appear below this line.</div>
       
        
          <button id="console" type="submit" class="accountant-btn execute">Execute Command</button>
          <button id="console" type="button" class="accountant-btn clear" onclick="clearResults()">Clear Results</button>
        </div>
      </div>
    </form>
    <hr style="width: 50%; text-align: center; color: white; font-size: 2em;">
    <div style="text-align: center; color: white;" id="executionResult">Execution Results:<br><span id="resultContent"><%=result%></span></div>
  </div>
  <script>
      function clearResults() {
        var resultSpan = document.getElementById('resultContent');
        if (resultSpan) {
          resultSpan.innerHTML = '';
        }
      }
    </script>
</body>
</html> 