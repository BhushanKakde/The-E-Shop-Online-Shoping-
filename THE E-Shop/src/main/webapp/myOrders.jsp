<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DAO"%>
<%@include file="header.jsp" %>
<%@include file="footer.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Orders</title>
<style>
  table {
    width: 100%;
    border-collapse: collapse;
  }
  th, td {
    padding: 10px;
    text-align: left;
    border: 1px solid #ddd;
  }
  th {
    background-color: #f4f4f4;
  }
</style>
</head>
<body>
<div style="color: white; text-align: center; font-size: 30px;">My Orders</div>
<table>
    <thead>
        <tr>
            <th>S.No</th>
            <th>Product Name</th>
            <th>Category</th>
            <th><i class="fa fa-inr"></i> Price</th>
            <th>Quantity</th>
            <th><i class="fa fa-inr"></i> Sub Total</th>
            <th>Order Date</th>
            <th>Expected Delivery Date</th>
            <th>Payment Method</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
<%
int sno = 0;
try (Connection con = DAO.getCon();
     Statement st = con.createStatement();
     ResultSet rs = st.executeQuery("SELECT cart.id AS cart_id, cart.quantity, cart.subtotal, cart.orderDate, " +
                                    "cart.deliveryDate, cart.paymentMethod, cart.status, product.name AS product_name, " +
                                    "product.category, product.price " +
                                    "FROM cart " +
                                    "INNER JOIN product ON cart.product_id = product.id " +
                                    "WHERE cart.email = '" + email + "' AND cart.orderDate IS NOT NULL;")) {
    while (rs.next()) {
        sno++;
%>
        <tr>
            <td><%= sno %></td>
            <td><%= rs.getString("product_name") %></td>
            <td><%= rs.getString("category") %></td>
            <td><i class="fa fa-inr"></i><%= rs.getString("price") %></td>
            <td><%= rs.getString("quantity") %></td>
            <td><i class="fa fa-inr"></i><%= rs.getString("subtotal") %></td>
            <td><%= rs.getString("orderDate") %></td>
            <td><%= rs.getString("deliveryDate") %></td>
            <td><%= rs.getString("paymentMethod") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>
    </tbody>
</table>
</body>
</html>
