<%--
  Created by IntelliJ IDEA.
  User: Mengjie
  Date: 2018/2/6
  Time: 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Reset Password | VRM Blog</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
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

    <%--javascript for AJAX to check username and password validation--%>
    <script type="text/javascript">
        window.onload = function () {
            var validcolor = "#00ff00";
            var invalidcolor = "#ff0000";

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
            }

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
            }
        }
    </script>

    <script type="text/javascript">
        var imageCollection = [
            "background01.jpg",
            "background02.jpg",
            "background03.jpg",
            "background04.jpg",
            "background05.jpg",
            "background06.jpg",
            "background07.jpg",
            "background08.jpg",
            "background09.jpg",
            "background10.jpg",
            "background11.jpg",
            "background13.jpg", "background14.jpg", "background15.jpg", "background16.jpg", "background17.jpg", "background18.jpg", "background19.jpg", "background20.jpg", "background21.jpg", "background22.jpg", "background23.jpg", "background24.jpg"
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
            <i class="fa fa-bars"></i>
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
                <div class="page-heading" style="margin: 2%; padding: 10% 0 0 0;">

                    <div class="panel-title"><h3>Reset Password</h3></div>

                    <div style="padding-top:30px" class="panel-body">

                        <form id="signupform" class="form-horizontal" role="form" method="post" action="resetpassword">

                            <input type="text" name="username" value="${username}" hidden>

                            <div class="form-group">
                                <div class="col-xs-12">
                                    <label for="password" style="float: left;">New Password</label><span style="color:red; font-size: 70%; margin-left: 3%; float: right" id="passwordFormatCheck"></span>
                                    <%--<label for="password" style="float: left;"><span style="font-size: 60%; color: wheat">(at least 1 UPPERCASE, 1 lowercase, 1 digit number, minimum length is 4)</span></label>--%>
                                    <input type="password" id="password" class="form-control" name="password"
                                           placeholder="Enter Password 4~20 characters" required>


                                </div>

                            </div>

                            <div class="form-group">
                                <div class="col-xs-12">
                                    <label for="cPassword" style="float: left;">Confirm New Password</label><div style="color:red; font-size: 70%; margin-left: 3%; float: right" id="passwordCheck">${passwordError}</div>
                                    <input type="password" id="cPassword" class="form-control" name="cPassword"
                                           placeholder="Confirm Password" required>


                                </div>

                            </div>

                            <div class="form-group">

                                <div class=" row col-xs-12" style="display: block">
                                    <button style="color:white; margin: 1%; padding: 1%; opacity: 0.8;" id="btn-login"
                                            class="btn btn-success"
                                            type="submit" value="Submit">Verify
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
