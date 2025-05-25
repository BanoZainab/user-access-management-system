package com.mycompany.userAccessManagement;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !role.equals("Manager")) {
            response.sendRedirect("login.jsp?msg=Unauthorized");
            return;
        }

        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");

        String jdbcURL = "jdbc:postgresql://localhost:5432/userAM";
        String dbUser = "postgres";
        String dbPassword = "sparwez";

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, action);
            ps.setInt(2, requestId);

            ps.executeUpdate();
            ps.close();
            conn.close();

            response.sendRedirect("pendingRequests.jsp?msg=Request+" + action);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pendingRequests.jsp?msg=Error");
        }
    }
}
