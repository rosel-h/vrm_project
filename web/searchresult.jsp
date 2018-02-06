<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: Mengjie
  Date: 2018/1/27
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Login"/>
</c:if>

<!DOCTYPE html><html>
<head>
    <title>Search Result | VRM Blog</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">



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
            "background13.jpg","background14.jpg","background15.jpg","background16.jpg","background17.jpg","background18.jpg","background19.jpg","background20.jpg","background21.jpg","background22.jpg","background23.jpg","background24.jpg"
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

<c:choose>
    <c:when test="${sessionScope.personLoggedIn !=null}">
        <% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
        %>
        <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
            <div id="top" class="container">
                <a class="navbar-brand">Welcome ${personLoggedIn}</a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                        data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                        aria-label="Toggle navigation">Menu

                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">

                        <li class="nav-item">
                            <a class="nav-link" href="Welcome">Home</a>
                        </li>
                            <%--<li class="nav-item">--%>
                            <%--<a class="nav-link" href="Articles">Community</a>--%>
                            <%--</li>--%>
                            <%--<li class="nav-item">--%>
                            <%--<a class="nav-link" href="myArticles">My Articles</a>--%>
                            <%--</li>--%>
                        <li class="nav-item">
                            <a class="nav-link" href="editprofile">My Profile</a>
                        </li>
                            <%--<li class="nav-item">--%>
                            <%--<a class="nav-link" href="Main?logout_button=Logout">Log Out</a>--%>
                            <%--</li>--%>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Page Header -->
        <header id="backgroundImage" class="masthead" style="background-image: url('img/background02.jpg');">
            <div class="overlay"></div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-md-10 col-sm-12 mx-auto" id="headingID">
                        <div class="page-heading" style="margin: 10%; padding: 10%">
                            <div style="padding-top: 5%" class=" col-lg-4 col-4 col-md-4 col-sm-4 offset-4">
                                <img src="avatars/${user.getAvatar_icon()}" alt="avatar" style="border-radius: 50%"
                                     class="img-circle img-fluid">
                            </div>
                            <br>
                            <span class="subheading">By the travellers, for the travellers. Make every heartbeat count.</span>
                            <div class="btn-group btn-group-justified col-xs-10" role="group"
                                 style="padding: 1%">
                                <div style="padding: 1%;margin: 1%">
                                    <a href="myArticles" class="btn btn-default"
                                       style=" background-color: white; opacity: 0.8">
                                        My Articles
                                    </a>
                                </div>
                                <div style="padding: 1%;margin: 1%">
                                    <a href="Articles" class="btn btn-default"
                                       style=" background-color: white; opacity: 0.8">
                                        Community
                                    </a>
                                </div>
                                <div style="padding: 1%;margin: 1%">
                                    <a href="NewArticle" class="btn btn-danger"
                                       style=" color: white;opacity: 0.8">
                                        New Article
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>

    </c:when>
    <c:otherwise>
        <%@include file="guestnavigation.jsp" %>
    </c:otherwise>
</c:choose>

<div class="container">
    <div class="row" style="vertical-align: middle">
        <div class="btn-group btn-group-justified col-xs-10" role="group" style="padding: 1%">
            <h2>Search Results &nbsp;</h2>
        </div>

        <div class="btn-group btn-group-justified col-xs-10" role="group" style="padding: 1%">
            <form class="navbar-form navbar-right" action="searcharticle" style="margin: auto;">

                <div class="row">
                    <div class="form-group" style="padding: 1%">
                        <input size="60" type="text" required class="form-control" name="keywords"
                               placeholder="Title/Username/Date"
                               style="opacity: 0.8"
                               id="searchkeyword">
                    </div>
                    <div class="form-group" style="padding: 1%">
                        <select class="form-control" name="searchType" id="searchselect" style="opacity: 0.8">
                            <option value="title">Title</option>
                            <option value="username">Username</option>
                            <option value="date">Date</option>
                        </select>
                    </div>
                    <div class="form-group" style="padding: 1%">
                        <button type="submit" class="form-control" style="opacity: 0.8; width: 120%">Search</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <br>
    <div style="float: right">
        <c:if test="${sessionScope.personLoggedIn ==null}">
            <div>Logged in as Guest</div>
        </c:if>
    </div>
    <br>

    <table class="table table-hover sorttable" id="articletable">
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
                    <%
                        java.sql.Date sqlDateToday = java.sql.Date.valueOf(LocalDate.now());
                        request.setAttribute("sqlDateToday", sqlDateToday);
                    %>
                    <c:if test="${!articleList.dateIsGreaterThan(sqlDateToday)}">
                        <tr>
                            <td><h4 class="post-title">${articleList.getTitle()}</h4>
                                <form action="OneArticle" method="post">
                                    <input type="hidden" name="articleID" value="${articleList.getArticleID()}">
                                    <input type="hidden" name="operation" value="fullArticleClickedFromExplore">
                                    <input type="hidden" id="csrfToken" name="csrfToken"
                                           value="${sessionScope.get("csrfSessionToken")}">
                                    <button type="submit" style="font-weight: lighter; background: transparent" class="btn">Read More...</button>
                                </form>
                            </td>
                            <td>by <i>${articleList.getUsername()}</i></td>
                            <td>${articleList.getDate()}</td>
                        </tr>
                    </c:if>
                </c:forEach>

            </c:if>
        </c:if>





        </tbody>
    </table>

</div>

<%@include file="footer.jsp" %>
</body>
</html>
