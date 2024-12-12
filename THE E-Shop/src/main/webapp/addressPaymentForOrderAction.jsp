<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Confirmation</title>
</head>
<body>
<%
String email = session.getAttribute("email").toString();
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String country = request.getParameter("country");
String mobileNumber = request.getParameter("mobileNumber");
String paymentMethod = request.getParameter("paymentMethod");
String transactionId = request.getParameter("transactionId");

String status = "bill";

try {
    Connection con = DAO.getCon();
    
    // Update user profile with the new address, city, state, country, and mobile number
    PreparedStatement pst = con.prepareStatement("UPDATE users SET address=?, city=?, state=?, country=?, mobileNumber=? WHERE email=?");
    pst.setString(1, address);
    pst.setString(2, city);
    pst.setString(3, state);
    pst.setString(4, country);
    pst.setString(5, mobileNumber);
    pst.setString(6, email);
    
    int ii = pst.executeUpdate();
    
    // Update cart details with the new information and set the order status
    PreparedStatement pst1 = con.prepareStatement("UPDATE cart SET address=?, city=?, state=?, country=?, mobileNumber=?, orderDate=NOW(), deliveryDate=DATE_ADD(orderDate, INTERVAL 7 DAY), paymentMethod=?, transactionId=?, status=? WHERE email=? AND address IS NULL");
    pst1.setString(1, address);
    pst1.setString(2, city);
    pst1.setString(3, state);
    pst1.setString(4, country);
    pst1.setString(5, mobileNumber);
    pst1.setString(6, paymentMethod);
    pst1.setString(7, transactionId);
    pst1.setString(8, status);
    pst1.setString(9, email);
    
    int ii1 = pst1.executeUpdate();
    
    // Generate the bill (send details to admin for processing)
    String billDetails = "New Order from " + email + ":\n" +
                         "Address: " + address + "\n" +
                         "City: " + city + "\n" +
                         "State: " + state + "\n" +
                         "Country: " + country + "\n" +
                         "Mobile: " + mobileNumber + "\n" +
                         "Payment Method: " + paymentMethod + "\n" +
                         "Transaction ID: " + transactionId + "\n";

    // Send the bill details to admin (For simplicity, using System.out.println in this example)
    // You should replace this with actual email sending logic
    System.out.println("Admin Notification: \n" + billDetails);
    
    // Redirect to the bill page after successful update
    response.sendRedirect("bill.jsp");

} catch (Exception e) {
    e.printStackTrace();
}
%>
</body>
</html>
