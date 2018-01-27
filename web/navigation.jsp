<%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 22/01/2018
  Time: 3:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="welcome.jsp">Project VRM</a>
        </div>
        <ul class="nav navbar-nav">
            <li ><a href="welcome.jsp">Home</a></li>
            <li><a href="/Articles">Explore</a></li>
            <li><a href="">My Articles(no href)</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#">MyAccount(no href)</a></li>
            <li><a href="signup.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
            <li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
            <li>
                <form method="post" action="Main">
                    <button type="submit" name="logout_button" value="Logout">Log out</button>
                </form>
            </li>
        </ul>
        <form class="navbar-form navbar-left" action="searcharticle">
            <div class="form-group">
                <input type="text" class="form-control" name="keywords" placeholder="Title/Username/Date">
            </div>
            <div class="form-group">
                <select class="form-control" name="searchType">
                    <option value="title">Title</option>
                    <option value="username">Username</option>
                    <option value="date">Date</option>
                </select>
            </div>
            <button type="submit" class="btn btn-default">Search</button>
        </form>
    </div>
</nav>