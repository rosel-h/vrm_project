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
    <title>Explore Community</title>
    <%--<!-- Latest compiled and minified CSS -->--%>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"--%>
          <%--integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>

    <%--<!-- Optional theme -->--%>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"--%>
          <%--integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">--%>

    <%--<!-- Latest compiled and minified JavaScript -->--%>
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"--%>
            <%--integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"--%>
            <%--crossorigin="anonymous"></script>--%>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">--%>
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>--%>
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
    <%--&lt;%&ndash;<%@include file="RoseTests/allTheThingsInTheHead.jsp" %>&ndash;%&gt;--%>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <%--<title>Welcome to the Community</title>--%>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
          rel='stylesheet' type='text/css'>
    <!-- Custom styles for this template -->
    <link href="vendor/css/clean-blog.min.css" rel="stylesheet">
    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Custom scripts for this template -->
    <script src="vendor/js/clean-blog.min.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/jquery/jquery-ui.min.js"></script>
    <script src="vendor/js/featured.js"></script>

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
                    ['height', ['height']]
                ]
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $('#wOther').summernote({
                minHeight: 20
            });
        });

//        $('.note-toolbar .note-fontsize, .note-toolbar .note-color, .note-toolbar .note-para .dropdown-menu li:first, .note-icon-link , .note-toolbar .note-line-height ').remove();
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
    <c:when test="${sessionScope.personLoggedIn !=null}">
    <%@include file="navigation.jsp" %>
        <%--<%@include file="RoseTests/navbar_only.jsp" %>--%>
    </c:when>
    <c:otherwise>
        <%@include file="guestnavigation.jsp" %>
    </c:otherwise>
</c:choose>
<%--Load articles --%>
<div class="container">
    <div class="row" style="vertical-align: middle">
        <div class="btn-group btn-group-justified col-xs-10" role="group" style="padding: 1%">
        <h1>All Articles &nbsp;</h1>
        </div>
        <div class="btn-group btn-group-justified col-xs-10" role="group" style="padding: 1%">
            <form class="navbar-form navbar-right" action="searcharticle" style="margin: auto;">

                <div class="row">
                    <div class="form-group" style="padding: 1%">
                        <input type="text" class="form-control" name="keywords" placeholder="Title/Username/Date"
                               style="opacity: 0.6"
                               id="searchkeyword">
                    </div>
                    <div class="form-group" style="padding: 1%">
                        <select class="form-control" name="searchType" id="searchselect" style="opacity: 0.6">
                            <option value="title">Title</option>
                            <option value="username">Username</option>
                            <option value="date">Date</option>
                        </select>
                    </div>
                    <div class="form-group" style="padding: 1%">
                        <button type="submit" class="form-control" style="opacity: 0.6">Search</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div style="float: right">
        <c:if test="${personLoggedIn !=null}">
            <div>Logged in as ${personLoggedIn} <a href="editprofile"> <img src="avatars/${user.getAvatar_icon()}"
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
                    <td><h2 class="post-title">${articleList.getTitle()}</h2></td>
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
                                <h3 class="<%--modal-title --%>post-title">${articleList.getTitle()}</h3>
                                <div class="post-meta">Written by ${articleList.getUsername()}, published
                                    on ${articleList.getDate()}</div>
                                <c:if test="${personLoggedIn == articleList.getUsername()}">
                                    <form class="form-inline" action="/Articles" method="POST">
                                        <button style="float: right" type="submit" class="btn btn-danger pull-right">
                                            Delete
                                        </button>
                                        <input type="hidden" name="operation" value="delete">
                                        <input type="hidden" name="articleId" value="${articleList.getArticleID()}">
                                    </form>
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
                                    <c:if test="${articleList.getArticleID()==commentList.getArticleID() }">
                                        <div class="">
                                            <img src="avatars/${commentList.getAvatarIcon()}" class="" style="width:30px; display: inline-block">
                                            <h5 class=""  style="display: inline-block">${commentList.getCommentAuthor()}
                                                <small><i>Posted on ${commentList.getDatePublished()}</i></small>
                                            </h5>
                                            <p>${commentList.getContent()}</p>
                                            <%--delete comment if user is logged in--%>
                                            <c:if test="${(articleList.getUsername()==personLoggedIn) ||( personLoggedIn == commentList.getCommentAuthor())}">
                                                <form method="post" action="/Articles">
                                                    <button type="submit" class="btn btn-xs">delete comment</button>
                                                    <input type="hidden" name="operation"
                                                           value="deleteCommentOnArticle">
                                                    <input type="hidden" name="commentID"
                                                           value="${commentList.getCommentID()}">
                                                </form>
                                            </c:if>
                                            <c:if test="${personLoggedIn !=null}">
                                                <small id="replyToThis${commentList.getCommentID()}">Reply</small>
                                                <div id="replyBox${commentList.getCommentID()}" style="display: none">
                                                    <form method="post" action="/Articles">
                                                        <div class="form-group">
                                                            <label for="summernote" style="font-size: x-small">Comment as ${personLoggedIn}:</label>
                                                            <textarea name="newComment" class="form-control" rows="3"
                                                                      required></textarea>
                                                            <input type="hidden" name="userWhoCommented" value="${personLoggedIn}">
                                                            <input type="hidden" name="operation" value="replyToAComment">
                                                            <input type="hidden" name="articleID" value="${articleList.getArticleID()}">
                                                            <input type="hidden" name="fatherComment" value="${commentList.getCommentID()}">
                                                            <button style="float: right" type="submit" class="btn btn-sm">Reply
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </c:if>
                                            <script>
                                                $(document).ready(function(){
//                                                    $(".replyToThis").click(function(){
//                                                        $(".replyBox").css("display","block");
//                                                    });
//                                                    $(".replyToThis").click(function(){
//                                                        $(".replyBox").css("display","none");
//                                                    });
                                                    $("#replyToThis${commentList.getCommentID()}").click(function(){
                                                        $("#replyBox${commentList.getCommentID()}").toggle();
                                                    });
                                                });
                                            </script>
                                            <%--nested comment second degree--%>
                                            <c:if test="${commentList.hasChildren()}">

                                                <% System.out.println("in children");%>

                                                <c:forEach var="children" items="${commentList.getChildren()}">
                                                    <%System.out.println("in for loop");%>
                                                    <div class="nested" style="padding-left: 10%">
                                                        <img src="avatars/${children.getAvatarIcon()}" class="" style="width:30px; display: inline-block">
                                                        <h5 class="" style="display: inline-block">${children.getCommentAuthor()}
                                                            <small><i>Posted on ${children.getDatePublished()}</i></small>
                                                        </h5>
                                                        <p>${children.getContent()}</p>
                                                    </div>
                                                    <c:if test="${personLoggedIn !=null}">
                                                        <small id="replyToThis${children.getCommentID()}">Reply</small>
                                                        <div id="replyBox${children.getCommentID()}" style="display: none">
                                                            <form method="post" action="/Articles">
                                                                <div class="form-group">
                                                                    <label for="summernote" style="font-size: x-small">Comment as ${personLoggedIn}:</label>
                                                                    <textarea name="newComment" class="form-control" rows="3"
                                                                              required></textarea>
                                                                    <input type="hidden" name="userWhoCommented" value="${personLoggedIn}">
                                                                    <input type="hidden" name="operation" value="replyToAComment">
                                                                    <input type="hidden" name="articleID" value="${articleList.getArticleID()}">
                                                                    <input type="hidden" name="fatherComment" value="${children.getCommentID()}">
                                                                    <button style="float: right" type="submit" class="btn btn-sm">Reply
                                                                    </button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </c:if>
                                                    <script>
                                                        $(document).ready(function(){
//                                                    $(".replyToThis").click(function(){
//                                                        $(".replyBox").css("display","block");
//                                                    });
//                                                    $(".replyToThis").click(function(){
//                                                        $(".replyBox").css("display","none");
//                                                    });
                                                            $("#replyToThis${children.getCommentID()}").click(function(){
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
                                    <form method="post" action="/Articles">
                                        <div class="form-group">
                                            <label for="summernote">Comment as ${personLoggedIn}:</label>
                                            <textarea id="summernote" name="newComment" class="form-control" rows="10"
                                                      required></textarea>
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