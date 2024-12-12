<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DAO"%>

<%
try {
    // Get the database connection
    Connection con = DAO.getCon();

    // Define SQL queries to create tables
    String createAdminUsersTable = "CREATE TABLE IF NOT EXISTS admin_users (" +
                                   "id INT AUTO_INCREMENT PRIMARY KEY, " +
                                   "email VARCHAR(100) UNIQUE, " +
                                   "password VARCHAR(255), " +
                                   "name VARCHAR(100), " +
                                   "role VARCHAR(50))"; // admin role (e.g. admin, superadmin)

    String createUsersTable = "CREATE TABLE IF NOT EXISTS users (" +
                              "id INT AUTO_INCREMENT PRIMARY KEY, " +
                              "name VARCHAR(30), " +
                              "email VARCHAR(35) UNIQUE, " +
                              "mobileNumber BIGINT, " +
                              "securityQuestion VARCHAR(100), " +
                              "answer VARCHAR(100), " +
                              "password VARCHAR(255), " +
                              "address VARCHAR(100), " +
                              "city VARCHAR(100), " +
                              "state VARCHAR(100), " +
                              "country VARCHAR(100))";

    String createProductTable = "CREATE TABLE IF NOT EXISTS product (" +
                                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                                "name VARCHAR(200), " +
                                "category VARCHAR(100), " +
                                "price INT, " +
                                "active VARCHAR(10))";

    String createCartTable = "CREATE TABLE IF NOT EXISTS cart (" +
                             "cart_id INT AUTO_INCREMENT PRIMARY KEY, " +
                             "email VARCHAR(100), " +
                             "product_id INT, " +
                             "quantity INT, " +
                             "price INT, " +
                             "total INT, " +
                             "address VARCHAR(500), " +
                             "city VARCHAR(50), " +
                             "state VARCHAR(100), " +
                             "country VARCHAR(100), " +
                             "mobileNumber BIGINT, " +
                             "orderDate VARCHAR(100), " +
                             "deliveryDate VARCHAR(100), " +
                             "paymentMethod VARCHAR(100), " +
                             "transactionId VARCHAR(100), " +
                             "status VARCHAR(10))";

    String createMessageTable = "CREATE TABLE IF NOT EXISTS message (" +
                                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                                "email VARCHAR(100), " +
                                "subject VARCHAR(200), " +
                                "body VARCHAR(1000))";

    // Execute the queries to create tables
    PreparedStatement pst1 = con.prepareStatement(createAdminUsersTable);
    PreparedStatement pst2 = con.prepareStatement(createUsersTable);
    PreparedStatement pst3 = con.prepareStatement(createProductTable);
    PreparedStatement pst4 = con.prepareStatement(createCartTable);
    PreparedStatement pst5 = con.prepareStatement(createMessageTable);

    pst1.execute();
    pst2.execute();
    pst3.execute();
    pst4.execute();
    pst5.execute();

    out.println("All tables have been successfully created.");
    System.out.println("All tables have been successfully created.");

    // Close the connection
    con.close();
} catch (Exception e) {
    e.printStackTrace();
    out.println("Error occurred while creating tables: " + e.getMessage());
}
%>
