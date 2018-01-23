<%--
  Created by IntelliJ IDEA.
  User: vwen239
  Date: 23/01/2018
  Time: 11:57 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>


    <title>Login VRM</title>
</head>
<body>
<%--<div class="container">--%>
<%--<form class="form-signin" method="post" action="/Login">--%>
<%--<h2 class="form-signin-heading">Please Log On</h2>--%>
<%--<label for="inputUser" class="sr-only">Username</label>--%>
<%--<input type="user" name="username" id="inputUser" class="form-control" placeholder="Username" required--%>
<%--autofocus>--%>
<%--<label for="inputPassword" class="sr-only">Password</label>--%>
<%--<input type="password" id="inputPassword" name="pass" class="form-control" placeholder="Password" required>--%>
<%--<div class="checkbox">--%>
<%--<label>--%>
<%--<input type="checkbox" value="remember-me"> Remember me--%>
<%--</label>--%>
<%--<div style="color:red">${errorMessage}</div>--%>
<%--</div>--%>
<%--<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>--%>
<%--</form>--%>
<%--</div>--%>

<div class="container">
    <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="panel-title">Sign In</div>
                <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="#">Forgot password?</a>
                </div>
            </div>
            <div style="padding-top:30px" class="panel-body">
                <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>

                <form id="loginform" class="form-horizontal" action="/Login" method="post">

                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                        <input id="login-username" type="text" class="form-control" name="username" value=""
                               placeholder="Username">
                    </div>

                    <div style="margin-bottom: 25px" class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input id="login-password" type="password" class="form-control" name="pass" placeholder="">
                    </div>

                    <div style="color:red">${errorMessage}</div>
                    <div class="input-group">
                        <div class="checkbox">
                            <label>
                                <input id="login-remember" type="checkbox" name="remember" value="1"> Remember me
                            </label>
                        </div>
                    </div>

                    <div style="margin-top:10px" class="form-group">
                        <!-- Button -->

                        <div class="col-sm-12 controls">
                            <button id="btn-login" class="btn btn-success" type="submit">Sign in</button>
                            <button id="btn-fblogin" class="btn btn-primary" type="#">Login with Facebook</button>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-12 control">
                            <div style="border-top: 1px solid#888; padding-top:15px; font-size:85%">
                                Don't have an account!
                                <a href="signup.jsp">
                                    Sign Up Here
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>