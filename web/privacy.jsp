<%--
  Created by IntelliJ IDEA.
  User: vwen239
  Date: 23/01/2018
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>About Us</title>
    <%--<!-- Bootstrap core CSS -->--%>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.VRMapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.VRMapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
          rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="vendor/css/clean-blog.min.css" rel="stylesheet">

    <%--<!-- Bootstrap core JavaScript -->--%>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="vendor/js/clean-blog.min.js"></script>
    <script src="vendor/jquery/jquery.js"></script>
    <script src="vendor/jquery/jquery-ui.min.js"></script>
    <script src="vendor/js/featured.js"></script>

</head>
<body style="background-color: #e6e6e6">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand">VRM Travel Blog</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">Menu
            <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="Welcome">Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<header id="backgroundImage" class="masthead" style="background-image: url('img/about-bg.jpg');">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto">
                <div class="page-heading" style="margin: 10% 0 0 0; padding: 0;">
                    <br>
                    <h2>Information we collect</h2>
                    <p>We collect information to provide better services to all of our users – from figuring out basic
                        stuff like which language you speak, to more complex things like which ads
                        you’ll find most useful, the people who matter most
                        to you online, or which YouTube videos you might like.
                    <p><strong>We collect information in the following ways</strong></p>

                    <p><strong>1. Information you give us.</strong></p>
                    <p>For example, many of our services require you to
                        sign
                        up for a VRM Account. When you do, we’ll ask for personal information, like your name, email
                        address, telephone number or credit card to store with your account. If you want to take full
                        advantage of the sharing features we offer, we might also ask you to create a publicly visible
                        VRM Profile, which may include your name and photo.</p>

                    <p><strong>2. Information we get from your use of our services.</strong></p>
                    <p> We collect information
                        about
                        the services that you use and how you use them, like when you watch a video on YouTube, visit a
                        website that uses our advertising services, or view and interact with our ads and content.
                        This information includes:
                    <p><strong>3. Device information</strong></p>
                    <p>
                        We collect device-specific information (such as your hardware model, operating system version,
                        unique device identifiers, and mobile network information including phone number). VRM may
                        associate your device identifiers or phone number with your VRM Account.</p>
                </div>
            </div>
        </div>
    </div>
</header>

<%@include file="footer.jsp" %>

</body>
</html>