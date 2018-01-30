<%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 22/01/2018
  Time: 3:49 PM
  To change this template use File | Settings | File Templates.
--%>


<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<nav class="navbar navbar-inverse bg-faded">--%>
    <%--<div class="container-fluid">--%>
        <%--<div class="navbar-header">--%>
            <%--<a class="navbar-brand">VRM</a>--%>
        <%--</div>--%>
        <%--<ul class="nav navbar-nav">--%>
            <%--<li ><a href="welcome.jsp">Home</a></li>--%>
            <%--<li><a href="/Articles">Explore</a></li>--%>
            <%--<li><a href="">My Articles</a></li>--%>
        <%--</ul>--%>
        <%--<ul class="nav navbar-nav navbar-right">--%>
            <%--<li><a href="#">MyAccount</a></li>--%>
            <%--<li><a href="signup.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>--%>
            <%--<li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>--%>
            <%--<li>--%>
                <%--<form method="post" action="Main">--%>
                    <%--<button type="submit" name="logout_button" value="Logout">Log out</button>--%>
                <%--</form>--%>
            <%--</li>--%>
        <%--</ul>--%>
        <%--<form class="navbar-form navbar-left" action="searcharticle">--%>
            <%--<div class="form-group">--%>
                <%--<input type="text" class="form-control" name="keywords" placeholder="Title/Username/Date" id="searchkeyword">--%>
            <%--</div>--%>
            <%--<div class="form-group">--%>
                <%--<select class="form-control" name="searchType" id="searchselect">--%>
                    <%--<option value="title">Title</option>--%>
                    <%--<option value="username">Username</option>--%>
                    <%--<option value="date">Date</option>--%>
                <%--</select>--%>
            <%--</div>--%>
            <%--<button type="submit" class="btn btn-default">Search</button>--%>
        <%--</form>--%>
    <%--</div>--%>
<%--</nav>--%>

<script>
    var searchselect = document.getElementById("searchselect");
    searchselect.addEventListener("change", myFc);
    function myFc() {
        var x = document.getElementById("searchkeyword");
        console.log(searchselect.value());
        if (searchselect.value().eq("date")) {

        }else {

        }
    }
</script>

<script>
    $( function() {
        $( "#datepicker" ).datepicker();
    } );
</script>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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



<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand">Welcome ${personLoggedIn}</a>
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
                <li class="nav-item">
                    <a class="nav-link" href="Articles">Explore</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/myArticles">My Articles</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="myprofile.jsp">My Profile</a>
                </li>
                <li class="nav-item">
                    <form method="post" action="Main">
                        <button class="btn btn-default btn-sm"
                                style="background-color:transparent; border: 1px solid transparent; color: white; padding: 5px 5px; font-size: 16px"
                                type="submit" name="logout_button" value="Logout"> Log Out
                        </button>
                    </form>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<header class="masthead" style="background-image: url('img/background02.jpg')">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto">
                <div class="page-heading">
                    <h5>Explore the community or create a new article</h5>
                    <br>
                    <div class="btn-group btn-group-justified col-xs-10" role="group"
                         style="padding-left: 15%; padding-right: 15%">
                        <a href="/myArticles">
                            <div class="btn-group" role="group" style="padding: 4%">
                                <button type="button" class="btn btn-default"
                                        style="background-color: white; opacity: 0.6"
                                        data-toggle="modal" data-target="#newArticles"
                                        data-backdrop="static" data-keyboard="false">
                                    <span class="glyphicon glyphicon-circle-arrow-right"
                                          aria-hidden="true">&nbsp;My Articles</span>
                                </button>
                            </div>
                        </a>

                        <a href="Articles">
                            <div class="btn-group" role="group" style="padding: 4%">
                                <button type="button" class="btn btn-default"
                                        style="background-color: white; opacity: 0.6"
                                        data-toggle="modal" data-target="#myArticles">
                                    <span class="glyphicon glyphicon-send" aria-hidden="true">&nbsp;Community</span>
                                </button>
                            </div>
                        </a>

                        <a href="newArticle.jsp">
                            <div class="btn-group" role="group" style="padding: 4%">
                                <button type="button" class="btn btn-danger"
                                        style="opacity: 0.8">
                                    <span class="glyphicon glyphicon-globe" aria-hidden="true">&nbsp;New Article</span>
                                </button>
                            </div>
                        </a>

                    </div>
                </div>
            </div>

        </div>
    </div>

</header>
