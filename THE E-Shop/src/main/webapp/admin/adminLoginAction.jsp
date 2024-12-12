<%@ page import="Model.DAO"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
        response.sendRedirect("adminLogin.jsp?msg=invalid");
    } else {
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            // Get database connection
            con = DAO.getCon();

            // Query to match admin email
            String query = "SELECT * FROM admin_users WHERE email = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, email);

            rs = pst.executeQuery();

            if (rs.next()) {
                // Assuming passwords are hashed (use proper hashing mechanism like bcrypt in production)
                String storedPasswordHash = rs.getString("password");
                
                // Check if the password matches the stored hash (use a proper hashing mechanism here)
                if (password.equals(storedPasswordHash)) {
                    // If the email and password match, set session and redirect
                    session.setAttribute("admin", email);
                    response.sendRedirect("adminWelcome.jsp"); // Redirect to admin page
                } else {
                    // If the password is incorrect
                    response.sendRedirect("adminLogin.jsp?msg=invalid");
                }
            } else {
                // If the email does not exist
                response.sendRedirect("adminLogin.jsp?msg=invalid");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminLogin.jsp?msg=invalid"); // Redirect to login page with error message
        } finally {
            // Close database resources to prevent memory leaks
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
