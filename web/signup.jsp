<%--
  Created by IntelliJ IDEA.
  User: mshe666
  Date: 23/01/2018
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<c:if test="${sessionScope.personLoggedIn != null}">
    <c:redirect url="Welcome"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


    <title>VRM Blog Blog</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/png" href="img/vrmlogo.png"/>
    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery/jquery.js"></script>
    <script src="vendor/jquery/jquery-ui.min.js"></script>

    <!-- Custom fonts for this template -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
          rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="vendor/css/clean-blog.min.css" rel="stylesheet">
    <!-- Custom scripts for this template -->
    <script src="vendor/js/clean-blog.min.js"></script>
    <script src="vendor/js/featured.js"></script>

    <script src='https://www.google.com/recaptcha/api.js'></script>

    <%--javascript for AJAX to check username and password validation--%>
    <script type="text/javascript">
        window.onload = function () {
            var validcolor = "#00ff00";
            var invalidcolor = "#ff0000";
            document.getElementById("username").onblur = function () {
                var username = document.getElementById("username").value;
                $.ajax({
                    url: "checkusername",
                    type: "GET",
                    data: {username: username},
                    success: function (msg) {
                        if (msg != "Username already exists") {
                            document.getElementById("usernameCheck").innerHTML = "<span class='glyphicon glyphicon-ok'></span>" + "&nbsp;" + "Username is valid";
                            document.getElementById("usernameCheck").style.color = validcolor;
                        } else {
                            document.getElementById("usernameCheck").innerHTML = "<span class='glyphicon glyphicon-remove'></span>" + "&nbsp;" + msg;
                        }
                    }
                });
            };

            document.getElementById("password").onblur = function () {
                var password = document.getElementById("password").value;
                var cPassword = document.getElementById("cPassword").value;
                $.ajax({
                    url: "checkpassword",
                    type: "GET",
                    data: {password: password, cPassword: cPassword},
                    success: function (msg) {
                        if (msg == "000") {
                            var out = "Password is valid";
                            document.getElementById("passwordFormatCheck").innerHTML = "<span class='glyphicon glyphicon-ok'></span>" + "&nbsp;" + out;
                            document.getElementById("passwordFormatCheck").style.color = validcolor;
                            document.getElementById("passwordCheck").innerHTML = "<span class='glyphicon glyphicon-ok'></span>" + "&nbsp;" + out;
                            document.getElementById("passwordCheck").style.color = validcolor;
                        } else {
                            var out = "";

                            if (msg == "999") {
                                out = "Password cannot be empty!";
                            } else if (msg == "888") {
                                out = "Password cannot be empty!";
                            } else if (msg.charAt(0) == "1") {
                                out = "At least contain 1 UPPERCASE character!";
                            } else if (msg.charAt(0) == "2") {
                                out = "At least contain 1 lowercase character!";
                            } else if (msg.charAt(0) == "3") {
                                out = "At least contain 1 digit number!";
                            } else if (msg.charAt(0) == "4") {
                                out = "Minimum length of password is 4!";
                            }

                            if (out != "") {
                                document.getElementById("passwordFormatCheck").innerHTML = "<span class='glyphicon glyphicon-remove'></span>" + "&nbsp;" + out;
                                document.getElementById("passwordFormatCheck").style.color = invalidcolor;
                                if (msg.charAt(2) == "0") {
                                    out = "Two passwords are different!";
                                    document.getElementById("passwordCheck").innerHTML = "<span class='glyphicon glyphicon-remove'></span>" + "&nbsp;" + out;
                                    document.getElementById("passwordCheck").style.color = invalidcolor;
                                }
                            }

                            if (msg.charAt(0) == "0") {
                                var out = "Password is valid";
                                document.getElementById("passwordFormatCheck").innerHTML = "<span class='glyphicon glyphicon-ok'></span>" + "&nbsp;" + out;
                                document.getElementById("passwordFormatCheck").style.color = validcolor;

                                if (msg == "0004") {
                                    out = "Two passwords are different!";
                                    document.getElementById("passwordCheck").innerHTML = "<span class='glyphicon glyphicon-remove'></span>" + "&nbsp;" + out;
                                    document.getElementById("passwordCheck").style.color = invalidcolor;
                                }
                            }

                        }

                    }
                });
            };

            document.getElementById("cPassword").onblur = function () {
                var password = document.getElementById("password").value;
                var cPassword = document.getElementById("cPassword").value;
                $.ajax({
                    url: "checkpassword",
                    type: "GET",
                    data: {password: password, cPassword: cPassword},
                    success: function (msg) {
                        if (msg == "000") {
                            var out = "Password is valid";
                            document.getElementById("passwordFormatCheck").innerHTML = "<span class='glyphicon glyphicon-ok'></span>" + "&nbsp;" + out;
                            document.getElementById("passwordFormatCheck").style.color = validcolor;
                            document.getElementById("passwordCheck").innerHTML = "<span class='glyphicon glyphicon-ok'></span>" + "&nbsp;" + out;
                            document.getElementById("passwordCheck").style.color = validcolor;
                        } else {
                            var out = "";

                            if (msg == "999") {
                                out = "Password cannot be empty!";
                            } else if (msg.charAt(1) == "0" && msg.length == 2) {
                                out = "Password cannot be empty!";
                            } else if (msg.charAt(2) == "1") {
                                out = "At least contain 1 UPPERCASE character!";
                            } else if (msg.charAt(2) == "2") {
                                out = "At least contain 1 lowercase character!";
                            } else if (msg.charAt(2) == "3") {
                                out = "At least contain 1 digit number!";
                            } else if (msg.charAt(2) == "4") {
                                out = "Minimum length of password is 4!";
                            } else if (msg.charAt(2) == "0") {
                                out = "Two passwords are different!";
                            } else if (msg == "0004") {
                                out = "Two passwords are different!";
                            }

                            if (out != "") {
                                document.getElementById("passwordCheck").innerHTML = "<span class='glyphicon glyphicon-remove'></span>" + "&nbsp;" + out;
                                document.getElementById("passwordCheck").style.color = invalidcolor;
                            }
                        }
                    }
                });
            };
        }
    </script>

    <script type="text/javascript">
        var imageCollection = [
            "background01.jpg", "background02.jpg", "background03.jpg", "background04.jpg", "background05.jpg", "background06.jpg", "background07.jpg", "background08.jpg", "background09.jpg", "background10.jpg", "background11.jpg", "background13.jpg", "background14.jpg", "background15.jpg", "background16.jpg", "background17.jpg", "background18.jpg", "background19.jpg", "background20.jpg", "background21.jpg", "background22.jpg", "background23.jpg", "background24.jpg"
        ];


        function loadRandomImage() {
            var numImage = Math.floor(Math.random() * (imageCollection.length));
            $('#backgroundImage').css('background-image', 'url(img/' + imageCollection[numImage] + ')');
            console.log(imageCollection[numImage]);
        }

        $(document).ready(function () {
            loadRandomImage();
        });

    </script>

    <%--javascript for show more--%>
    <script type="text/javascript">
        function showtoggle() {
            var x = document.getElementById("form-content2");
            var y = document.getElementById("toggletext");
            if (x.style.display === "none") {
                x.style.display = "block";
                y.innerHTML = "";
            } else {
                x.style.display = "none";
            }
        }

    </script>
    <style>
        label {
            font-size: 12px;
        }
    </style>

</head>
<body style="background-color: #e6e6e6">

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand"> VRM Travel Blog</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">Menu

        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="Welcome">Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<header id="backgroundImage" class="masthead">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 col-xs-12 mx-auto" id="headingID">
                <div class="page-heading" style="margin: 2%; padding: 10%">

                    <div class="panel-title"><h3>Sign up</h3></div>

                    <div style="float:right; font-size: 70%; position: relative; top:-1%; margin-right: 3%">
                        <a style="color: white;" id="signinlink" href="Signin">
                            Already registered?
                            <ins>Sign in</ins>
                            now!
                        </a>
                    </div>

                    <div style="padding-top:30px" class="panel-body">

                        <form id="signupform" class="form-horizontal" role="form" method="post" action="SignUp">
                            <div id="form_content1">

                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <label for="username" style="float: left;">Username</label><span
                                            style="color:red; font-size: 70%; margin-left: 3%; float: right"
                                            id="usernameCheck">${sessionScope.usernameError}</span>

                                        <input type="text" id="username" class="form-control" name="username"
                                               placeholder="Enter Username 4~20 characters" required>


                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <label for="password" style="float: left;"> Password</label><span
                                            style="color:red; font-size: 70%; margin-left: 3%; float: right"
                                            id="passwordFormatCheck"></span>
                                        <%--<label for="password" style="float: left;"><span style="font-size: 60%; color: wheat">(at least 1 UPPERCASE, 1 lowercase, 1 digit number, minimum length is 4)</span></label>--%>
                                        <input type="password" id="password" class="form-control" name="password"
                                               placeholder="Enter Password 4~20 characters" required>


                                    </div>

                                </div>

                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <label for="cPassword" style="float: left;"> Confirm Password</label>
                                        <div style="color:red; font-size: 70%; margin-left: 3%; float: right"
                                             id="passwordCheck">${sessionScope.passwordError}</div>
                                        <input type="password" id="cPassword" class="form-control" name="cPassword"
                                               placeholder="Confirm Password" required>


                                    </div>

                                </div>

                                <div class="form-group">

                                    <div class="col-xs-12">
                                        <label for="dob" style="float: left">Date of Birth</label><span
                                            style="color:red; font-size: 70%; margin-left: 3%; float: right"
                                            id="dobCheck">${sessionScope.dobError}</span>
                                        <input type="date" id="dob" class="form-control" name="dob"
                                               placeholder="date of birth" required>
                                    </div>
                                </div>

                                <div id="togglebtn" style="font-size: 85%; float: right; margin-right: 3%"
                                     onclick="showtoggle()">
                                    <ins id="toggletext">show more</ins>
                                </div>

                            </div>

                            <div id="form-content2" style="display: none;">

                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <label for="fname" style="float: left;">First Name</label>
                                        <input type="text" id="fname" class="form-control" name="fname"
                                               placeholder="Enter First Name">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <label for="lname" style="float: left;">Last Name</label>
                                        <input type="text" id="lname" class="form-control" name="lname"
                                               placeholder="Enter Last Name">
                                    </div>
                                </div>

                                <div class="form-group">

                                    <div class="col-xs-12">
                                        <label for="country" style="float: left;">Country</label>
                                        <select name="country" id="country" class="form-control">
                                            <option value="nz" selected>New Zealand</option>
                                            <option value="aus">Australia</option>
                                            <option value="cn">China</option>
                                            <option value="in">India</option>
                                            <option value="us">United States</option>
                                            <option value="other">Other</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-xs-12">
                                        <label for="security_q" style="float: left;">Security Question</label>
                                        <select name="security_q" id="security_q" class="form-control">
                                            <option value="secret_key" selected>
                                                Secret Key (Alphanumeric)
                                            </option>
                                            <option value="dad_fname" selected>
                                                What's your Dad's first name?
                                            </option>
                                            <option value="pet_name" selected>
                                                What's your first pet's name?
                                            </option>
                                            <option value="bestf_fname" selected>
                                                What's your best friend's first name?
                                            </option>
                                            <option value="hometown" selected>
                                                Where's your home town?
                                            </option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">

                                    <div class="col-xs-12">
                                        <label for="security_a" style="float: left;">Security Answer</label>
                                        <input type="text" id="security_a" class="form-control" name="security_a"
                                               value="">
                                    </div>
                                </div>

                                <div class="form-group">

                                    <div class="col-xs-12">
                                        <label for="description" style="float: left;">Description</label>
                                        <textarea id="description" class="form-control" name="description" rows="4"
                                                  columns="40"></textarea>
                                    </div>
                                </div>

                                <div class="form-group" style="float: left;">

                                    <div class="col-xs-12">
                                        <label for="dob">Profile Photo</label>

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

                                        <input type="radio" id="avatar07" name="avatar" value="avatar_07.png">
                                        <label for="avatar07"><img src="avatars/avatar_07.png" height="40"></label>

                                    </div>
                                </div>

                            </div>

                            <div class="form-group">

                                <div class=" row col-xs-12" style="display: block">
                                    <%--//this is for sporadic--%>
                                    <div class="g-recaptcha" data-sitekey="6LfS8UMUAAAAABglu_mCDKVCvWqoAznoR6DtrhRk" style="margin: 2%; padding: 2%"></div>

                                    <%--//this is for local host--%>
                                    <%--<div class="g-recaptcha" data-sitekey="6Lcm70MUAAAAADnXkTzd9N9aeRsrYH3EAkfe0lWp"--%>
                                         <%--style="margin-left: 2%; padding-bottom: 5%"></div>--%>
                                </div>

                            </div>

                            <div class="form-group">

                                <div class=" row col-xs-12" style="display: block">
                                    <button style="color:white; margin: 1%; padding: 1%; opacity: 0.8; height: 70%;"
                                            id="btn-signup"
                                            class="btn btn-success"
                                            type="submit" value="Submit">Sign up
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<%@include file="footer.jsp" %>

</body>
</html>