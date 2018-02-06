<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<% response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1--%>
<%--response.setHeader("Pragma", "no-cache"); //HTTP 1.0--%>
<%--response.setDateHeader("Expires", 0); //prevents caching at the proxy server %>--%>

<c:if test="${sessionScope.personLoggedIn != null}">
    <c:redirect url="Welcome"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


    <title>VRM Blog</title>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"><link rel="icon" type="image/png" href="img/vrmlogo.png" />



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
    <script type="text/javascript">
        var imageCollection = [
            "background01.jpg", "background02.jpg", "background03.jpg", "background04.jpg", "background05.jpg", "background06.jpg", "background07.jpg", "background08.jpg", "background09.jpg", "background10.jpg", "background11.jpg", "background13.jpg", "background14.jpg", "background15.jpg", "background16.jpg", "background17.jpg", "background18.jpg", "background19.jpg", "background20.jpg", "background21.jpg", "background22.jpg", "background23.jpg", "background24.jpg"
        ];

        function loadRandomImage() {
            var numImage = Math.floor(Math.random() * (imageCollection.length));
            $('#backgroundImage').css('background-image', 'url(img/' + imageCollection[numImage] + ')');
            console.log(imageCollection[numImage]);
        }

        $(document).ready(function () {
            loadRandomImage();
        });


    </script>
</head>
<body style="background-color: #e6e6e6">
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand">VRM Travel Blog</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">Menu

        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="contact">Contact</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<header id="backgroundImage" class="masthead">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto">
                <div class="page-heading">
                    <h1>Welcome to VRM</h1>
                    <span class="subheading">By the travellers, for the travellers. Make every heartbeat count.</span>
                    <br>
                    <div class="col-sm-12 col-md-12 controls">
                        <div style="margin-top:1%" class="form-group">
                            <button style="margin: 1%; padding-left: 4.5%; padding-right: 4.5%; opacity: 0.8; color: lightgrey"
                                    class="btn btn-default btn-responsive"
                                    type="button"><a style="color:black; " href="Signin"> Login</a>
                            </button>
                            <button style="margin: 1%; opacity: 0.8; color: lightgrey"
                                    class="btn btn-default btn-responsive"
                                    type="button"><a style="color:black; " href="Signuppage"> Sign Up </a>
                            </button>
                            <button style="margin: 1%; opacity: 0.8; color: lightgrey"
                                    class="btn btn-danger btn-responsive"
                                    type="button"><a style="color:white; " href="Articles"> Explore</a>
                            </button>
                        </div>
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