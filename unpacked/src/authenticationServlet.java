/* 
    Name: Tuyen Tran
    Course: CNT 4714 – Summer 2025 – Project Four
    Assignment title: A Three-Tier Distributed Web-Based Application Date: July 31, 2025
    Class: authenticationServlet.java
*/

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

public class authenticationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inBoundUsername = request.getParameter("username");
        String inBoundPassword = request.getParameter("password");

        System.out.println("Trying to authenticate: '" + inBoundUsername + "' / '" + inBoundPassword + "'");

        boolean userCredentialsOK = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");
            
            Connection conn = DriverManager.getConnection(url, user, password);
            


            //Class.forName("com.mysql.cj.jdbc.Driver");
           // Connection conn = DriverManager.getConnection(
                //"jdbc:mysql://localhost:3306/credentialsDB", "root", "mysql"

            //);
            String sql = "SELECT * FROM usercredentials WHERE login_username = ? AND login_password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, inBoundUsername);
            ps.setString(2, inBoundPassword);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                userCredentialsOK = true;
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("userCredentialsOK: " + userCredentialsOK);

        if (userCredentialsOK) {
            if ("root".equals(inBoundUsername)) {
                response.sendRedirect("/rootHome.jsp");
            } else if ("client".equals(inBoundUsername)) {
                response.sendRedirect("/clientHome.jsp");
            } else if ("theaccountant".equals(inBoundUsername)) {
                response.sendRedirect("/accountantHome.jsp");
            } else {
                response.sendRedirect("/rootHome.jsp"); // default fallback
            }
        } else {
            response.sendRedirect("/errorpage.html");
        }
    }
}