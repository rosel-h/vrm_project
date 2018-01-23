<%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 22/01/2018
  Time: 3:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Uncomment the following lines to use Bootstrap -->


<html>
<head>
    <title>VRM Blog</title>
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

    <style>
        .row > .main-btn {
            display: inline-block;
        }

        .container .btn-group .row {
            margin: auto;
            align-items: center;
            justify-content: center;
        }

        .container > .btn-group, .btn-group > .row {
            width: 100%;
        }

        .btn {
            text-align: center;
        }


    </style>

</head>
<body>



<div class="container">
    <div class="btn-group" role="group">
        <div class="image">
            <img src="imgs/backgroud01.jpg" style="width: 100%">
        </div>
        <div class="row" style="">
            <a href="login.jsp">
                <button type="submit" class="btn btn-default">Log in</button>
            </a>

            <a href="signup.jsp">
                <button type="submit" class="btn btn-default">Sign Up</button>
            </a>

            <a href="explore.jsp">
                <button type="submit" class="btn btn-default">Explore</button>
            </a>

        </div>
    </div>
</div>

</body>
</html>
