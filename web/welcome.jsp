<%--
  Created by IntelliJ IDEA.
  User: vwen239
  Date: 23/01/2018
  Time: 1:26 PM
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

    <script src="jquery.min.js"></script>
    <script src="jquery-ui.min.js"></script>
    <script src="featured.js"></script>

    <script type="text/javascript">
        var time = "";
        var index = 1;
        $(function () {
            showimg(index);
            $(".imgnum span").hover(function () {
                clearTimeout(time);
                var icon = $(this).text();
                $(".imgnum span").removeClass("onselect").eq(icon - 1).addClass("onselect");
                $("#banner_img li").hide().stop(true, true).eq(icon - 1).fadeIn("slow");
            }, function () {
                index = $(this).text() > 4 ? 1 : parseInt($(this).text()) + 1;
                time = setTimeout("showimg(" + index + ")", 3000);
            });
        });

        function showimg(num) {
            index = num;
            $(".imgnum span").removeClass("onselect").eq(index - 1).addClass("onselect");
            $("#banner_img li").hide().stop(true, true).eq(index - 1).fadeIn("slow");
            index = index + 1 > 5 ? 1 : index + 1;
            time = setTimeout("showimg(" + index + ")", 3000);
        }
    </script>
    <style type="text/css">
        .clear {
            overflow: hidden;
            clear: both;
            width: 0px;
            height: 0px;
        }

        .imgbox {
            width: 400px;
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
            background-color: #F90;
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
    </style>

</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand">Welcome ${personLoggedIn}!<%--${requestScope.get()}--%> </a>
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
                    <a class="nav-link" href="aboutus.html">My Articles</a>
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
                            <div class="btn-group" role="group" style="padding: 8%">
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
                            <div class="btn-group" role="group" style="padding: 8%">
                                <button type="button" class="btn btn-default"
                                        style="background-color: white; opacity: 0.6"
                                        data-toggle="modal" data-target="#myArticles">
                                    <span class="glyphicon glyphicon-send" aria-hidden="true">&nbsp;Community</span>
                                </button>
                            </div>
                        </a>

                        <a href="newArticle.jsp">
                            <div class="btn-group" role="group" style="padding: 8%">
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
    </div>
</header>

<div class="container">
    <div class="row">
        <div class="col-lg-8 col-md-10 mx-auto">
            <div class="row">
                <div class="col-lg-8 col-md-10 mx-auto">
                    <div class="page-heading">
                        <h1>Feature Articles</h1>
                        <br>

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<%--this is code for fade in fade out effect of featured articles--%>
<div class="container">
    <div class="imgbox">
        <ul id="banner_img">
            <li><img src="img/fade-banner-01.jpg" width="400" height="200"/></li>
            <li><img src="img/fade-banner-02.jpg" width="400" height="200"/></li>
            <li><img src="img/fade-banner-03.jpg" width="400" height="200"/></li>
            <li><img src="img/fade-banner-04.jpg" width="400" height="200"/></li>
            <li><img src="img/fade-banner-02.jpg" width="400" height="200"/></li>
        </ul>
        <div class="clear"></div>
        <div class="imgnum">
            <span class="onselect">1</span>
            <span>2</span>
            <span>3</span>
            <span>4</span>
            <span>5</span>
        </div>
    </div>
</div>

<div class="container">
    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-10 mx-auto">
                    <hr>
                    <p class="copyright text-muted">Copyright &copy; VRM 2018</p>
                </div>
            </div>
        </div>
    </footer>
</div>
</body>
</html>