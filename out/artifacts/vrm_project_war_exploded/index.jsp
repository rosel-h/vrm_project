<%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 22/01/2018
  Time: 3:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Uncomment the following lines to use Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
      integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
      crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
        integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
        crossorigin="anonymous"></script>

<html>
<head>
    <title>VRM Blog</title>
</head>
<body>
<div class="container col-lg-3 col-xs-12 col-sm-6 col-md-4">
    <div class="btn-group" role="group">
        <button href="/LogInServlet" type="button" class="btn btn-default">Log in</button>
        <button href="/SignUpServlet" type="button" class="btn btn-default">Sign up</button>

        <form method="get" action="/Articles">
            <button type="submit" class="btn btn-default">Explore</button>
        </form>
    </div>
</div>
</body>
</html>
