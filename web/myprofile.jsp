<%--
  Created by IntelliJ IDEA.
  User: Mengjie
  Date: 2018/1/26
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Index"/>
</c:if>

<html>
<head>
    <title>My Profile | VRM BLOG</title>
    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet'
          type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
          rel='stylesheet' type='text/css'>
    <!-- Custom styles for this template -->
    <link href="vendor/css/clean-blog.min.css" rel="stylesheet">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
            "background13.jpg","background14.jpg","background15.jpg","background16.jpg","background17.jpg","background18.jpg","background19.jpg","background20.jpg","background21.jpg","background22.jpg","background23.jpg","background24.jpg"
        ];

        function loadRandomImage() {
            var numImage = Math.floor(Math.random() * (imageCollection.length));
            $('#backgroundImage').css('background-image', 'url(img/' + imageCollection[numImage] + ')');
            console.log(imageCollection[numImage]);
        }

        $(document).ready(function() {
            loadRandomImage();
        });
    </script>

</head>
<body>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div id="top" class="container">
        <a  class="navbar-brand">Welcome ${personLoggedIn}</a>
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
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="Articles">Community</a>--%>
                <%--</li>--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="myArticles">My Articles</a>--%>
                <%--</li>--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="editprofile">My Profile</a>--%>
                <%--</li>--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="Main?logout_button=Logout">Log Out</a>--%>
                <%--</li>--%>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<header id="backgroundImage" class="masthead">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 mx-auto">
                <div class="page-heading" style="margin: 1%; padding: 10% 0 0 0;">
                    <div style="padding-top: 5%" class=" col-lg-4 col-4 col-md-4 col-sm-4 offset-4">
                        <img src="avatars/${user.getAvatar_icon()}" alt="avatar" style="border-radius: 50%"
                             class="img-circle img-fluid">
                    </div>
                    <br>
                    <h5>My VRM Profile</h5>
                    <br>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <form id="signupform" class="form-horizontal" role="form" method="post" action="editprofile"
          enctype="multipart/form-data">
        <div class="row">
            <div class="col-xs-12 col-md-6">
                <div class="form-group">
                    <input type="hidden" id="csrfToken" name="csrfToken"
                           value="${sessionScope.get("csrfSessionToken")}">
                    <label for="fname" class="control-label">First Name</label>
                    <div class="col-md-9">
                        <input type="text" id="fname" class="form-control" name="fname" value="${user.getFname()}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="lname" class="control-label">Last Name</label>
                    <div class="col-md-9">
                        <input type="text" id="lname" class="form-control" name="lname" value="${user.getLname()}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="dob" class="control-label">Date of Birth</label>
                    <div class="col-md-9">
                        <input type="date" id="dob" class="form-control" name="dob"
                               value="${user.getDateOfBirth()}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="country" class="control-label">Country</label>
                    <div class="col-md-9">
                        <select name="country" id="country" class="form-control">
                            <option value="nz" <c:if test="${user.getCountry() eq 'nz'}">selected</c:if>>New
                                Zealand
                            </option>
                            <option value="aus" <c:if test="${user.getCountry() eq 'au'}">selected</c:if>>
                                Australia
                            </option>
                            <option value="in" <c:if test="${user.getCountry() eq 'in'}">selected</c:if>>India
                            </option>
                            <option value="us" <c:if test="${user.getCountry() eq 'us'}">selected</c:if>>United
                                States
                            </option>
                            <option value="other" <c:if test="${user.getCountry() eq 'other'}">selected</c:if>>
                                Other
                            </option>
                        </select>
                    </div>
                </div>


            </div>
            <div class="col-xs-12 col-md-6">
                <div class="form-group">
                    <label for="description" class="ccontrol-label">Description</label>
                    <div>
                        <textarea id="description" class="form-control" name="description" rows="4" columns="40">${user.getDescription()}
                        </textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label for="dob" class="control-label">Profile Photo</label>
                    <div>

                        <input type="radio" id="avatar01" name="avatar" value="avatar_01.png"
                               <c:if test="${user.getAvatar_icon() eq 'avatar_01.png'}">checked</c:if>>
                        <label for="avatar01"><img src="avatars/avatar_01.png" height="40"></label>

                        <input type="radio" id="avatar02" name="avatar" value="avatar_02.png"
                               <c:if test="${user.getAvatar_icon() eq 'avatar_02.png'}">checked</c:if>>
                        <label for="avatar02"><img src="avatars/avatar_02.png" height="40"></label>

                        <input type="radio" id="avatar03" name="avatar" value="avatar_03.png"
                               <c:if test="${user.getAvatar_icon() eq 'avatar_03.png'}">checked</c:if>>
                        <label for="avatar03"><img src="avatars/avatar_03.png" height="40"></label>

                        <input type="radio" id="avatar04" name="avatar" value="avatar_04.png"
                               <c:if test="${user.getAvatar_icon() eq 'avatar_04.png'}">checked</c:if>>
                        <label for="avatar04"><img src="avatars/avatar_04.png" height="40"></label>

                        <input type="radio" id="avatar05" name="avatar" value="avatar_05.png"
                               <c:if test="${user.getAvatar_icon() eq 'avatar_05.png'}">checked</c:if>>
                        <label for="avatar05"><img src="avatars/avatar_05.png" height="40"></label>

                        <input type="radio" id="avatar06" name="avatar" value="avatar_06.png"
                               <c:if test="${user.getAvatar_icon() eq 'avatar_06.png'}">checked</c:if>>
                        <label for="avatar06"><img src="avatars/avatar_06.png" height="40"></label>

                        <input type="radio" id="avatar07" name="avatar" value="avatar_07.png"
                               <c:if test="${user.getAvatar_icon() eq 'avatar_07.png'}">checked</c:if>>
                        <label for="avatar07"><img src="avatars/avatar_07.png" height="40"></label>

                    </div>
                </div>

                <div class="form-group">
                    <label for="dob" class="control-label">Upload Photo</label>
                    <input type="file" name="img[]" class="file" style="visibility: hidden; position: absolute;">
                    <div class="input-group">
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
                    <!-- Button -->
                    <div class="">
                        <button id="btn-signup" type="submit" class="btn btn-info">
                            Save
                        </button>

                        <span style="margin-left:20px; margin-right: 20px;">or</span>

                        <a href="welcome.jsp">
                            <button id="btn-cancel" type="button" class="btn btn-default"> 
                                Cancel
                            </button>
                        </a>

                        <span style="margin-left:20px; margin-right: 20px;">or</span>

                        <button id="btn-delete" onclick="window.location.href='deleteuser?csrfToken=${sessionScope.get('csrfSessionToken')}'" type="button" class="btn btn-danger">  
                            Delete
                        </button>

                    </div>
                </div>
            </div>

        </div>
    </form>

</div>

<%@include file="footer.jsp" %>
<%--<div class="container">
    <div id="signupbox" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-info">

            <div class="panel-body">
                <form id="signupform" class="form-horizontal" role="form" method="post" action="editprofile"
                      enctype='multipart/form-data'>

&lt;%&ndash;
                    <div id="signupalert" style="display:none" class="alert alert-danger">
                        <p>Error:</p>
                        <span></span>
                    </div>

                    <div class="form-group">
                        <label for="fname" class="col-md-3 control-label">First Name</label>
                        <div class="col-md-9">
                            <input type="text" id="fname" class="form-control" name="fname" value="${user.getFname()}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lname" class="col-md-3 control-label">Last Name</label>
                        <div class="col-md-9">
                            <input type="text" id="lname" class="form-control" name="lname" value="${user.getLname()}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dob" class="col-md-3 control-label">Date of Birth</label>
                        <div class="col-md-9">
                            <input type="date" id="dob" class="form-control" name="dob"
                                   value="${user.getDateOfBirth()}">
                        </div>
                    </div>
&ndash;%&gt;

&lt;%&ndash;                    <div class="form-group">
                        <label for="country" class="col-md-3 control-label">Country</label>
                        <div class="col-md-9">
                            <select name="country" id="country" class="form-control">
                                <option value="nz" <c:if test="${user.getCountry() eq 'nz'}">selected</c:if>>New
                                    Zealand
                                </option>
                                <option value="aus" <c:if test="${user.getCountry() eq 'au'}">selected</c:if>>
                                    Australia
                                </option>
                                <option value="in" <c:if test="${user.getCountry() eq 'in'}">selected</c:if>>India
                                </option>
                                <option value="us" <c:if test="${user.getCountry() eq 'us'}">selected</c:if>>United
                                    States
                                </option>
                                <option value="other" <c:if test="${user.getCountry() eq 'other'}">selected</c:if>>
                                    other
                                </option>
                            </select>
                        </div>
                    </div>&ndash;%&gt;

&lt;%&ndash;                    <div class="form-group">
                        <label for="description" class="col-md-3 control-label">Description</label>
                        <div class="col-md-9">
                        <textarea id="description" class="form-control" name="description" rows="4" columns="40">
                            ${user.getDescription()}
                        </textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dob" class="col-md-3 control-label">Profile Photo</label>
                        <div class="col-md-9">

                            <input type="radio" id="avatar01" name="avatar" value="avatar_01.png"
                                   <c:if test="${user.getAvatar_icon() eq 'avatar_01.png'}">checked</c:if>>
                            <label for="avatar01"><img src="avatars/avatar_01.png" height="40"></label>

                            <input type="radio" id="avatar02" name="avatar" value="avatar_02.png"
                                   <c:if test="${user.getAvatar_icon() eq 'avatar_02.png'}">checked</c:if>>
                            <label for="avatar02"><img src="avatars/avatar_02.png" height="40"></label>

                            <input type="radio" id="avatar03" name="avatar" value="avatar_03.png"
                                   <c:if test="${user.getAvatar_icon() eq 'avatar_03.png'}">checked</c:if>>
                            <label for="avatar03"><img src="avatars/avatar_03.png" height="40"></label>

                            <input type="radio" id="avatar04" name="avatar" value="avatar_04.png"
                                   <c:if test="${user.getAvatar_icon() eq 'avatar_04.png'}">checked</c:if>>
                            <label for="avatar04"><img src="avatars/avatar_04.png" height="40"></label>

                            <input type="radio" id="avatar05" name="avatar" value="avatar_05.png"
                                   <c:if test="${user.getAvatar_icon() eq 'avatar_05.png'}">checked</c:if>>
                            <label for="avatar05"><img src="avatars/avatar_05.png" height="40"></label>

                            <input type="radio" id="avatar06" name="avatar" value="avatar_06.png"
                                   <c:if test="${user.getAvatar_icon() eq 'avatar_06.png'}">checked</c:if>>
                            <label for="avatar06"><img src="avatars/avatar_06.png" height="40"></label>

                            <input type="radio" id="avatar07" name="avatar" value="avatar_07.png"
                                   <c:if test="${user.getAvatar_icon() eq 'avatar_07.png'}">checked</c:if>>
                            <label for="avatar07"><img src="avatars/avatar_07.png" height="40"></label>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dob" class="col-md-3 control-label">Upload Photo</label>
                        <input type="file" name="img[]" class="file" style="visibility: hidden; position: absolute;">
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
                        <!-- Button -->
                        <div class="col-md-offset-3 col-md-9">
                            <button id="btn-signup" type="submit" class="btn btn-info g-recaptcha"
                                    data-sitekey="6LfeHx4UAAAAAAKUx5rO5nfKMtc9-syDTdFLftnm"
                                    data-callback="onSubmit">Save
                            </button>

                            <span style="margin-left:20px; margin-right: 20px;">or</span>

                            <a href="welcome.jsp">
                                <button id="btn-cancel" type="button" class="btn btn-default"> 
                                    Cancel
                                </button>
                            </a>

                            <span style="margin-left:20px; margin-right: 20px;">or</span>

                            <a href="deleteuser">
                                <button id="btn-delete" type="button" class="btn btn-danger">  
                                    Delete
                                </button>
                            </a>
                        </div>
                    </div>&ndash;%&gt;


                </form>
            </div>
        </div>


    </div>


</div>--%>


</body>
</html>
