<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 30/01/2018
  Time: 2:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Index"/>
</c:if>

<html>
<head>
    <title>${sessionScope.personLoggedIn} Articles</title>
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
                    ['insert',['picture']]
                ]
            });
        });
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
    <script type="text/javascript">
        var imageCollection = [
            "background01.jpg",
            "background02.jpg",
            "background03.jpg",
            "background04.jpg",
            "background05.jpg"
        ];

        function loadRandomImage() {
            var numImage = Math.floor(Math.random() * (imageCollection.length));
            $('#backgroundImage').css('background-image', 'url(/img/' + imageCollection[numImage] + ')');
            console.log(imageCollection[numImage]);
        }

    </script>

</head>
<body>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%--<c:choose>--%>
    <%--<c:when test="${personLoggedIn !=null}">--%>
        <%--<%@include file="navigation.jsp" %>--%>
    <%--</c:when>--%>
    <%--<c:otherwise>--%>
        <%--<%@include file="guestnavigation.jsp" %>--%>
    <%--</c:otherwise>--%>
<%--</c:choose>--%>

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


<!-- Page Header -->
<header id="backgroundImage" class="masthead" style="background-image: url('img/background02.jpg');">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto" id="headingID">
                <div class="page-heading" style="margin: 0; padding: 10% 0 0 0;">
                    <div class="col-md-4 offset-4">
                        <img src="avatars/${user.getAvatar_icon()}" alt="avatar" style="width: 100%; border-radius: 50%"
                             class="img-circle">
                    </div>
                    <br>
                    <h5>Explore the community or create a new blog entry</h5>
                    <div class="btn-group btn-group-justified col-xs-10" role="group"
                         style="padding: 1%">
                        <div style="padding: 1%;margin: 1%">
                            <a href="myArticles" class="btn btn-default"
                               style=" background-color: white; opacity: 0.6">
                                <span class="glyphicon glyphicon-circle-arrow-right" aria-hidden="true"> &nbsp;My Articles</span>
                            </a>
                        </div>
                        <div style="padding: 1%;margin: 1%">
                            <a href="Articles" class="btn btn-default"
                               style=" background-color: white; opacity: 0.6">
                                <span class="glyphicon glyphicon-circle-arrow-right"
                                      aria-hidden="true"> &nbsp;Community</span>
                            </a>
                        </div>
                        <div style="padding: 1%;margin: 1%">
                            <a href="NewArticle" class="btn btn-danger"
                               style=" color: white;opacity: 0.8">
                                <span class="glyphicon glyphicon-circle-arrow-right" aria-hidden="true"> &nbsp;New Article</span>
                            </a>
                        </div>
                    </div>
                </div>

                <form class="navbar-form navbar-right" action="searcharticle" style="margin: auto;">

                    <div class="row">
                        <div class="form-group">
                            <input type="text" class="form-control" name="keywords" placeholder="Title/Username/Date"
                                   id="searchkeyword">
                        </div>
                        <div class="form-group">
                            <select class="form-control" name="searchType" id="searchselect">
                                <option value="title">Title</option>
                                <option value="username">Username</option>
                                <option value="date">Date</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="form-control">Search</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</header>

<div class="container">
    <h1 class="post-title">All Articles by ${sessionScope.personLoggedIn}</h1>
    <div style="float: right">
        <c:if test="${personLoggedIn !=null}">
            <div>Logged in as ${sessionScope.personLoggedIn} <a href="editprofile"> <img src="avatars/${user.getAvatar_icon()}"
                                                                            style="height: 30px"
                                                                            alt="avatar"/></a>
            </div>
        </c:if>
        <c:if test="${personLoggedIn ==null}">
            <div>Logged in as Guest</div>
        </c:if>
    </div>

    <table class="table table-hover sorttable" id="articletable">
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

        <%
            System.out.println("myArticles jsp: inside table body");
            java.sql.Date sqlDateToday = java.sql.Date.valueOf(LocalDate.now());
            request.setAttribute("sqlDateToday", sqlDateToday);
        %>
            <c:forEach var="myArticles" items="${myArticles}">
                <%--<c:if test="${personHasLoggedIn==articleList.getUsername()}">--%>

                    <tr>
                        <td><b>${myArticles.getTitle()}</b>
                            <%--<br>--%>
                            <div style="font-size: small">${myArticles.getContentPreview()}</div>
                        </td>
                        <td><i>${myArticles.getUsername()}</i></td>
                        <td >${myArticles.getDate()}
                            <c:if test="${myArticles.dateIsGreaterThan(sqlDateToday)}">
                                (not yet published)
                            </c:if>
                        </td>
                        <td>
                            <%--<button style="float: right;" type="button" class="btn btn-sm" data-toggle="modal"--%>
                                    <%--data-target="#a${myArticles.getArticleID()}">Full Article--%>
                            <%--</button>--%>
                                <form action="OneArticle" method="post">
                                    <input type="hidden" name="articleID" value="${myArticles.getArticleID()}">
                                    <input type="hidden" name="operation" value="fullArticleClickedFromMyArticle">
                                    <button type="submit" class="btn">Full Article</button>
                                </form>
                        </td>
                    </tr>

            </c:forEach>
        </tbody>
    </table>




</div>

</body>
</html>
