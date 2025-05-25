package com.mycompany.userAccessManagement;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RequestServlet")
public class RequestServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || !"Employee".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp?msg=Unauthorized");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int softwareId = Integer.parseInt(request.getParameter("softwareId"));
        String accessType = request.getParameter("accessType");
        String reason = request.getParameter("reason");

        String jdbcURL = "jdbc:postgresql://localhost:5432/userAM";
        String dbUser = "postgres";
        String dbPassword = "sparwez";

        String sql = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, 'Pending')";

        try (
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            PreparedStatement ps = conn.prepareStatement(sql);
        ) {
            Class.forName("org.postgresql.Driver");

            ps.setInt(1, userId);
            ps.setInt(2, softwareId);
            ps.setString(3, accessType);
            ps.setString(4, reason);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("requestAccess.jsp?msg=Request+submitted+successfully");
            } else {
                response.sendRedirect("requestAccess.jsp?msg=Failed+to+submit+request");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("requestAccess.jsp?msg=Error+occurred");
        }
    }
}
