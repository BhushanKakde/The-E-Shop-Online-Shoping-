<%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/home-style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>The E-Market</title>
</head>
<body>
<header>
    <div class="topnav sticky">
        <h1 class="site-title">The E-Market</h1>
        <div class="user-info">
            <% 
            String email = (String) session.getAttribute("email"); 
            if (email == null) {
                response.sendRedirect("login.jsp"); // Redirect to login if not logged in
                return;
            } 
            %>
            <h2><a href="#"><%= email %> <i class='fas fa-user-alt'></i></a></h2>
        </div>
        <nav>
            <a href="home.jsp">Home <i class="fa fa-institution"></i></a>
            <a href="myCart.jsp">My Cart <i class='fas fa-cart-arrow-down'></i></a>
            <a href="myOrders.jsp">My Orders <i class='fab fa-elementor'></i></a>
            <a href="changeDetails.jsp">Change Details <i class="fa fa-edit"></i></a>
            <a href="messageUs.jsp">Message Us <i class='fas fa-comment-alt'></i></a>
            <a href="about.jsp">About <i class="fa fa-address-book"></i></a>
            <a href="logout.jsp">Logout <i class='fas fa-share-square'></i></a>
        </nav>
        <div class="search-container">
            <form action="searchHome.jsp" method="post">
                <input type="text" placeholder="Search" name="search" aria-label="Search">
                <button type="submit" aria-label="Search"><i class="fa fa-search"></i></button>
            </form>       
        </div>
    </div>
</header>
</body>
</html>
