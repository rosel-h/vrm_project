<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 22/01/2018
  Time: 4:05 PM
  To change this template use File | Settings | File Templates.
  This lists all the article published so far. No login needed
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<%@ page import ="DAO_setup" %>--%>
<html>
<head>
    <title>VRM Explore(in JSP)</title>
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

    <script>
        $(document).ready(function () {
            $('#summernote').summernote();
        });

        $('.note-toolbar .note-fontsize, .note-toolbar .note-color, .note-toolbar .note-para .dropdown-menu li:first, .note-icon-link , .note-toolbar .note-line-height ').remove();
    </script>
    <script>
        $(document).ready(function () {
            $('#wOther').summernote({
                minHeight: 20
            });

        });




        $('.note-toolbar .note-fontsize, .note-toolbar .note-color, .note-toolbar .note-para .dropdown-menu li:first, .note-icon-link , .note-toolbar .note-line-height ').remove();
    </script>
</head>
<body>
<%@include file="navigation.jsp" %>
<%--Load articles --%>
<div class="container">
    <h1>All Articles</h1>
    <div style="float: right">
        <c:if test="${personLoggedIn !=null}">
            <div>Logged in as ${personLoggedIn} <img src="avatars/${personAvatarIcon}" style="height: 30px"
                                                     alt="avatar"/>
            </div>
        </c:if>
        <c:if test="${personLoggedIn ==null}">
            <div>Logged in as Guest</div>
        </c:if>
    </div>
    <table class="table table-striped">
        <thead>
        <tr>
            <th><a href="">Title</a><img src="" alt="icon"/></th>
            <th><a href="">Author</a><img src="" alt="icon"/></th>
            <th><a href="">Date Published</a><img src="" alt="icon"/></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="articleList" items="${articleList}">
            <%--<div class="panel panel-warning"> <b>${articleList.getTitle()}</b> by <i>${articleList.getUsername()}</i>--%>
            <%--<button style="float: right;" type="button" class="btn btn-sm" data-toggle="modal"--%>
            <%--data-target="#a${articleList.getArticleID()}">Full Article--%>
            <%--</button>--%>
            <%--</div>--%>
            <tr>
                <td><b>${articleList.getTitle()}</b></td>
                <td><i>${articleList.getUsername()}</i></td>
                <td>${articleList.getDate()}</td>
                <td>
                    <button style="float: right;" type="button" class="btn btn-sm" data-toggle="modal"
                            data-target="#a${articleList.getArticleID()}">Full Article
                    </button>
                </td>
            </tr>


            <!-- Modal -->
            <div class="modal fade" id="a${articleList.getArticleID()}" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">${articleList.getTitle()}</h4>
                            <div>Written by ${articleList.getUsername()}, published
                                on ${articleList.getDate()}</div>
                            <c:if test="${personLoggedIn == articleList.getUsername()}">
                                <form class="form-inline" action="/Articles" method="POST">
                                    <button style="float: right" type="submit" class="btn btn-danger pull-right">
                                        Delete
                                    </button>
                                    <input type="hidden" name="operation" value="delete">
                                    <input type="hidden" name="articleId" value="${articleList.getArticleID()}">
                                </form>
                                <%--<form class="form-inline" action="/Articles" method="POST">--%>
                                <button style="float: right" id="editorButton" type="button"
                                        class="btn btn-primary pull-right">Edit
                                </button>

                                <script>
                                    $(document).ready(function(){
                                        $("#editorButton").click(function(){
                                            $("#editorDiv").toggle();
                                        });
                                    });
                                </script>
                                <%--to hide--%>
                                <br>
                                <br>
                                <br>
                                <div id="editorDiv" style="display: none">

                                    <form  method="post" action="/CreateArticles">

                                <textarea id="wOther" rows ="20" name="editordata">
                                    test obe
                                </textarea>
                                        <input type="submit">
                                    </form>
                                </div>
                                <%----%>
                                <%--</form>--%>
                            </c:if>

                        </div>
                        <div class="modal-body">

                            <div>${articleList.getContent()}</div>
                        </div>

                        <div class="media panel-footer">

                            <div class=""><p>Comments</p></div>
                                <%--first comments--%>
                            <c:forEach var="commentList" items="${commentList}">
                                <c:if test="${articleList.getArticleID()==commentList.getArticleID()}">
                                    <%--avatar icon--%>
                                    <div class="media-left">
                                        <img src="avatars/${commentList.getAvatarIcon()}" class="media-object"
                                             style="width:30px">
                                    </div>
                                    <div class="media-body">
                                        <h5 class="media-heading">${commentList.getCommentAuthor()}
                                            <small><i>Posted on ${commentList.getDatePublished()}</i></small>
                                        </h5>
                                        <p>${commentList.getContent()}</p>
                                            <%--second nest comments--%>
                                        <c:forEach var="nestedList" items="${nestedList}">
                                            <c:if test="${nestedList.getParentID()==commentList.getCommentID()}">
                                                <div class="media-left">
                                                    <img src="avatars/${nestedList.getAvatarIcon()}"
                                                         class="media-object"
                                                         style="width:30px">
                                                </div>
                                                <div class="media-body">
                                                    <h5 class="media-heading">${nestedList.getCommentAuthor()}
                                                        <small><i>Posted on ${nestedList.getDatePublished()}</i></small>
                                                    </h5>
                                                    <p>${nestedList.getContent()}</p>
                                                </div>
                                                <br>
                                            </c:if>
                                        </c:forEach>
                                            <%-- checks wether user logged in with author of post and user logged in--%>
                                        <c:if test="${(articleList.getUsername()==personLoggedIn) ||( personLoggedIn == commentList.getCommentAuthor())}">
                                            <form method="post" action="/Articles">
                                                <button type="submit" class="btn btn-xs">delete comment</button>
                                                <input type="hidden" name="operation" value="deleteCommentOnArticle">
                                                <input type="hidden" name="commentID"
                                                       value="${commentList.getCommentID()}">

                                            </form>
                                        </c:if>
                                    </div>
                                    <br>
                                </c:if>

                            </c:forEach>
                            <c:if test="${personLoggedIn !=null}">
                                <form method="post" action="/Articles">
                                    <div class="form-group">
                                        <label for="summernote">Comment as ${personLoggedIn}:</label>
                                            <%--<textarea class="form-control" rows="3" name="newComment" id="newComment"--%>
                                            <%--style="max-width: 100%; min-width: 100%;" required></textarea>--%>
                                            <%--<div class="form-group">--%>
                                        <label for="summernote">Content</label>
                                        <textarea id="summernote" name="newComment" class="form-control" rows="10"
                                                  required></textarea>
                                            <%--</div>--%>
                                        <input type="hidden" name="userWhoCommented" value="${personLoggedIn}">
                                        <input type="hidden" name="operation" value="commentOnArticle">
                                        <input type="hidden" name="articleID" value="${articleList.getArticleID()}">
                                        <button style="float: right" type="submit" class="btn btn-sm">Post a comment
                                        </button>
                                    </div>
                                </form>
                            </c:if>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

        </c:forEach>
        </tbody>
    </table>

</div>


</body>
</html>