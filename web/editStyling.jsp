<%--
  Created by IntelliJ IDEA.
  User: vwen239
  Date: 23/01/2018
  Time: 11:57 AM
  To change this template use File | Settings | File Templates.
--%>
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

    <title>Log In to VRM</title>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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

    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script>
        function onSubmit() {
            document.getElementById('signupform').submit();
        }
    </script>



</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand">Hello ${personLoggedIn}!</a>
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
                <li class="nav-item">
                    <a class="nav-link" href="Articles">Explore</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="myArticles">My Articles</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="editprofile">My Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Main?logout_button=Logout">Log Out</a>
                </li>
                <li class="nav-item">
                    <i class="glyphicon glyphicon-search" style="color: white;"
                       data-toggle="modal" data-target="#searchbar"></i>
                </li>
            </ul>
        </div>

    </div>
</nav>

<!-- Page Header -->
<header id="backgroundImage" class="masthead" style="background-image: url('img/background02.jpg');">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto">
                <div class="page-heading" style="margin-top: 15%; padding-top: 5%">
                    <div class="panel-title"><h3>Edit Article</h3></div>
                    <div style="float:right; font-size: 85%; position: relative; top:-1%;">
                        <%--<a style="color: red" &lt;%&ndash;id="signinlink" href="/Signin"&ndash;%&gt;>--%>
                            Edit your article below
                        <%--</a>--%>
                    </div>
                    <div style="padding-top:30px" class="panel-body">
                        <form action="/editArticles" method="POST">
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" id="title" name="title" class="form-control" value="${articleToEdit.getTitle()}" required>
                            </div>
                            <div class="form-group">
                                <label for="summernote">Content</label>
                                <textarea id="summernote" name="content" class="form-control" rows="10" required>${articleToEdit.getContent()}</textarea>
                                <label for ="futureDate">Change date published (optional)</label>
                                <input type="date" id="futureDate" name="futureDate" value="new Date()">
                            </div>
                            <div class="form-group">
                                <input type="hidden" name="articleID" value="${articleToEdit.getArticleID()}">
                                <input type="hidden" name="author" value="${articleToEdit.getUsername()}">
                                <input type="hidden" name="operation" value="userHasEditedArticle">
                                <input type="hidden" name="publishedDate" value="${articleToEdit.getDate()}">
                                <%--<input type="hidden" name="dateInDatabse" value="${article}">--%>

                                <button type="submit" class="btn btn-primary">Done</button>
                            </div>


                        </form>
                        <form class="form-inline" action="/OneArticles" method="POST">

                            <input type="hidden" name="operation" value="delete">
                            <input type="hidden" name="articleId" value="${articleToEdit.getArticleID()}">
                            <button style="float: right" type="submit" class="btn btn-danger pull-right">
                                Delete
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<%@include file="footer.jsp" %>

</body>
</html>
