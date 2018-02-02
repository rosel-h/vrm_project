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
    <h1>All Articles</h1>
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
                        <%--<button style="float: right;" type="button" class="btn btn-sm" data-toggle="modal"--%>
                                <%--data-target="#a${articleList.getArticleID()}">Full Article--%>
                        <%--</button>--%>

                        <form action="/OneArticle" method="post">
                            <input type="hidden" name="articleID" value="${articleList.getArticleID()}">
                            <button type="submit" class="btn">Full Article</button>
                        </form>
                    </td>
                </tr>


            </c:if>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>