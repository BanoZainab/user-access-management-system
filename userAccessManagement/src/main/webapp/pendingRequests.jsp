<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Manager")) {
        response.sendRedirect("login.jsp?msg=Unauthorized Access");
        return;
    }

    List<String[]> requests = new ArrayList<>();
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/userAM", "postgres", "sparwez");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(
            "SELECT r.id, u.username, s.name AS software_name, r.access_type, r.reason " +
            "FROM requests r " +
            "JOIN users u ON r.user_id = u.id " +
            "JOIN software s ON r.software_id = s.id " +
            "WHERE r.status = 'Pending'"
        );
        while (rs.next()) {
            requests.add(new String[]{
                rs.getString("id"),
                rs.getString("username"),
                rs.getString("software_name"),
                rs.getString("access_type"),
                rs.getString("reason")
            });
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Access Requests</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        form { display: inline; }
        input[type="submit"] {
            padding: 5px 10px;
            margin: 2px;
            border: none;
            color: white;
            cursor: pointer;
        }
        .approve { background-color: green; }
        .reject { background-color: red; }
    </style>
</head>
<body>
    <h2>Pending Access Requests</h2>
    <table>
        <tr>
            <th>Employee Name</th>
            <th>Software Name</th>
            <th>Access Type</th>
            <th>Reason</th>
            <th>Actions</th>
        </tr>
        <% for (String[] r : requests) { %>
        <tr>
            <td><%= r[1] %></td>
            <td><%= r[2] %></td>
            <td><%= r[3] %></td>
            <td><%= r[4] %></td>
            <td>
                <form action="ApprovalServlet" method="post">
                    <input type="hidden" name="requestId" value="<%= r[0] %>">
                    <input type="hidden" name="action" value="Approved">
                    <input type="submit" value="Approve" class="approve">
                </form>
                <form action="ApprovalServlet" method="post">
                    <input type="hidden" name="requestId" value="<%= r[0] %>">
                    <input type="hidden" name="action" value="Rejected">
                    <input type="submit" value="Reject" class="reject">
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
