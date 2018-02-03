<%--
  Created by IntelliJ IDEA.
  User: Mengjie
  Date: 2018/1/27
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Index"/>
</c:if>

<html>
<head>
    <title>Search Result | VRM Blog</title>
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

    <!-- include summernote css/js -->
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>

<%--    <script>
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
    </script>--%>
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

<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@include file="navigation.jsp" %>
<div class="container">
    <div class="btn-group btn-group-justified col-xs-10" role="group" style="padding: 1%">
    <h1>Search Results</h1>
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
            <th class="sort-alpha" style="color: #0085a1"><ins>Title<span class="glyphicon glyphicon-sort">&nbsp;</span></ins></th>
            <th class="sort-alpha" style="color: #0085a1"><ins>Author<span class="glyphicon glyphicon-sort">&nbsp;</span></ins></th>
            <th class="sort-alpha" style="color: #0085a1"><ins>Date Published<span class="glyphicon glyphicon-sort">&nbsp;</span></ins></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${personLoggedIn == null}">
            <tr>
                <td colspan="4">Please log in first!</td>
            </tr>
        </c:if>

        <c:if test="${articleList.size() == 0}">
            <c:if test="${personLoggedIn != null}">
                <tr>
                    <td colspan="4">No result found!</td>
                </tr>
            </c:if>

        </c:if>

        <c:if test="${personLoggedIn != null}">
            <c:if test="${articleList.size() > 0}">
                <c:forEach var="articleList" items="${articleList}">
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

            </c:if>
        </c:if>





        </tbody>
    </table>




</div>


</body>
</html>
