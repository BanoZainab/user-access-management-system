<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Employee")) {
        response.sendRedirect("login.jsp?msg=Unauthorized Access");
        return;
    }

    List<String[]> softwareList = new ArrayList<>();
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/userAM", "postgres", "sparwez");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT id, name FROM software");
        while (rs.next()) {
            softwareList.add(new String[]{rs.getString("id"), rs.getString("name")});
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    String message = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Request Access</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }
        form {
            width: 400px;
            margin: auto;
        }
        label, select, textarea {
            display: block;
            width: 100%;
            margin: 10px 0;
        }
        input[type="submit"] {
            padding: 10px;
            width: 100%;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }
        .message-box {
            width: 400px;
            margin: 10px auto;
            padding: 15px;
            border: 1px solid;
            border-radius: 5px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
        }
        .another-request-btn {
            display: block;
            width: 400px;
            margin: 10px auto;
            text-align: center;
        }
        .another-request-btn input {
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            width: 100%;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <h2 style="text-align:center;">Request Access to Software</h2>

    <% if (message != null) {
        boolean isSuccess = message.toLowerCase().contains("success"); %>
        <div class="message-box <%= isSuccess ? "success" : "error" %>">
            <strong><%= message %></strong>
        </div>
        <div class="another-request-btn">
            <form action="requestAccess.jsp" method="get">
                <input type="submit" value="Send Another Request">
            </form>
        </div>
    <% } else { %>
        <form action="RequestServlet" method="post">
            <label for="software">Software Name:</label>
            <select name="softwareId" required>
                <% for (String[] software : softwareList) { %>
                    <option value="<%= software[0] %>"><%= software[1] %></option>
                <% } %>
            </select>

            <label for="accessType">Access Type:</label>
            <select name="accessType" required>
                <option value="Read">Read</option>
                <option value="Write">Write</option>
                <option value="Admin">Admin</option>
            </select>

            <label for="reason">Reason for Request:</label>
            <textarea name="reason" rows="4" required></textarea>

            <input type="submit" value="Submit Request">
        </form>
    <% } %>

</body>
</html>
