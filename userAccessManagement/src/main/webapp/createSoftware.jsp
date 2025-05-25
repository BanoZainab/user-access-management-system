<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Create Software</title>
    <style>
        body {
            background-color: #f4f6f8;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .container {
            background: white;
            padding: 40px 30px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 400px;
        }

        h2 {
            margin-bottom: 25px;
            color: #333;
            text-align: center;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            color: #555;
            font-weight: 600;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px 12px;
            font-size: 15px;
            border: 1.5px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: #007BFF;
            outline: none;
        }

        textarea {
            resize: vertical;
            height: 80px;
        }

        .checkbox-group {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .checkbox-group label {
            font-weight: 500;
        }

        button {
            width: 100%;
            background-color: #007BFF;
            border: none;
            padding: 12px;
            color: white;
            font-size: 16px;
            font-weight: 700;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .info {
            text-align: center;
            color: green;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Software</h2>

        <% String msg = request.getParameter("msg"); %>
        <% if (msg != null) { %>
            <div class="info"><%= msg %></div>
        <% } %>

        <form action="SoftwareServlet" method="post">
            <div class="form-group">
                <label for="name">Software Name</label>
                <input type="text" id="name" name="name" required />
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" required></textarea>
            </div>

            <div class="form-group">
                <label>Access Levels</label>
                <div class="checkbox-group">
                    <label><input type="checkbox" name="accessLevels" value="Read" /> Read</label>
                    <label><input type="checkbox" name="accessLevels" value="Write" /> Write</label>
                    <label><input type="checkbox" name="accessLevels" value="Admin" /> Admin</label>
                </div>
            </div>

            <button type="submit">Add Software</button>
        </form>
    </div>
</body>
</html>
