<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/signup-style.css">
    <title>Login</title>
</head>
<body>
<div id='container'>
    <div class='signup'>
        <form action="LoginAction.jsp" method="post">
            <input type="email" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <input type="submit" value="Login">
        </form>
        <h2><a href="signup.jsp">SignUp</a></h2>
        <h2><a href="forgotPassword.jsp">Forgot Password?</a></h2>
    </div>
    <div class='whysignLogin'>
        <%
            String msg = request.getParameter("msg");
            if ("notexist".equals(msg)) {
        %>
            <h1>Incorrect Username or Password</h1>
        <% 
            } else if ("invalid".equals(msg)) { 
        %>
            <h1>Something Went Wrong! Try Again!</h1>
        <% } %>
        <h2>Online Shopping</h2>
        <p>The Online Shopping System is an application that allows users to shop online without visiting physical stores.</p>
    </div>
</div>
</body>
</html>
