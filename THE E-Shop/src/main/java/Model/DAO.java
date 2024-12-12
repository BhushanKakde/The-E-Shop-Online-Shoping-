package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Vector;

import javax.sql.rowset.JdbcRowSet;
import javax.sql.rowset.RowSetFactory;
import javax.sql.rowset.RowSetProvider;

public class DAO {

    // Establish database connection
    public static Connection getCon() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Online", "root", "MyBhushan@1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    // Insert user details into the database
    public static int insert(Data d) {
        int res = 0;
        String query = "INSERT INTO users VALUES(?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = DAO.getCon();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, d.getName());
            pst.setString(2, d.getEmail());
            pst.setLong(3, d.getMobileNumber());
            pst.setString(4, d.getSecurityQuestion());
            pst.setString(5, d.getAnswer());
            pst.setString(6, d.getPassword());
            pst.setString(7, d.getAddress());
            pst.setString(8, d.getCity());
            pst.setString(9, d.getState());
            pst.setString(10, d.getCountry());
            res = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    // Validate user credentials
    public static Vector<String> validate() {
        Vector<String> v = new Vector<>();
        try {
            RowSetFactory rsf = RowSetProvider.newFactory();
            try (JdbcRowSet jrs = rsf.createJdbcRowSet()) {
                jrs.setUrl("jdbc:mysql://localhost:3306/online");
                jrs.setUsername("root");
                jrs.setPassword("MyBhushan@1234");
                jrs.setCommand("SELECT email, password FROM users");
                jrs.execute();

                while (jrs.next()) {
                    v.add(jrs.getString("email"));
                    v.add(jrs.getString("password"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return v;
    }

    // Validate user for forgotten password and update password
    public static int forgotPassword(Data d) {
        int res = 0;
        Connection con = null;
        JdbcRowSet jrs = null;
        
        try {
            // Establish connection to the database
            con = DAO.getCon();
            RowSetFactory rsf = RowSetProvider.newFactory();
            jrs = rsf.createJdbcRowSet();
            
            // Set up JdbcRowSet for querying user details
            jrs.setUrl("jdbc:mysql://localhost:3306/online");
            jrs.setUsername("root");
            jrs.setPassword("MyBhushan@1234");
            
            // SQL query to check the user details
            jrs.setCommand("SELECT * FROM users WHERE email=? AND mobileNumber=? AND securityQuestion=? AND answer=?");
            jrs.setString(1, d.getEmail());
            jrs.setLong(2, d.getMobileNumber());
            jrs.setString(3, d.getSecurityQuestion());
            jrs.setString(4, d.getAnswer());
            jrs.execute();
            
            // If user exists and the security question/answer is correct
            if (jrs.next()) {
                System.out.println("User found. Updating password...");

                // Prepare the update query for updating the password
                try (PreparedStatement pst = con.prepareStatement("UPDATE users SET password=? WHERE email=?")) {
                    pst.setString(1, d.getPassword());  // New password
                    pst.setString(2, d.getEmail());     // User's email to identify the record

                    // Execute update and check if the update was successful
                    res = pst.executeUpdate();
                    
                    if (res > 0) {
                        System.out.println("Password updated successfully.");
                        con.commit();  // Commit the transaction
                    } else {
                        System.out.println("Password update failed.");
                    }
                }
            } else {
                System.out.println("User not found or incorrect details provided.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback();  // Rollback transaction in case of failure
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        } finally {
            // Ensure that resources are closed after the operation
            try {
                if (jrs != null) {
                    jrs.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
        return res;  // Return the result of the update operation
    }

    // Generate unique product ID
    public static int productId() {
        int id = 1;
        try {
            RowSetFactory rsf = RowSetProvider.newFactory();
            try (JdbcRowSet jrs = rsf.createJdbcRowSet()) {
                jrs.setUrl("jdbc:mysql://localhost:3306/Online");
                jrs.setUsername("root");
                jrs.setPassword("MyBhushan@1234");
                jrs.setCommand("SELECT MAX(id) FROM product");
                jrs.execute();

                if (jrs.next()) {
                    id = jrs.getInt(1) + 1;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    // Insert product details
    public static int addProduct(Data d) {
        int res = 0;
        String query = "INSERT INTO product VALUES(?,?,?,?,?)";
        try (Connection con = DAO.getCon();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, d.getId());
            pst.setString(2, d.getPname());
            pst.setString(3, d.getCategory());
            pst.setString(4, d.getPrice());
            pst.setString(5, d.getActive());
            res = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    // Fetch product details
    public static Data fetchProduct() {
        Data d = new Data();
        try {
            RowSetFactory rsf = RowSetProvider.newFactory();
            try (JdbcRowSet jrs = rsf.createJdbcRowSet()) {
                jrs.setUrl("jdbc:mysql://localhost:3306/online");
                jrs.setUsername("root");
                jrs.setPassword("MyBhushan@1234");
                jrs.setCommand("SELECT * FROM product");
                jrs.execute();

                if (jrs.next()) {
                    d.setId(jrs.getString("id"));
                    d.setPname(jrs.getString("name"));
                    d.setCategory(jrs.getString("category"));
                    d.setPrice(jrs.getString("price"));
                    d.setActive(jrs.getString("active"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }

    // Edit product
    public static Vector<Data> editProduct() {
        Vector<Data> v = new Vector<>();
        try {
            RowSetFactory rsf = RowSetProvider.newFactory();
            try (JdbcRowSet jrs = rsf.createJdbcRowSet()) {
                jrs.setUrl("jdbc:mysql://localhost:3306/Online");
                jrs.setUsername("root");
                jrs.setPassword("MyBhushan@1234");
                jrs.setCommand("SELECT * FROM product");
                jrs.execute();

                while (jrs.next()) {
                    Data d = new Data();
                    d.setId(jrs.getString("id"));
                    d.setPname(jrs.getString("name"));
                    d.setCategory(jrs.getString("category"));
                    d.setPrice(jrs.getString("price"));
                    d.setActive(jrs.getString("active"));
                    v.add(d);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return v;
    }

    // Update product details
    public static int editUpdate(Data d) {
        int res = 0;
        String query = "UPDATE product SET name=?, category=?, price=?, active=? WHERE id=?";
        try (Connection con = DAO.getCon();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, d.getPname());
            pst.setString(2, d.getCategory());
            pst.setString(3, d.getPrice());
            pst.setString(4, d.getActive());
            pst.setString(5, d.getId());
            res = pst.executeUpdate();

            if ("No".equalsIgnoreCase(d.getActive())) {
                try (PreparedStatement pst2 = con.prepareStatement("DELETE FROM cart WHERE product_id=? AND address IS NULL")) {
                    pst2.setString(1, d.getId());
                    pst2.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }
}
