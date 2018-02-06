<%--
  Created by IntelliJ IDEA.
  User: Mengjie
  Date: 2018/1/24
  Time: 9:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Index"/>
</c:if>

<!DOCTYPE html><html>
<head>
    <title>Sign up successfully | VRM Blog</title>
</head>

<head>
    <title>Sign Up</title>
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
</head>
<body style="background-color: #e6e6e6">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header id="backgroundImage" class="masthead">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 col-sm-12 mx-auto" id="headingID">
                <div class="page-heading">

                    <div class="panel-title"><h3>Sign up successfully!</h3></div>


                    <div style="padding-top:30px" class="panel-body">

                        <div class="control-label">${directMessage} in <span id="countdown">6</span> seconds</div>
                        <script type="text/javascript">

                            // Total seconds to wait
                            var seconds = 3;

                            function countdown() {
                                seconds = seconds - 1;
                                if (seconds < 0) {
                                    // Chnage your redirection link here
                                    window.location = "login.jsp";
                                } else {
                                    // Update remaining seconds
                                    document.getElementById("countdown").innerHTML = seconds;
                                    // Count down using javascript
                                    window.setTimeout("countdown()", 1000);
                                }
                            }

                            // Run countdown function
                            countdown();

                        </script>

                        <c:if test="${directErrorMessage.equals('true')}">
                            <div class="control-label">Or click <ins><a href="login.jsp" style="color: yellow; font-weight: bold">here</a></ins> to login!</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>


<%--    <div id="signupsuccess" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-info">

            <div class="panel-heading">
                <div class="panel-title">${successMessage}</div>
            </div>

            <div class="panel-body">
                <div class="control-label">${directMessage} in <span id="countdown">6</span> seconds</div>
                <script type="text/javascript">

                    // Total seconds to wait
                    var seconds = 3;

                    function countdown() {
                        seconds = seconds - 1;
                        if (seconds < 0) {
                            // Chnage your redirection link here
                            window.location = "login.jsp";
                        } else {
                            // Update remaining seconds
                            document.getElementById("countdown").innerHTML = seconds;
                            // Count down using javascript
                            window.setTimeout("countdown()", 1000);
                        }
                    }

                    // Run countdown function
                    countdown();

                </script>

                <c:if test="${directErrorMessage.equals('true')}">
                    <div class="control-label">Or click <ins><a href="login.jsp">here</a></ins> to login!</div>
                </c:if>
            </div>
        </div>

    </div>--%>




</header>






</body>
</html>
