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
</head>
<body>
<%--Load articles --%>
<div class="container">
    <h1>All Articles</h1>
    <c:forEach var="articleList" items="${articleList}">
        <div class="panel panel-warning">${articleList.getTitle()} by ${articleList.getUsername()}
            <button style="float: right;" type="button" class="btn btn-sm" data-toggle="modal"
                    data-target="#a${articleList.getArticleID()}">Full Article
            </button>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="a${articleList.getArticleID()}" role="dialog">
            <div class="modal-dialog">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">${articleList.getTitle()}</h4>
                    </div>
                    <div class="modal-body">
                        <div>Written by ${articleList.getUsername()}, published
                            on ${articleList.getFormattedDate()}</div>
                        <div>${articleList.getContent()}</div>
                    </div>

                    <div class="media panel-footer">
                        <div class=""><h4>Comments</h4></div>
                            <%--first comments--%>
                        <c:forEach var="commentList" items="${commentList}">
                            <c:if test="${articleList.getArticleID()==commentList.getArticleID()}">
                                <%--avatar icon--%>
                                <div class="media-left">
                                    <img src="avatars/avatar_01.png" class="media-object" style="width:30px">
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
                                                <img src="avatars/avatar_02.png" class="media-object"
                                                     style="width:30px">
                                            </div>
                                            <div class="media-body">
                                                <h5 class="media-heading">${nestedList.getCommentAuthor()}
                                                    <small><i>Posted on ${nestedList.getDatePublished()}</i></small>
                                                </h5>
                                                <p>${nestedList.getContent()}</p>
                                            </div>
                                        </c:if>

                                    </c:forEach>

                                </div>
                                <br>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </c:forEach>

    <form action="newArticle.jsp">
        <button class="btn btn-md" type="submit">New Article</button>
    </form>
</div>


</body>
</html>
