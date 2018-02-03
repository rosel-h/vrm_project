<%@ page import="DAO_setup.Article" %><%--
  Created by IntelliJ IDEA.
  User: Rose
  Date: 29/01/2018
  Time: 10:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Index"/>
</c:if>

<html>
<head>
    <title>Revising Article: ${articleToEdit.getTitle()}</title>
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
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <!-- include summernote css/js -->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>

    <%--<script>--%>
    <%--$(document).ready(function () {--%>
    <%--$('#summernote').summernote();--%>
    <%--});--%>

    <%--$('.note-toolbar .note-fontsize, .note-toolbar .note-color, .note-toolbar .note-para .dropdown-menu li:first, .note-icon-link , .note-toolbar .note-line-height ').remove();--%>
    <%--</script>--%>
    <script>
        $(document).ready(function () {
            $('#summernote').summernote({
                toolbar: [
                    // [groupName, [list of button]]
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['strikethrough', 'superscript', 'subscript']],
                    ['fontsize', ['fontsize']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                    ['insert', ['picture']]
                ]
            });
        });
    </script>
</head>
<body>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%--<%--%>
<%--String id = request.getParameter("articleID");--%>
<%--String articleStory = request.getParameter("articleContent");--%>
<%--String author= request.getParameter("author");--%>
<%--String articleTitle= request.getParameter("articleTitle");--%>
<%--System.out.println("editArticle jsp: "+ author);--%>
<%--System.out.println("editArticle jsp: "+ articleTitle);--%>
<%--System.out.println("editArticle jsp: "+ articleStory);--%>

<%--%>--%>
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
<header id="backgroundImage" class="masthead" style="background-image: url('img/home-bg.jpg');">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto" id="headingID">
                <div class="post-heading">
                    <h1>${articleToEdit.getUsername()}, edit your article below</h1>
                    <%--<h2 class="subheading">Problems look mighty small from 150 miles up</h2>--%>
                    <span class="meta">Originally posted on ${articleToEdit.getDate()}</span>
                </div>
                <%--<div class="page-heading" style="margin: 0; padding: 10% 0 0 0;">--%>
                    <%--<div class="panel-title"><h3>Hello, ${articleToEdit.getUsername()}. Edit your article below</h3>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--&lt;%&ndash;<div>Hello, ${articleToEdit.getUsername()}. Edit your article below</div>&ndash;%&gt;--%>
                <%--<!--  A form letting users add new articles. -->--%>
                <%--<div class="page-item">--%>
                    <%--<div class="panel-body">--%>
                        <%--<form action="/editArticles" method="POST">--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="title" style="color: white">Title</label>--%>
                                <%--<input type="text" id="title" name="title" class="form-control"--%>
                                       <%--value="${articleToEdit.getTitle()}" required>--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<label for="summernote" style="color: white">Content</label>--%>
                                <%--<textarea id="summernote" name="content" class="form-control" rows="10"--%>
                                          <%--required>${articleToEdit.getContent()}</textarea>--%>
                                <%--<label for="futureDate" style="color: white">Change date published (optional)</label>--%>
                                <%--<input type="date" id="futureDate" name="futureDate" value="new Date()">--%>
                            <%--</div>--%>
                            <%--<div class="form-group">--%>
                                <%--<input type="hidden" name="articleID" value="${articleToEdit.getArticleID()}">--%>
                                <%--<input type="hidden" name="author" value="${articleToEdit.getUsername()}">--%>
                                <%--<input type="hidden" name="operation" value="userHasEditedArticle">--%>
                                <%--<input type="hidden" name="publishedDate" value="${articleToEdit.getDate()}">--%>
                                <%--&lt;%&ndash;<input type="hidden" name="dateInDatabse" value="${article}">&ndash;%&gt;--%>

                                <%--<button type="submit" class="btn btn-primary">Done</button>--%>
                            <%--</div>--%>


                        <%--</form>--%>
                        <%--<form class="form-inline" action="/OneArticles" method="POST">--%>

                            <%--<input type="hidden" name="operation" value="delete">--%>
                            <%--<input type="hidden" name="articleId" value="${articleToEdit.getArticleID()}">--%>
                            <%--<button style="float: right" type="submit" class="btn btn-danger pull-right">--%>
                                <%--Delete--%>
                            <%--</button>--%>
                        <%--</form>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            </div>
        </div>
    </div>
</header>

<article>
<div class="container">
    <%--<div>Hello, ${articleToEdit.getUsername()}. Edit your article below</div>--%>
    <!--  A form letting users add new articles. -->
    <div class="">

        <div class="">
            <h3 class="post-title">Edit Article
            <form class="form-inline" action="/OneArticles" method="POST" style="display: inline-block; float: right;">

                <input type="hidden" name="operation" value="delete">
                <input type="hidden" name="articleId" value="${articleToEdit.getArticleID()}">
                <button style="float: right" type="submit" class="btn btn-danger pull-right">
                    Delete
                </button>
            </form>
            </h3>
        </div>
        <div class="">
            <form action="/editArticles" method="POST" style="float: right">
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" class="form-control" value="${articleToEdit.getTitle()}"
                           required>
                </div>
                <div class="form-group">
                    <label for="summernote">Content</label>
                    <textarea id="summernote" name="content" class="form-control" rows="10"
                              required>${articleToEdit.getContent()}</textarea>
                    <label for="futureDate">Change date published (optional)</label>
                    <input type="date" id="futureDate" name="futureDate" value="new Date()">
                </div>
                <div class="form-group">
                    <input type="hidden" name="articleID" value="${articleToEdit.getArticleID()}">
                    <input type="hidden" name="author" value="${articleToEdit.getUsername()}">
                    <input type="hidden" name="operation" value="userHasEditedArticle">
                    <input type="hidden" name="publishedDate" value="${articleToEdit.getDate()}">
                    <%--<input type="hidden" name="dateInDatabse" value="${article}">--%>

                    <button type="submit" class="btn btn-primary float-right">Done</button>
                </div>


            </form>
           
        </div>
    </div>
</div>
</article>
</body>
</html>

