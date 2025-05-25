package com.mycompany.userAccessManagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SoftwareServlet")
public class SoftwareServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String[] accessLevelsArray = request.getParameterValues("accessLevels");
        String accessLevels = "";
        if (accessLevelsArray != null) {
            accessLevels = String.join(",", accessLevelsArray);
        }

        String jdbcURL = "jdbc:postgresql://localhost:5432/userAM";
        String dbUser = "postgres";
        String dbPassword = "sparwez";

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "INSERT INTO software (name, description, access_levels) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, accessLevels);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("createSoftware.jsp?msg=Software+added+successfully");
            } else {
                response.sendRedirect("createSoftware.jsp?msg=Failed+to+add+software");
            }

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("createSoftware.jsp?msg=Error+occurred");
        }
    }
}
