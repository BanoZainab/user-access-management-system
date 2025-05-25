
USER ACCESS MANAGEMENT SYSTEM



# Project Description

This is a web-based application developed using Java Servlets, JSP, and PostgreSQL that allows:

- Employees to sign up and request access to software applications.
- Managers to log in , view and approve/reject those requests.
- Admins to log in and add new software to the system.

# Technologies Used

- Java (Servlets & JSP)
- Apache Tomcat
- PostgreSQL Database
- HTML/CSS
- JDBC

# Project Structure

# Java Servlets

- SignUpServlet.java – Handles user sign-up.
- LoginServlet.java – Manages user login and session.
- SoftwareServlet.java – Allows Admins to add a new software to the system.
- RequestServlet.java – Processes access requests from Employees.
- ApprovalServlet.java – Allows Managers to approve/reject requests.

# JSP Pages

- index.html – Entry point to choose login or signup.
- signup.jsp – Sign-up form for new employees.
- login.jsp – Login form for all users.
- createSoftware.jsp – Admin interface to add new software.
- requestAccess.jsp – Employees request access to software.
- pendingRequests.jsp – Managers view and take action on pending requests(either accept or reject).

# SQL Scripts

sql/schema.sql – PostgreSQL script to create the database and all necessary tables:
   -users
   -software
   -requests


# Database Tables

## 1. users
Columns:
 - id(Primary Key, Auto-Increment)
 - username(Text, Unique)
 - password(Text)
 - role(Text: Employee, Manager, Admin)

## 2. software
Columns:
 - id(Primary Key, Auto-Increment)
 - name(Text)
 - description (Text)
 - access_levels (Text: Read, Write, Admin)

## 3. requests
Columns:
 - id(Primary Key, Auto-Increment)
 - user_id(Foreign Key referencing users)
 - software_id (Foreign Key referencing software)
 - access_type (Text: Read, Write, Admin)
 - reason(Text)
 - status(Text: Pending, Approved, Rejected)

# Setup Instructions

# Prerequisites

- Java JDK
- Apache Tomcat
- PostgreSQL
- NetBeans or any Java IDE

# Contact

For any queries contact: zainabbano0512@gmail.com

