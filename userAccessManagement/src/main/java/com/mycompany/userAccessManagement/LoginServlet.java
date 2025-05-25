package com.mycompany.userAccessManagement;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String jdbcURL = "jdbc:postgresql://localhost:5432/userAM";
        String dbUser = "postgres";
        String dbPassword = "sparwez";

        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

        try (
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            PreparedStatement ps = conn.prepareStatement(sql);
        ) {
            Class.forName("org.postgresql.Driver");

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                int userId = rs.getInt("id");

                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setAttribute("userId", userId);

                // Redirecting based on role
                if ("Employee".equals(role)) {
                    response.sendRedirect("requestAccess.jsp");
                } else if ("Manager".equals(role)) {
                    response.sendRedirect("pendingRequests.jsp");
                } else if ("Admin".equals(role)) {
                    response.sendRedirect("createSoftware.jsp");
                } else {
                    response.sendRedirect("login.jsp?msg=Invalid+role");
                }

            } else {
                response.sendRedirect("login.jsp?msg=Invalid+username+or+password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?msg=Error+occurred+during+login");
        }
    }
}
