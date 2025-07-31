<%
    String textBox = (String) session.getAttribute("textBox");
    String result = (String) session.getAttribute("result");
    if (textBox == null) textBox = "";
    if (result == null) result = "";
%>

<!--
/* Name: Tuyen Tran
Course: CNT 4714 – Summer 2025 – Project Four
Assignment title: A Three-Tier Distributed Web-Based Application Date: July 31, 2025
Class: rootHome.jsp
*/
-->

<!DOCTYPE html>



<html lang="en">
    <head>
      <title>Root Home</title>
      <link rel="stylesheet" type="text/css" href="./style.css" />
      <style>
        .root-btn {
          background: none;
          border: none;
          color: #fff;
          font-size: 1.2em;
          padding: 0;
          margin: 0 10px;
          cursor: pointer;
          text-decoration: underline;
          transition: color 0.2s;
        }
        .root-btn.execute:hover {
          color: #2ecc40 !important;
        }
        .root-btn.reset:hover {
          color: #ff851b !important;
        }
        .root-btn.clear:hover {
          color: #ff4136 !important;
        }
      </style>

      <script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
        <script type = "text/javascript">
            function eraseText() {
                // <!-- next line illustrates a straight JavaScript technique
                // document.getElementById("cmd").innerHTML=" ";
                // next line illustrates a JQuery technique
                $("#cmd").html("");
            }
        </script>
        <script type = "text/javascript"> 
            function eraseData() {
                // next line illustrates a straight JavaScript technique
                // document. getElementByID ("data") , innerHTML = .:
                // next line illustrates a JQuery technique
                $("#data").remove();
            }
        </script>
    </head>
    
    <body>
    
      <div align="center">
        <h1 style="font-size: 2.5em; font-weight: lighter; color: white;">
          Wellcome to the Summer 2025 Project 4 Enterpries System
        </h1>
        
        <h2 style="font-style: italic; font-size: medium; color: white;">
          A Servlet/JSP Based Multi-Tiered Enterprise Application Using A Tomcat Container
        </h2>
        <br>
      </div>
    
      <div class="overlay">
        <form action="/Project4/clientUserApp" method="post" style="margin-top: 5px; text-align: center;">
          <div style="color: white;">
            <p style="font-style: italic; font-size: medium;">You are connected to the Project 4 Enterprise System Database as a root-level user.</p>
            <b>Please enter any SQL query or update command in the box below.</b>
          </div>
          <textarea name="textBox" id="textBox" rows="8" cols="70" style="color: white; font-size: 1.1em; margin: 10px 0;"><%=textBox%></textarea>
          <br>
          <button type="submit" class="root-btn execute">Execute Command</button>
          <button type="button" class="root-btn reset" onclick="redirectToIndex()">Reset Form</button>
          <button type="button" class="root-btn clear" onclick="clearResults()">Clear Results</button>
          <div style="font-style: italic; font-size: medium; color: white;">
            All execution results will appear below this line.</div>
        </form>
        <hr style="width: 50%; text-align: center; color: white; font-size: 2em;" />
        <div style="text-align: center; color: white;" id="executionResult">Execution Results:<br><span id="resultContent"><%=result%></span></div>

    
    </body> 
    <script>
      function clearResults() {
        var resultSpan = document.getElementById('resultContent');
        if (resultSpan) {
          resultSpan.innerHTML = '';
        }
      }
      function redirectToIndex() {
        window.location.href = 'index.html';
      }
    </script>
</html>