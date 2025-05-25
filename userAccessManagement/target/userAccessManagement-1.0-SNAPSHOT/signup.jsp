<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 50px;
            background-color: #f2f2f2;
        }
        form {
            width: 300px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
        }
    </style>
</head>
<body>

<h2 align="center">Employee Sign Up</h2>

<form action="SignUpServlet" method="post">
    <label for="username">Username:</label><br/>
    <input type="text" id="username" name="username" required><br/>

    <label for="password">Password:</label><br/>
    <input type="password" id="password" name="password" required><br/>

    <!-- Hidden field for default Employee role -->
    <input type="hidden" name="role" value="Employee">

    <input type="submit" value="Sign Up">
</form>

</body>
</html>
