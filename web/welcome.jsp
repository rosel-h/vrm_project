<%--
  Created by IntelliJ IDEA.
  User: vwen239
  Date: 23/01/2018
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<p>Welcome!</p>


<a href="Articles">
    <button type="submit" class="btn btn-default">Explore</button>
</a>

<form action="newArticle.jsp">
    <button class="btn btn-md" type="submit">New Article</button>
</form>

<a href="editprofile">
    <button type="button" class="btn btn-default">My Profile</button>
</a>



<form method="post" action="Main">
    <button type="submit" name="logout_button" value="Logout">Log out</button>
</form>
</body>
</html>
