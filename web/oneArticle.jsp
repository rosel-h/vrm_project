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
<!DOCTYPE html>
<html>
<head>
    <title>${articleToLoad.getTitle()}</title>
    <meta charset="UTF-8">

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
<%--<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1--%>
<%--response.setHeader("Pragma", "no-cache"); //HTTP 1.0--%>
<%--response.setDateHeader("Expires", 0); //prevents caching at the proxy server--%>
<%--%>--%>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div id="top" class="container">
        <a class="navbar-brand" href="Welcome">Welcome ${sessionScope.get("personLoggedIn")}</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">Menu
            <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <%--<li class="nav-item">--%>
                <%--<a class="nav-link" href="Welcome">Home</a>--%>
                <%--</li>--%>
                    <li class="nav-item">
                        <a class="nav-link" href="Welcome">Home</a>
                    </li>
                <li class="nav-item">
                    <%--<a class="nav-link" href="Welcome">Home</a>--%>
                    <a class="nav-link" href="javascript:window.history.back()">back</a>
                </li>
                <%--<li class="nav-item">--%>
                <%--<a class="nav-link" href="Articles">Community</a>--%>
                <%--</li>--%>
                <c:if test="${sessionScope.personLoggedIn !=null}">
                    <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="myArticles">My Articles</a>--%>
                    <%--</li>--%>
                    <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="editprofile">My Profile</a>--%>
                    <%--</li>--%>
                </c:if>
                <%--<li class="nav-item">--%>
                <%--<a class="nav-link" href="about">About</a>--%>
                <%--</li>--%>
                <c:choose>
                    <c:when test="${sessionScope.personLoggedIn !=null}">
                        <%--<li class="nav-item">--%>
                        <%--<a class="nav-link" href="Main?logout_button=Logout">Log Out</a>--%>
                        <%--</li>--%>
                    </c:when>
                    <c:otherwise>
                        <%--<li class="nav-item">--%>
                        <%--<a href="Signin" class="btn btn-default">--%>
                        <%--<span class="glyphicon glyphicon-circle-arrow-right"--%>
                        <%--aria-hidden="true"> &nbsp;Login</span>--%>
                        <%--</a>--%>
                        <%--</li>--%>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>

</nav>

<header id="backgroundImage" class="masthead">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto" id="headingID">
                <div class="page-heading" style="margin: 15% 0 5%; padding: 1% 0 0 0;">
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
        <div class="row" style="border: solid; border-width: 1px; border-color: grey; margin: 1%">
            <div class="col-lg-8 col-md-10 mx-auto">
                ${articleToLoad.getContent()}
            </div>

        </div>
        <div class="row" style="float: right;">
            <c:if test="${personLoggedIn == articleToLoad.getUsername()}">
            <div class="btn-group btn-group-justified col-xs-10" role="group">
                <div style="padding: 1%; margin: 1%">
                    <form class="form-inline" action="OneArticle" method="POST">
                        <input type="hidden" name="operation" value="delete">
                        <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                        <input type="hidden" id="csrfToken1" name="csrfToken"
                               value="${sessionScope.get("csrfSessionToken")}">
                        <button style="float: right" type="submit" class="btn btn-danger pull-right">
                            Delete
                        </button>
                    </form>
                </div>
                <div style="padding: 1%; margin: 1%">
                        <%--<form class="form-inline" action="/Articles" method="POST">--%>
                    <form class="form-inline" action="editArticles" method="post">
                        <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                        <input type="hidden" name="operation" value="goToEditPage">
                        <input type="hidden" name="author" value="${sessionScope.personLoggedIn}">
                        <input type="hidden" id="csrfToken2" name="csrfToken"
                               value="${sessionScope.get("csrfSessionToken")}">
                        <button style="float: right" id="editorButton" type="submit"
                                class="btn btn-primary pull-right">Edit
                        </button>
                    </form>
                </div>
            </div>
        </div>
        </c:if>
    </div>
    <br>

    <div class="container">
        <p style="font-weight: bold">Comments</p>
        <%--first comments--%>
        <c:forEach var="commentList" items="${commentList}">
            <c:if test="${articleToLoad.getArticleID()==commentList.getArticleID() }">
                <div class="">
                    <hr>
                    <div class="row">
                        <img src="avatars/${commentList.getAvatarIcon()}" class=""
                             style="height: 30px; width:30px; display: inline-block">
                        <h5 class="" style="display: inline-block">&nbsp;${commentList.getCommentAuthor()}
                            <small><i>Posted on ${commentList.getDatePublished()}</i></small>
                        </h5>

                        <c:if test="${sessionScope.personLoggedIn !=null}">
                            <small id="replyToThis${commentList.getCommentID()}"
                                   style="display: inline-block;">&nbsp;<ins style="cursor: pointer;"><strong>Reply >></strong></ins>
                            </small>

                        </c:if>
                    </div>

                    <p>${commentList.getContent()}</p>
                        <%--delete comment if user is logged in--%>
                    <c:if test="${(articleToLoad.getUsername()==personLoggedIn) ||( personLoggedIn == commentList.getCommentAuthor())}">
                        <form method="post" action="OneArticle">
                            <button type="submit" class="btn btn-xs btn-danger">delete comment</button>
                            <input type="hidden" name="operation" value="deleteCommentOnArticle">
                            <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                            <input type="hidden" name="commentID" value="${commentList.getCommentID()}">
                            <input type="hidden" id="csrfToken3" name="csrfToken"
                                   value="${sessionScope.get("csrfSessionToken")}">
                        </form>
                    </c:if>

                    <c:if test="${sessionScope.personLoggedIn !=null}">

                        <%--<small id="replyToThis${commentList.getCommentID()}"--%>
                               <%--style="display: inline-block;">--%>
                            <%--<button class="btn btn-xs btn-default">Reply</button>--%>
                        <%--</small>--%>

                        <div id="replyBox${commentList.getCommentID()}" style="display: none">
                            <form method="post" action="OneArticle">
                                <div class="form-group">
                                    <label for="summernote" style="font-size: x-small">Comment
                                        as ${sessionScope.personLoggedIn}:</label>
                                    <textarea name="newComment" class="form-control" rows="3"
                                              required></textarea>
                                    <input type="hidden" name="userWhoCommented"
                                           value="${sessionScope.personLoggedIn}">
                                    <input type="hidden" name="operation" value="replyToAComment">
                                    <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                                    <input type="hidden" name="fatherComment" value="${commentList.getCommentID()}">
                                    <input type="hidden" id="csrfToken4" name="csrfToken"
                                           value="${sessionScope.get("csrfSessionToken")}">
                                    <button style="float: right; margin: 1%" type="submit"
                                            class="btn btn-xs btn-success">Reply
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
                                <hr>
                                <div class="row">
                                <img src="avatars/${children.getAvatarIcon()}" class=""
                                     style="height: 30px; width:30px; display: inline-block">
                                <h5 class="" style="display: inline-block">&nbsp;${children.getCommentAuthor()}
                                    <small><i>Posted on ${children.getDatePublished()}</i></small>
                                </h5>
                                    <c:if test="${sessionScope.personLoggedIn !=null}">
                                        <small id="replyToThis${children.getCommentID()}"
                                               style="display: inline-block;">&nbsp;<ins style="cursor: pointer;"><strong>Reply >></strong></ins>
                                        </small>

                                    </c:if>
                                </div>
                                <p>${children.getContent()}</p>

                                <c:if test="${sessionScope.personLoggedIn !=null}">
<%--                                    <small id="replyToThis${children.getCommentID()}"
                                           style="display: inline-block;">Reply
                                    </small>--%>
                                    <div id="replyBox${children.getCommentID()}" style="display: none">
                                        <form method="post" action="OneArticle">
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
                                                <input type="hidden" id="csrfToken5" name="csrfToken"
                                                       value="${sessionScope.get("csrfSessionToken")}">
                                                <button style="float: right; margin: 1%" type="submit"
                                                        class="btn btn-sm btn-success">Reply
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </c:if>
                                <c:if test="${(articleToLoad.getUsername()==sessionScope.personLoggedIn) ||( sessionScope.personLoggedIn == children.getCommentAuthor())}">
                                    <form method="post" action="OneArticle">
                                        <button type="submit" class="btn btn-xs btn-danger">delete comment
                                        </button>
                                        <input type="hidden" name="operation" value="deleteCommentOnArticle">
                                        <input type="hidden" name="articleID"
                                               value="${articleToLoad.getArticleID()}">
                                        <input type="hidden" name="commentID" value="${children.getCommentID()}">
                                        <input type="hidden" id="csrfToken6" name="csrfToken"
                                               value="${sessionScope.get("csrfSessionToken")}">
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
        <c:if test="${sessionScope.personLoggedIn !=null}">
            <form method="post" action="OneArticle">
                <div class="form-group">
                    <label for="summernote" style="font-size: 14px">Comment as ${sessionScope.personLoggedIn}:</label>
                    <textarea id="summernote" name="newComment" class="form-control" rows="10"
                              required></textarea>
                    <input type="hidden" name="userWhoCommented" value="${sessionScope.personLoggedIn}">
                    <input type="hidden" name="operation" value="commentOnArticle">
                    <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                    <input type="hidden" id="csrfToken" name="csrfToken"
                           value="${sessionScope.get("csrfSessionToken")}">
                    <button style="float: right;margin: 1%; padding: 1%" type="submit" class="btn btn-sm btn-primary">
                        Post a comment
                    </button>
                </div>
            </form>
        </c:if>
    </div>

</article>

<br>
<%@include file="footer.jsp" %>
</body>
</html>
