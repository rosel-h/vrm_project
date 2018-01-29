<%--
  Created by IntelliJ IDEA.
  User: Vince
  Date: 29/01/2018
  Time: 3:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link href="css/clean-blog.min.css" rel="stylesheet">
    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Custom scripts for this template -->
    <script src="js/clean-blog.min.js"></script>

</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand">Welcome Guest</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">Menu
            <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="welcome.jsp">Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<header class="masthead" style="background-image: url('img/background01.jpg')">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto">
                <div class="page-heading">
                    <h5>Get started by logging in or signing up</h5>
                    <br>
                    <div class="btn-group btn-group-justified col-xs-10" role="group"
                         style="padding-left: 30%; padding-right: 15%">
                        <a href="signup.jsp">
                            <div class="btn-group" role="group" style="padding: 4%">
                                <button type="button" class="btn btn-default"
                                        style="background-color: white; opacity: 0.6"
                                        data-toggle="modal" data-target="#newArticles"
                                        data-backdrop="static" data-keyboard="false">
                                    <span class="glyphicon glyphicon-circle-arrow-right"
                                          aria-hidden="true">&nbsp;Sign Up</span>
                                </button>
                            </div>
                        </a>
                        <a href="login.jsp">
                            <div class="btn-group" role="group" style="padding: 4%">
                                <button type="button" class="btn btn-default"
                                        style="background-color: white; opacity: 0.6"
                                        data-toggle="modal" data-target="#myArticles">
                                    <span class="glyphicon glyphicon-send" aria-hidden="true">&nbsp;Log In</span>
                                </button>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
</header>
</body>
</html>
