<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server %>

<c:if test="${sessionScope.personLoggedIn != null}">
    <c:redirect url="Welcome"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Welcome to VRM</title>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
          rel='stylesheet' type='text/css'>
    <!-- Custom styles for this template -->
    <link href="vendor/css/clean-blog.min.css" rel="stylesheet">
    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Custom scripts for this template -->
    <script src="vendor/js/clean-blog.min.js"></script>

</head>
<body>

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
                    <a class="nav-link" href="about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="mailto:vrm@vrm.com">Contact</a>
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
                <div class="page-heading">
                    <h1>Welcome to VRM</h1>
                    <span class="subheading">By the travellers, for the travellers. Make every heartbeat count.</span>
                    <br>
                    <div class="btn-group btn-group-justified col-xs-10" role="group"
                         style="padding: 1%">
                        <div style="padding: 1%;margin: 1%">
                            <a href="Signin" class="btn btn-default"
                               style=" background-color: white; opacity: 0.6">
                                <span class="glyphicon glyphicon-circle-arrow-right"
                                      aria-hidden="true"> &nbsp;Login</span>
                            </a>
                        </div>
                        <div style="padding: 1%;margin: 1%">
                            <a href="Signuppage" class="btn btn-default"
                               style=" background-color: white; opacity: 0.6">
                                <span> &nbsp;Sign Up</span>
                            </a>
                        </div>
                        <div style="padding: 1%;margin: 1%">
                            <a href="Articles" class="btn btn-danger"
                               style=" color: white;opacity: 0.8">
                                <span class="glyphicon glyphicon-circle-arrow-right"
                                      aria-hidden="true"> &nbsp;Explore</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<%@include file="footer.jsp" %>

</body>
</html>