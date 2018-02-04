<%--
  Created by IntelliJ IDEA.
  User: vwen239
  Date: 23/01/2018
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Index"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Welcome to VRM Blog</title>

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

    <style type="text/css">
        .clear {
            overflow: hidden;
            clear: both;
            width: 0px;
            height: 0px;
        }

        .imgbox {
            width: 100%;
            margin: 0 auto;
            text-align: center;
        }

        ul {
            padding: 0px;
            margin: 0px;
        }

        ul li {
            float: left;
            list-style: none;
        }

        ul li.select {
            display: block;
        }

        .imgnum span {
            border-radius: 10px;
            color: #FFF;
            margin-left: 5px;
            padding: 3px 6px 3px 6px;
            background-color: black;
            opacity: 0.8;
            cursor: pointer;
        }

        .imgnum span.onselect {
            background-color: #F00;
        }

        .imgnum {
            text-align: center;
            float: right;
            margin: -30px 30px;
            position: relative;
        }

        .imgbox > ul, .imgbox > .imgnum {
            width: 100%;
        }

    </style>
    <style type="text/css">
        #headingID > form {
            width: 100%;
        }

    </style>

    <style>
        @media (max-width: 991px) {
            .btn-group{
                display: block;
            }
        }
    </style>

    <script type="text/javascript">
        var imageCollection = [
            "background01.jpg",
            "background02.jpg",
            "background03.jpg",
            "background04.jpg",
            "background05.jpg",
            "background06.jpg",
            "background07.jpg",
            "background08.jpg",
            "background09.jpg",
            "background10.jpg",
            "background11.jpg",
            "background13.jpg", "background14.jpg", "background15.jpg", "background16.jpg", "background17.jpg", "background18.jpg", "background19.jpg", "background20.jpg", "background21.jpg", "background22.jpg", "background23.jpg", "background24.jpg"
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
        <a class="navbar-brand">Welcome ${sessionScope.get("personLoggedIn")}</a>
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
                    <a class="nav-link" href="editprofile">My Profile</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="Main?logout_button=Logout">Log Out</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<header id="backgroundImage" class="masthead">
    <div class="overlay"></div>
    <div class="container"><div class="row">
        <div class="col-lg-8 col-md-10 mx-auto" id="headingID">
            <div class="page-heading" style="margin: 15% 0 5%; padding: 1% 0 0 0;">
                    <div class=" col-lg-4 col-4 col-md-4 col-sm-4 offset-4">
                        <img src="avatars/${user.getAvatar_icon()}" alt="avatar" style="border-radius: 50%;padding-top: 10%"
                             class="img-fluid">
                    </div>
                    <span class="subheading">By the travellers, for the travellers. Make every heartbeat count.</span>
                    <div class="btn-group btn-group-justified col-xs-10" role="group"
                         style="padding: 1%">
                        <div style="padding: 1%;margin: 1%">
                            <a href="myArticles" class="btn btn-default btn-responsive"
                               style=" background-color: white; opacity: 0.8">
                                My Articles
                            </a>
                        </div>
                        <div style="padding: 1%;margin: 1%">
                            <a href="Articles" class="btn btn-default btn-responsive"
                               style=" background-color: white; opacity: 0.8">
                                Community
                            </a>
                        </div>
                        <div style="padding: 1%;margin: 1%">
                            <a href="NewArticle" class="btn btn-danger btn-responsive"
                               style=" color: white;opacity: 0.8">
                                New Article
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
            <div class="page-heading">
                <h1 style="text-align: center">Featured Articles</h1>
                <br>
            </div>
        </div>
    </div>
</div>

<%--this is code for fade in fade out effect of featured articles--%>
<div class="container">
    <div class="row">
        <div class="imgbox col-lg-8 col-md-10 col-xs-12 mx-auto">
            <ul id="banner_img" style="max-width: 100%; float: left;">
                <li>
                    <div id="banner-1">
                        <a href="OneArticle?articleID=56">
                            <img src="img/banner01.jpg" class="img-responsive" id="bannerimg-1"
                                 style="display: block; max-width: 100%; height: auto"/></a>
                    </div>
                </li>
                <li>
                    <div id="banner-2">
                        <a href="OneArticle?articleID=57">
                            <img src="img/banner01.jpg" class="img-responsive" id="bannerimg-2"
                                 style="display: block; max-width: 100%; height: auto"/></a>
                    </div>
                </li>
                <li>
                    <div id="banner-3">
                        <a href="OneArticle?articleID=58">
                            <img src="img/banner01.jpg" class="img-responsive" id="bannerimg-3"
                                 style="display: block; max-width: 100%; height: auto"/></a>
                    </div>
                </li>
                <li>
                    <div id="banner-4">
                        <a href="OneArticle?articleID=59">
                            <img src="img/banner01.jpg" class="img-responsive" id="bannerimg-4"
                                 style="display: block; max-width: 100%; height: auto"/></a>
                    </div>
                </li>
                <li>
                    <div id="banner-5">
                        <a href="OneArticle?articleID=60">
                            <img src="img/banner01.jpg" class="img-responsive" id="bannerimg-5"
                                 style="display: block; max-width: 100%; height: auto"/></a>
                    </div>
                </li>
            </ul>

            <div class="clear"></div>

            <div class="imgnum" style="max-width: 100%; float: right">
                <span class="onselect">1</span>
                <span>2</span>
                <span>3</span>
                <span>4</span>
                <span>5</span>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>

</body>
</html>