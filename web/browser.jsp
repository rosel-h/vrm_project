<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Rose
  Date: 25/01/2018
  Time: 9:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<html>
<head>
    <title>VRM Browser</title>
</head>
<body>

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
        <tr>
            <td><b>${articleList.getTitle()}</b></td>
            <td><i>${articleList.getUsername()}</i></td>
            <td>${articleList.getFormattedDate()}</td>
            <td>
                <button style="float: right;" type="button" class="btn btn-sm" data-toggle="modal"
                        data-target="#a${articleList.getArticleID()}">Full Article
                </button>
            </td>
        </tr>
    </c:forEach>


    </tbody>
</table>

</body>
</html>
