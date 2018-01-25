<%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 25/01/2018
  Time: 1:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Article</title>
</head>
<body>
<!--  A form letting users add new articles. -->
<div class="panel panel-info">

    <div class="panel-heading">
        <h3 class="panel-title">New Article</h3>
    </div>
    <div class="panel-body">
        <form action="/CreateArticles" method="POST">
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" id="title" name="title" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="content">Content</label>
                <textarea id="content" name="content" class="form-control" rows="10" required></textarea>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Post</button>
            </div>

            <input type="hidden" name="operation" value="add">
        </form>
    </div>

</div>


</body>
</html>
