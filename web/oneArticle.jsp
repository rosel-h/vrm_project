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
            $(document).ready(function () {
                loadRandomImage();
                $('#loadedContent img').css("max-width", "90%");
                $('#loadedContent img').css("height", "auto");
            });
        });
    </script>

</head>
<body style="background-color: #e6e6e6">
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div id="top" class="container">
        <a class="navbar-brand" href="Welcome">Welcome ${sessionScope.get("personLoggedIn")}</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">Menu

        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">

                    <a class="nav-link" href="javascript:window.history.back()">back</a>
                </li>
                <c:if test="${sessionScope.personLoggedIn !=null}">
                    <li class="nav-item">
                        <a class="nav-link" href="Welcome">Home</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<header id="backgroundImage" class="masthead">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 col-sm-12 mx-auto" id="headingID">
                <div class="page-heading" style="margin: 10%; padding: 10%">
                    <h2>${articleToLoad.getTitle()}</h2>
                    <span class="meta">Posted by ${articleToLoad.getUsername()} on ${articleToLoad.getDate()}</span>
                </div>
            </div>
        </div>
    </div>
</header>

<article>
    <div class="container">
        <div class="row">
            <%--Article content--%>
            <div id="loadedContent" class="col-lg-12 col-md-12 form-control">
                <c:if test="${articleToLoad.userIsInactive()}">
                    <p><i>The user who wrote this article is <b><u>inactive</u></b></i></p>
                </c:if>
                ${articleToLoad.getContent()}
            </div>
        </div>
        <div class="row" style="float: right">
            <c:if test="${sessionScope.personLoggedIn == articleToLoad.getUsername()}">
            <div class="btn-group btn-group-justified col-lg-12 col-md-12 float-right" role="group">
                <div style="padding: 1%; margin: 2%">
                    <form class="form-inline" action="OneArticle" method="POST">
                        <input type="hidden" name="operation" value="delete">
                        <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                        <input type="hidden" id="csrfToken1" name="csrfToken"
                               value="${sessionScope.get("csrfSessionToken")}">
                        <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                data-target="#article${articleToLoad.getArticleID()}">Delete
                        </button>

                        <!-- Modal of delete article button -->
                        <div class="modal fade" id="article${articleToLoad.getArticleID()}" role="dialog">
                            <div class="modal-dialog modal-sm">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h6 class="modal-title">Are you sure you want to delete the article?</h6>
                                    </div>
                                    <div class="modal-body">
                                        <button type="submit" class="btn btn-danger float-left">Delete</button>
                                        <button type="button" class="btn btn-default float-right" data-dismiss="modal">
                                            Cancel
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                </div>

                <div style="padding: 1%; margin: 2%">
                        <%-- Allows you to edit the article --%>
                    <form class="form-inline" action="editArticles" method="post">
                        <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                        <input type="hidden" name="operation" value="goToEditPage">
                        <input type="hidden" name="author" value="${sessionScope.personLoggedIn}">
                        <input type="hidden" id="csrfToken2" name="csrfToken"
                               value="${sessionScope.get("csrfSessionToken")}">
                        <button id="editorButton" type="submit" class="btn btn-primary pull-right">Edit
                        </button>
                    </form>
                </div>
            </div>
        </div>
        </c:if>
    </div>


    </div>


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
                        <h5 class="" style="display: inline-block">&nbsp;
                            <c:choose>
                                <c:when test="${commentList.userIsInactive()}">
                                    <span style="color: lightsteelblue" data-toggle="tooltip"
                                          title="inactive user">(${commentList.getCommentAuthor()})</span>
                                </c:when>
                                <c:otherwise>
                                    ${commentList.getCommentAuthor()}
                                </c:otherwise>
                            </c:choose>
                            <small><i>Posted on ${commentList.getDatePublished()}</i></small>
                        </h5>

                        <c:if test="${sessionScope.personLoggedIn !=null}">
                            <small id="replyToThis${commentList.getCommentID()}"
                                   style="display: inline-block;">&nbsp;
                                <ins style="cursor: pointer;"><strong>Reply
                                    >></strong></ins>
                            </small>

                        </c:if>
                    </div>

                    <p>${commentList.getContent()}</p>
                        <%--allow to delete comment if user is logged in--%>
                    <c:if test="${(articleToLoad.getUsername()==sessionScope.personLoggedIn) ||( sessionScope.personLoggedIn == commentList.getCommentAuthor())}">
                        <form method="post" action="OneArticle">
                            <input type="hidden" name="operation" value="deleteCommentOnArticle">
                            <input type="hidden" name="articleID" value="${articleToLoad.getArticleID()}">
                            <input type="hidden" name="commentID" value="${commentList.getCommentID()}">
                            <input type="hidden" id="csrfToken3" name="csrfToken"
                                   value="${sessionScope.get("csrfSessionToken")}">

                            <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                    data-target="#comment${commentList.getCommentID()}">delete comment
                            </button>

                            <!-- Modal for the delete comment -->
                            <div class="modal fade" id="comment${commentList.getCommentID()}" role="dialog">
                                <div class="modal-dialog modal-sm">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h6 class="modal-title">Are you sure?</h6>
                                        </div>
                                        <div class="modal-body">
                                            <button type="submit" class="btn btn-danger float-left">Delete</button>
                                            <button type="button" class="btn btn-default float-right"
                                                    data-dismiss="modal">Cancel
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </form>
                    </c:if>

                    <c:if test="${sessionScope.personLoggedIn !=null}">

                        <div id="replyBox${commentList.getCommentID()}" style="display: none">
                            <form method="post" action="OneArticle">
                                <div class="form-group">
                                    <label for="summernote" style="font-size: x-small">Reply to comment
                                        as ${sessionScope.personLoggedIn}:</label>
                                    <textarea name="newComment" class="form-control" rows="3" required></textarea>
                                    <input type="hidden" name="userWhoCommented" value="${sessionScope.personLoggedIn}">
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
                        <c:forEach var="children" items="${commentList.getChildren()}">
                            <div class="nested" style="padding-left: 10%">
                                <hr>
                                <div class="row">
                                    <img src="avatars/${children.getAvatarIcon()}" class=""
                                         style="height: 30px; width:30px; display: inline-block">
                                    <h5 class="" style="display: inline-block">&nbsp;
                                        <c:choose>
                                            <c:when test="${children.userIsInactive()}">
                                                <span style="color: lightsteelblue" data-toggle="tooltip"
                                                      title="inactive user">(${children.getCommentAuthor()})</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${children.getCommentAuthor()}
                                            </c:otherwise>
                                        </c:choose>
                                        <small><i>Posted on ${children.getDatePublished()}</i></small>
                                    </h5>
                                    <c:if test="${sessionScope.personLoggedIn !=null}">
                                        <small id="replyToThis${children.getCommentID()}"
                                               style="display: inline-block;">&nbsp;
                                            <ins style="cursor: pointer;">
                                                <strong>Reply >></strong></ins>
                                        </small>

                                    </c:if>
                                </div>
                                <p>${children.getContent()}</p>

                                <c:if test="${sessionScope.personLoggedIn !=null}">
                                    <div id="replyBox${children.getCommentID()}" style="display: none">
                                        <form method="post" action="OneArticle">
                                            <div class="form-group">
                                                <label for="summernote" style="font-size: x-small">Reply to comment
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
                                        <input type="hidden" name="operation" value="deleteCommentOnArticle">
                                        <input type="hidden" name="articleID"
                                               value="${articleToLoad.getArticleID()}">
                                        <input type="hidden" name="commentID" value="${children.getCommentID()}">
                                        <input type="hidden" id="csrfToken6" name="csrfToken"
                                               value="${sessionScope.get("csrfSessionToken")}">
                                        <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                                data-target="#mychid${children.getCommentID()}">delete comment
                                        </button>

                                        <!-- Modal -->
                                        <div class="modal fade" id="mychid${children.getCommentID()}" role="dialog">
                                            <div class="modal-dialog modal-sm">
                                                <!-- Modal content-->
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h6 class="modal-title">Are you sure?</h6>
                                                    </div>
                                                    <div class="modal-body">
                                                        <button type="submit" class="btn btn-danger float-left">Delete
                                                        </button>
                                                        <button type="button" class="btn btn-default float-right"
                                                                data-dismiss="modal">Cancel
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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


<%@include file="footer.jsp" %>
</body>
</html>
