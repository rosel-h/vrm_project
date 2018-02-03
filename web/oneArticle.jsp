<%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 2/02/2018
  Time: 11:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${articleToLoad.getTitle()}</title>

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


</head>
<body>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand">Welcome ${sessionScope.personLoggedIn}</a>
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
                <c:if test="${sessionScope.personLoggedIn !=null}">
                <li class="nav-item">
                    <a class="nav-link" href="myArticles">My Articles</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="editprofile">My Profile</a>
                </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="about">About</a>
                </li>
                <c:choose>
                    <c:when test="${sessionScope.personLoggedIn !=null}">
                        <li class="nav-item">
                            <a class="nav-link" href="Main?logout_button=Logout">Log Out</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a href="Signin" class="btn btn-default">
                                <span class="glyphicon glyphicon-circle-arrow-right"
                                      aria-hidden="true"> &nbsp;Login</span>
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <li class="nav-item">
                    <i class="glyphicon glyphicon-search" style="color: white;"
                       data-toggle="modal" data-target="#searchbar"></i>
                </li>
            </ul>
        </div>

    </div>

</nav>

<div <%--class="container"--%>>
    <header class="masthead" style="background-image: url('img/background03.jpg')">
        <div class="overlay"></div>
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-10 mx-auto">
                    <div class="post-heading">
                        <h1>${articleToLoad.getTitle()}</h1>
                        <%--<h2 class="subheading">Problems look mighty small from 150 miles up</h2>--%>
                        <span class="meta">Posted by ${articleToLoad.getUsername()} on ${articleToLoad.getDate()}</span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <%--<h1 class="post-title">${articleToLoad.getTitle()}</h1>--%>
    <%--<div>Posted by ${articleToLoad.getUsername()}</div>--%>
    <%--<div>Published on ${articleToLoad.getDate()}</div>--%>

    <article>
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-10 mx-auto">
                    ${articleToLoad.getContent()}
                </div>

            </div>
            <div class="row" style="float: right;">
                <c:if test="${personLoggedIn == articleToLoad.getUsername()}">
                    <form class="form-inline" action="OneArticle" method="POST">

                        <input type="hidden" name="operation" value="delete">
                        <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                        <button style="float: right" type="submit" class="btn btn-danger pull-right">
                            Delete
                        </button>
                    </form>
                    <%--<form class="form-inline" action="/Articles" method="POST">--%>
                    <form class="form-inline" action="editArticles" method="post">

                        <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">

                        <input type="hidden" name="operation" value="goToEditPage">
                        <input type="hidden" name="author" value="${sessionScope.personLoggedIn}">
                        <button style="float: right" id="editorButton" type="submit"
                                class="btn btn-primary pull-right">Edit
                        </button>
                    </form>

                </c:if>
            </div>
            <br>

            <div>
                <p>Comments</p>
                <%--first comments--%>
                <c:forEach var="commentList" items="${commentList}">
                    <c:if test="${articleToLoad.getArticleID()==commentList.getArticleID() }">
                        <div class="">
                            <img src="avatars/${commentList.getAvatarIcon()}" class=""
                                 style="width:30px; display: inline-block">
                            <h5 class="" style="display: inline-block">${commentList.getCommentAuthor()}
                                <small><i>Posted on ${commentList.getDatePublished()}</i></small>
                            </h5>
                            <p>${commentList.getContent()}</p>
                                <%--delete comment if user is logged in--%>
                            <c:if test="${(articleToLoad.getUsername()==personLoggedIn) ||( personLoggedIn == commentList.getCommentAuthor())}">
                                <form method="post" action="/OneArticle">
                                    <button type="submit" class="btn btn-xs btn-transparent">delete comment</button>
                                    <input type="hidden" name="operation" value="deleteCommentOnArticle">
                                    <input type="hidden" name="articleID" value="${articleToEdit.getArticleID()}">
                                    <input type="hidden" name="commentID" value="${commentList.getCommentID()}">
                                </form>
                            </c:if>
                            <c:if test="${personLoggedIn !=null}">
                                <small id="replyToThis${commentList.getCommentID()}"
                                       style="display: inline-block;">Reply
                                </small>
                                <div id="replyBox${commentList.getCommentID()}" style="display: none">
                                    <form method="post" action="/OneArticle">
                                        <div class="form-group">
                                            <label for="summernote" style="font-size: x-small">Comment
                                                as ${sessionScope.personLoggedIn}:</label>
                                            <textarea name="newComment" class="form-control" rows="3"
                                                      required></textarea>
                                            <input type="hidden" name="userWhoCommented" value="${sessionScope.personLoggedIn}">
                                            <input type="hidden" name="operation" value="replyToAComment">
                                            <input type="hidden" name="articleID"
                                                   value="${articleToLoad.getArticleID()}">
                                            <input type="hidden" name="fatherComment"
                                                   value="${commentList.getCommentID()}">
                                            <button style="float: right" type="submit"
                                                    class="btn btn-sm btn-transparent">Reply
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </c:if>
                            <script>
                                $(document).ready(function () {
                                    $("#replyToThis${commentList.getCommentID()}").click(function () {
                                        $("#replyBox${commentList.getCommentID()}").toggle();
                                    });
                                });
                            </script>
                                <%--nested comment second degree--%>
                            <c:if test="${commentList.hasChildren()}">

                                <%--<% System.out.println("in children");%>--%>

                                <c:forEach var="children" items="${commentList.getChildren()}">
                                    <%--<%System.out.println("in for loop");%>--%>
                                    <div class="nested" style="padding-left: 10%">
                                        <img src="avatars/${children.getAvatarIcon()}" class=""
                                             style="width:30px; display: inline-block">
                                        <h5 class="" style="display: inline-block">${children.getCommentAuthor()}
                                            <small><i>Posted on ${children.getDatePublished()}</i></small>
                                        </h5>
                                        <p>${children.getContent()}</p>

                                        <c:if test="${personLoggedIn !=null}">
                                            <small id="replyToThis${children.getCommentID()}"
                                                   style="display: inline-block;">Reply
                                            </small>
                                            <div id="replyBox${children.getCommentID()}" style="display: none">
                                                <form method="post" action="/OneArticle">
                                                    <div class="form-group">
                                                        <label for="summernote" style="font-size: x-small">Comment
                                                            as ${sessionScope.personLoggedIn}:</label>
                                                        <textarea name="newComment" class="form-control" rows="3"
                                                                  required></textarea>
                                                        <input type="hidden" name="userWhoCommented"
                                                               value="${sessionScope.personLoggedIn}">
                                                        <input type="hidden" name="operation" value="replyToAComment">
                                                        <input type="hidden" name="articleID"
                                                               value="${articleToLoad.getArticleID()}">
                                                        <input type="hidden" name="fatherComment"
                                                               value="${children.getParentCommentID()}">
                                                        <button style="float: right" type="submit"
                                                                class="btn btn-sm btn-transparent">Reply
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </c:if>
                                        <c:if test="${(articleToLoad.getUsername()==personLoggedIn) ||( personLoggedIn == commentList.getCommentAuthor())}">
                                            <form method="post" action="/OneArticle">
                                                <button type="submit" class="btn btn-xs btn-transparent">delete comment</button>
                                                <input type="hidden" name="operation" value="deleteCommentOnArticle">
                                                <input type="hidden" name="articleID" value="${articleToEdit.getArticleID()}">
                                                <input type="hidden" name="commentID" value="${commentList.getCommentID()}">
                                            </form>
                                        </c:if>
                                    </div>
                                    <script>
                                        $(document).ready(function () {
                                            $("#replyToThis${children.getCommentID()}").click(function () {
                                                $("#replyBox${children.getCommentID()}").toggle();
                                            });
                                        });
                                    </script>
                                </c:forEach>
                            </c:if>

                        </div>
                        <br>
                    </c:if>
                </c:forEach>
                <c:if test="${personLoggedIn !=null}">
                    <form method="post" action="/OneArticle">
                        <div class="form-group">
                            <label for="summernote">Comment as ${sessionScope.personLoggedIn}:</label>
                            <textarea id="summernote" name="newComment" class="form-control" rows="10"
                                      required></textarea>
                            <input type="hidden" name="userWhoCommented" value="${sessionScope.personLoggedIn}">
                            <input type="hidden" name="operation" value="commentOnArticle">
                            <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                            <button style="float: right" type="submit" class="btn btn-sm btn-transparent">Post a comment
                            </button>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
    </article>
</div>
<%--<div>end</div>--%>
<br>
</div>
</body>
</html>
