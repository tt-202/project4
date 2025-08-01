/*
    Name: Tuyen Tran
    Course: CNT 4714 – Summer 2025 – Project Four
    Assignment title: A Three-Tier Distributed Web-Based Application
    Date: July 31, 2025
    Class: accountantUserApp.java
*/

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class accountantUserApp extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String queryType = request.getParameter("query");
        String result = "";

        if (queryType == null) {
            result = "No query selected.";
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = System.getenv("DB_URL");
                String user = System.getenv("DB_USER");
                String password = System.getenv("DB_PASSWORD");

                Connection conn = DriverManager.getConnection(url, user, password);
                Statement stmt = conn.createStatement();
                ResultSet rs = null;

                switch (queryType) {
                    case "maxStatus":
                        rs = stmt.executeQuery("SELECT MAX(status) AS Maximum_Status_Of_All_Suppliers FROM suppliers");
                        if (rs.next()) {
                            int maxStatus = rs.getInt("Maximum_Status_Of_All_Suppliers");
                            result = "maximum_status_of_all_suppliers: " + maxStatus;
                        } else {
                            result = "No data found.";
                        }
                        break;

                    case "totalWeight":
                        rs = stmt.executeQuery("SELECT SUM(weight) AS Sum_Of_All_Part_Weights FROM parts");
                        if (rs.next()) {
                            int sumWeight = rs.getInt("Sum_Of_All_Part_Weights");
                            result = "sum_of_all_part_weights: " + sumWeight;
                        } else {
                            result = "No data found.";
                        }
                        break;

                    case "totalShipments":
                        rs = stmt.executeQuery("SELECT COUNT(*) AS The_Total_Number_Of_Shipments FROM shipments");
                        if (rs.next()) {
                            int totalShipments = rs.getInt("The_Total_Number_Of_Shipments");
                            result = "total_number_of_shipments: " + totalShipments;
                        } else {
                            result = "No data found.";
                        }
                        break;

                    case "mostWorkers":
                        rs = stmt.executeQuery("SELECT jname, numworkers FROM jobs WHERE numworkers = (SELECT MAX(numworkers) FROM jobs)");
                        if (rs.next()) {
                            String jobName = rs.getString("jname");
                            int numWorkers = rs.getInt("numworkers");
                            result = "job_with_most_workers: " + jobName + ", number_of_workers: " + numWorkers;
                        } else {
                            result = "No data found.";
                        }
                        break;

                    case "listSuppliers":
                        rs = stmt.executeQuery("SELECT sname, status FROM suppliers");
                        StringBuilder sb = new StringBuilder();
                        sb.append("<div style='width:100%; display:flex; justify-content:center; align-items:center;'>");
                        sb.append("<table border='1' style='color:white; margin:0 auto; display:block;'>");
                        sb.append("<tr><th>Supplier Name</th><th>Status</th></tr>");
                        boolean hasRows = false;
                        while (rs.next()) {
                            hasRows = true;
                            sb.append("<tr><td>")
                              .append(rs.getString("sname"))
                              .append("</td><td>")
                              .append(rs.getInt("status"))
                              .append("</td></tr>");
                        }
                        sb.append("</table></div>");
                        result = hasRows ? sb.toString() : "No data found.";
                        break;

                    default:
                        result = "Unknown query.";
                }

                if (rs != null) rs.close();
                stmt.close();
                conn.close();

            } catch (Exception e) {
                result = "Error: " + e.getMessage();
                e.printStackTrace();
            }
        }

        HttpSession session = request.getSession();
        session.setAttribute("result", result);
        session.setAttribute("textBox", "");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/accountantHome.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("result", "Please use the form to submit a query.");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/accountantHome.jsp");
        dispatcher.forward(request, response);
    }
}
