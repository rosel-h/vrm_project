<%@ page import="DAO_setup.Article" %><%--
  Created by IntelliJ IDEA.
  User: Rose
  Date: 29/01/2018
  Time: 10:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Article</title>
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
</head>
<body>
<%
    String id = request.getParameter("articleID");
    String articleStory = request.getParameter("articleContent");
    String author= request.getParameter("author");
    String articleTitle= request.getParameter("articleTitle");
    System.out.println("editArticle jsp: "+ author);
    System.out.println("editArticle jsp: "+ articleTitle);
    System.out.println("editArticle jsp: "+ articleStory);

%>
<div class="container">
    <div>Hello, <%= author%> <%--${articleToBeEdited.getUsername()}--%>. Edit your article below</div>
    <!--  A form letting users add new articles. -->
    <div class="panel panel-info">

        <div class="panel-heading">
            <h3 class="panel-title">Edit Article</h3>
        </div>
        <div class="panel-body">
            <form action="/editArticles" method="POST">
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" class="form-control" value="<%= articleTitle%><%--${articleToBeEdited.getTitle()}--%>" required>
                </div>
                <div class="form-group">
                    <label for="summernote">Content</label>
                    <textarea id="summernote" name="content" class="form-control" rows="10" required><%=articleStory%> <%--${articleToBeEdited.getContent()}--%></textarea>
                </div>
                <div class="form-group">
                    <input type="hidden" name="articleID" value="<%= id%><%--${articleToBeEdited.getArticleID()}--%>">
                    <input type="hidden" name="author" value="<%=author%><%--${articleToBeEdited.getUsername()}--%>">
                    <input type="hidden" name="operation" value="userHasEditedArticle">
                    <%--<input type="hidden" name="dateInDatabse" value="${article}">--%>

                    <button type="submit" class="btn btn-primary">Done</button>
                </div>

            </form>
        </div>
    </div>
</div>


</body>
</html>

