<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Vector"%>
<%@ page import="Model.DAO"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Login Action</title>
</head>
<body>
<%
    // Retrieve email and password from request parameters
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Ensure email and password are not null
    if (email == null || password == null) {
        response.sendRedirect("login.jsp?msg=empty");
        return;
    }

    try {
        // Check if the credentials match the admin account
        if ("admin@gmail.com".equalsIgnoreCase(email) && "admin".equals(password)) {
            // Admin login successful
            session.setAttribute("email", email);
            response.sendRedirect("admin/adminHome.jsp");
        } else {
            // Validate user credentials using DAO
            Vector<String> userCredentials = DAO.validate();
            boolean isValidUser = false;

            for (int i = 0; i < userCredentials.size(); i += 2) {
                String storedEmail = userCredentials.get(i);
                String storedPassword = userCredentials.get(i + 1);

                if (email.equalsIgnoreCase(storedEmail) && password.equals(storedPassword)) {
                    isValidUser = true;
                    break;
                }
            }

            if (isValidUser) {
                // User login successful
                session.setAttribute("email", email);
                response.sendRedirect("home.jsp");
            } else {
                // Invalid credentials
                response.sendRedirect("login.jsp?msg=notexist");
            }
        }
    } catch (Exception e) {
        // Handle any unexpected errors
        response.sendRedirect("login.jsp?msg=error");
        e.printStackTrace();
    }
%>
</body>
</html>
