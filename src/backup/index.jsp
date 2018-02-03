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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link href="index.css" rel="stylesheet">
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script>
        function onSubmit() {
            document.getElementById('signupform').submit();
        }
    </script>

</head>
<body>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${signUpStatus == true}">

</c:if>

<header class="masthead" style="background-image: url('imgs/backgroud01.jpg')">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 mx-auto">
                <div class="site-heading">
                    <h1><u>VRM BLOG</u></h1>
                    <br>
                    <h2>Your journey starts here</h2>
                    <br>
                    <div class="btn-group btn-group-justified col-xs-10" role="group"
                         style="padding-left: 15%; padding-right: 15%">
                        <a href="login.jsp">
                            <div class="btn-group" role="group" style="padding: 1%">
                                <button type="button" class="btn btn-default"
                                        style="background-color: white; opacity: 0.8"
                                        data-toggle="modal" data-target="#loginBtn"
                                        data-backdrop="static" data-keyboard="false">
                                    Log in
                                </button>
                            </div>
                        </a>

                        <a href="signup.jsp">
                            <div class="btn-group" role="group" style="padding: 1%">
                                <button type="button" class="btn btn-default"
                                        style="background-color: white; opacity: 0.8"
                                        data-toggle="modal" data-target="#signupBtn">
                                    Sign up
                                </button>
                            </div>
                        </a>

                        <a href="Articles">
                            <div class="btn-group" role="group" style="padding: 1%">
                                <button type="button" class="btn btn-default"
                                        style="background-color: white; opacity: 0.8">
                                    Explore
                                </button>
                            </div>
                        </a>

                    </div>

                </div>
            </div>
        </div>
    </div>
</header>

<div class="container modal fade" id="loginBtn">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="panel-heading">
                    <div class="panel-title">Sign In</div>
                    <div style="float:right; font-size: 80%; position: relative; top:-10px"><a href="#">Forgot
                        password?</a>
                    </div>
                </div>
            </div>

            <div class="modal-body">
                <div style="padding-top:30px" class="panel-body">
                    <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                    <form id="loginform" class="form-horizontal" action="Login" method="post">
                        <div style="margin-bottom: 25px" class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input id="login-username" type="text" class="form-control" name="username" value=""
                                   required="true" placeholder="Username">
                        </div>
                        <div style="margin-bottom: 25px" class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                            <input type="password" onfocus="this.value=''" required="true" class="form-control"
                                   name="pass"
                                   placeholder="Password">
                        </div>
                        <div style="color:red">${errorMessage}</div>
                        <div class="input-group">
                            <div class="checkbox">
                                <label>
                                    <input id="login-remember" type="checkbox" name="remember" value="1"> Remember
                                    me
                                </label>
                            </div>
                        </div>
                        <div style="margin-top:10px" class="form-group">
                            <div class="col-sm-12 controls">
                                <button id="btn-login" class="btn btn-success" type="submit">Sign in</button>
                                <button id="btn-fblogin" class="btn btn-primary" type="button"
                                        onclick="window.location.href='https://www.facebook.com/dialog/oauth?client_id=352195078594245&redirect_uri=http://localhost:8181/oauth2fb&scope=email'">
                                    Continue with Facebook
                                </button>
                            </div>
                        </div>
                    </form>
                    <div class="form-group">
                        <div class="col-md-12 control">
                            <div style="border-top: 1px solid#888; padding-top:15px; font-size:85%">
                                Don't have an account!
                                <a href="signup.jsp">
                                    Sign Up
                                    <Here></Here>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<div class="container modal fade" id="signupBtn" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">

                <div class="panel-heading">
                    <div class="panel-title">Sign Up</div>
                    <div style="float:right; font-size: 85%; position: relative; top:-10px">
                        <a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()">
                            Sign In
                        </a>
                    </div>
                </div>
            </div>

            <div class="modal-body">
                <div class="panel-body">
                    <form id="signupform" class="form-horizontal" role="form" method="post" action="SignUp"
                          enctype='multipart/form-data'>

                        <div id="signupalert" style="display:none" class="alert alert-danger">
                            <p>Error:</p>
                            <span></span>
                        </div>

                        <div class="form-group">
                            <label for="username" class="col-md-3 control-label">Username</label>
                            <div class="col-md-9">
                                <input type="text" id="username" class="form-control" name="username"
                                       placeholder="Enter Username 4~20 characters">
                                <div style="color:red">${usernameError}</div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password" class="col-md-3 control-label">Password</label>
                            <div class="col-md-9">
                                <input type="password" id="password" class="form-control" name="password"
                                       placeholder="Enter Password 4~20 characters">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="cPassword" class="col-md-3 control-label">Confirm Password</label>
                            <div class="col-md-9">
                                <input type="password" id="cPassword" class="form-control" name="cPassword"
                                       placeholder="Confirm Password">
                                <div style="color:red">${passwordError}</div>
                            </div>
                        </div>

<%--                        <div class="form-group">
                            <label for="fname" class="col-md-3 control-label">First Name</label>
                            <div class="col-md-9">
                                <input type="text" id="fname" class="form-control" name="fname"
                                       placeholder="Enter First Name">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="lname" class="col-md-3 control-label">Last Name</label>
                            <div class="col-md-9">
                                <input type="text" id="lname" class="form-control" name="lname"
                                       placeholder="Enter Last Name">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="dob" class="col-md-3 control-label">Date of Birth</label>
                            <div class="col-md-9">
                                <input type="date" id="dob" class="form-control" name="dob" placeholder="date of birth">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="country" class="col-md-3 control-label">Country</label>
                            <div class="col-md-9">
                                <select name="country" id="country" class="form-control">
                                    <option value="nz" selected>New Zealand</option>
                                    <option value="aus">Australia</option>
                                    <option value="in">India</option>
                                    <option value="us">United States</option>
                                    <option value="other">other</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description" class="col-md-3 control-label">Description</label>
                            <div class="col-md-9">
                        <textarea id="description" class="form-control" name="description" rows="4" columns="40">

                        </textarea>
                            </div>
                        </div>--%>

                        <div class="form-group">
                            <label for="avatar" class="col-md-3 control-label">Profile Photo</label>
                            <div class="col-md-9" id="avatar">

                                <input type="radio" id="avatar01" name="avatar" value="avatar_01.png">
                                <label for="avatar01"><img src="avatars/avatar_01.png" height="40"></label>

                                <input type="radio" id="avatar02" name="avatar" value="avatar_02.png">
                                <label for="avatar02"><img src="avatars/avatar_02.png" height="40"></label>

                                <input type="radio" id="avatar03" name="avatar" value="avatar_03.png">
                                <label for="avatar03"><img src="avatars/avatar_03.png" height="40"></label>

                                <input type="radio" id="avatar04" name="avatar" value="avatar_04.png">
                                <label for="avatar04"><img src="avatars/avatar_04.png" height="40"></label>

                                <input type="radio" id="avatar05" name="avatar" value="avatar_05.png">
                                <label for="avatar05"><img src="avatars/avatar_05.png" height="40"></label>

                                <input type="radio" id="avatar06" name="avatar" value="avatar_06.png">
                                <label for="avatar06"><img src="avatars/avatar_06.png" height="40"></label>

<%--                                <input type="radio" id="avatar07" name="avatar" value="avatar_07.png">
                                <label for="avatar07"><img src="avatars/avatar_07.png" height="40"></label>--%>

                            </div>
                        </div>

                        <div class="form-group">
                            <label for="uploadAvatar" class="col-md-3 control-label">Upload Photo</label>
                            <input type="file" name="img[]" id="uploadAvatar" class="file" style="visibility: hidden; position: absolute;">
                            <div class="input-group col-md-8">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-picture"></i></span>
                                <input type="text" class="form-control input" name="uploadAvatar" disabled
                                       placeholder="Upload Image">
                                <span class="input-group-btn">
                            <button class="browse btn btn-default input" type="button">
                                <i class="glyphicon glyphicon-search"></i> Browse</button>
                        </span>
                            </div>
                        </div>

                        <script src="//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js"></script>
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
                        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
                        <script>
                            $(document).on('click', '.browse', function () {
                                var file = $(this).parent().parent().parent().find('.file');
                                file.trigger('click');
                            });
                            $(document).on('change', '.file', function () {
                                $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
                            });
                        </script>

                        <div class="form-group">
                            <div class="g-recaptcha form-group" data-sitekey="6LdzZkIUAAAAANwDR88UIllyBhP9hRKPpNusMmX6"
                                 style="margin-left: 40px">
                            </div>
                        </div>

                    </form>
                </div>
            </div>

            <div class="modal-footer">

                <div class="form-group form-horizontal">
                    <!-- Button -->
                    <div class="col-md-offset-3 col-md-9">
                        <button id="btn-signup" type="submit" class="btn btn-info g-recaptcha"
                                data-sitekey="6LfeHx4UAAAAAAKUx5rO5nfKMtc9-syDTdFLftnm"
                                data-callback="onSubmit">Sign Up
                        </button>
                        <span style="margin-left:20px; margin-right: 20px;">or</span>
                        <button id="btn-fbsignup" type="button"
                                onclick="window.location.href='https://www.facebook.com/dialog/oauth?client_id=352195078594245&redirect_uri=http://localhost:8181/oauth2fb&scope=email'"
                                class="btn btn-primary"><i class="icon-facebook"></i>  
                            Continue with Facebook
                        </button>
                    </div>
                </div>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>
