<%--
  Created by IntelliJ IDEA.
  User: vwen239
  Date: 23/01/2018
  Time: 11:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<c:if test="${sessionScope.personLoggedIn != null}">
    <c:redirect url="Welcome"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


    <title>Log In to VRM</title>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="img/vrmlogo.png"/>
    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery/jquery.js"></script>
    <script src="vendor/jquery/jquery-ui.min.js"></script>

    <!-- Custom fonts for this template -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
          rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="vendor/css/clean-blog.min.css" rel="stylesheet">
    <!-- Custom scripts for this template -->
    <script src="vendor/js/clean-blog.min.js"></script>
    <script src="vendor/js/featured.js"></script>

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
                    <a class="nav-link" href="Welcome">Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<header id="backgroundImage" class="masthead" style="background-image: url('img/background03.jpg');">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto">
                <div class="page-heading">
                    <div class="panel-title"><h3>Sign In</h3></div>
                    <div style="float:right; font-size: 80%; position: relative; top:-10px">
                        <a style="color: white;" href="passwordreset">Forgot password?</a>
                    </div>
                    <div style="padding-top:30px" class="panel-body">
                        <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                        <form id="loginform" class="form-horizontal" action="Login" method="post">
                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input id="login-username" type="text" class="form-control" name="username" value=""
                                       required="true" placeholder="Username">
                            </div>
                            <div style="margin-bottom: 25px" class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                <input type="password" onfocus="this.value=''" required="true" class="form-control"
                                       name="pass"
                                       placeholder="Password">
                            </div>
                            <div style="color:red">${errorMessage}</div>
                            <div style="margin-top:10px" class="form-group">
                                <div class="col-sm-12 controls">
                                    <button style="color:white; margin: 1%; padding: 1%; opacity: 0.8" id="btn-login"
                                            class="btn btn-success"
                                            type="submit">Sign in
                                    </button>
                                    <button style="color:white; margin: 1%; padding: 1%;opacity: 0.8" id="btn-fblogin"
                                            class="btn btn-primary"
                                            type="button"
                                            onclick="window.location.href='https://www.facebook.com/dialog/oauth?client_id=352195078594245&redirect_uri=https://sporadic.nz/vrmblog/oauth2fb&scope=email'">
                                        Connect via Facebook
                                    </button>
                                </div>
                            </div>
                        </form>
                        <div class="form-group">
                            <div class="col-md-12 control">
                                <div style="border-top: 1px solid#888; padding-top:15px; font-size:85%">
                                    Don't have an account?
                                    <a href="Signuppage" style="color: red">
                                        Sign Up Here
                                    </a>
                                </div>
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
