<%@ page import="java.time.LocalDate" %>
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
    <!-- include sorting by title, username, date -->
    <script>
        $(document).on('click', 'th', function () {
            var table = $(this).parents('table').eq(0);
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()));
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }
            table.children('tbody').empty().html(rows);
        });
        function comparer(index) {
            return function (a, b) {
                var valA = getCellValue(a, index), valB = getCellValue(b, index);
                return $.isNumeric(valA) && $.isNumeric(valB) ?
                    valA - valB : valA.localeCompare(valB);
            };
        }
        function getCellValue(row, index) {
            return $(row).children('td').eq(index).text();
        }
    </script>


</head>
<body>

<c:choose>
    <c:when test="${personLoggedIn !=null}">
    <%@include file="navigation.jsp" %>
    </c:when>
    <c:otherwise>
        <%@include file="test.jsp" %>
    </c:otherwise>
</c:choose>
<%--Load articles --%>
<div class="container">
    <h1>All Articles</h1>
    <div style="float: right">
        <c:if test="${personLoggedIn !=null}">
            <div>Logged in as ${personLoggedIn} <a href="editprofile"> <img src="avatars/${avatarFile}"
                                                                            style="height: 30px"
                                                                            alt="avatar"/></a>
            </div>
        </c:if>
        <c:if test="${personLoggedIn ==null}">
            <div>Logged in as Guest</div>
        </c:if>
    </div>
    <table class="table table-striped sorttable" id="articletable">
        <thead>
        <tr>
            <th class="sort-alpha" style="color: #0085a1">
                <ins>Title<span class="glyphicon glyphicon-sort">&nbsp;</span></ins>
            </th>
            <th class="sort-alpha" style="color: #0085a1">
                <ins>Author<span class="glyphicon glyphicon-sort">&nbsp;</span></ins>
            </th>
            <th class="sort-alpha" style="color: #0085a1">
                <ins>Date Published<span class="glyphicon glyphicon-sort">&nbsp;</span></ins>
            </th>
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
            <%
                java.sql.Date sqlDateToday = java.sql.Date.valueOf(LocalDate.now());
                request.setAttribute("sqlDateToday", sqlDateToday);
            %>
            <c:if test="${!articleList.dateIsGreaterThan(sqlDateToday)}">
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
                    <div class="modal-dialog modal-lg" style="width: 100%">
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
                                    <form class="form-inline" action="/editArticles" method="post">

                                        <input type="hidden" name="articleID" value="${articleList.getArticleID()}">

                                        <input type="hidden" name="operation" value="goToEditPage">
                                        <input type="hidden" name="author" value="${personLoggedIn}">
                                        <button style="float: right" id="editorButton" type="submit"
                                                class="btn btn-primary pull-right">Edit
                                        </button>
                                    </form>

                                </c:if>

                            </div>
                            <div class="modal-body">

                                <div>${articleList.getContent()}</div>
                            </div>

                            <div class="panel-footer">

                                <div class=""><p>Comments</p></div>
                                    <%--first comments--%>
                                <c:forEach var="commentList" items="${commentList}">
                                    <c:if test="${articleList.getArticleID()==commentList.getArticleID()}">
                                        <%--avatar icon--%>

                                        <div class=""><img src="avatars/${commentList.getAvatarIcon()}" class=""
                                                           style="width:30px; display: inline-block">
                                            <h5 class="">${commentList.getCommentAuthor()}
                                                <small><i>Posted on ${commentList.getDatePublished()}</i></small>
                                            </h5>
                                            <p>${commentList.getContent()}</p>
                                                <%--&lt;%&ndash;second nest comments&ndash;%&gt;--%>
                                                <%--<c:forEach var="nestedList" items="${nestedList}">--%>
                                                <%--<c:if test="${nestedList.getParentID()==commentList.getCommentID()}">--%>
                                                <%--<div class="">--%>
                                                <%--<img src="avatars/${nestedList.getAvatarIcon()}"--%>
                                                <%--class=""--%>
                                                <%--style="width:30px">--%>
                                                <%--</div>--%>
                                                <%--<div class="">--%>
                                                <%--<h5 class="">${nestedList.getCommentAuthor()}--%>
                                                <%--<small><i>Posted on ${nestedList.getDatePublished()}</i></small>--%>
                                                <%--</h5>--%>
                                                <%--<p>${nestedList.getContent()}</p>--%>
                                                <%--</div>--%>
                                                <%--<br>--%>
                                                <%--</c:if>--%>
                                                <%--</c:forEach>--%>
                                                <%-- checks wether user logged in with author of post and user logged in--%>
                                            <c:if test="${(articleList.getUsername()==personLoggedIn) ||( personLoggedIn == commentList.getCommentAuthor())}">
                                                <form method="post" action="/Articles">
                                                    <button type="submit" class="btn btn-xs">delete comment</button>
                                                    <input type="hidden" name="operation"
                                                           value="deleteCommentOnArticle">
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
            </c:if>
        </c:forEach>
        </tbody>
    </table>

</div>


</body>
</html>