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

<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile | VRM BLOG</title>
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
    <div id="top" class="container">
        <a class="navbar-brand" href="Welcome">Welcome ${personLoggedIn}</a>
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
            <div class="col-lg-8 col-md-10 col-sm-12 mx-auto" id="headingID">
                <div class="page-heading" style="margin: 10% 0 5%; padding: 1% 0 0 0;">
                    <div class=" col-lg-4 col-4 col-md-4 col-sm-4 offset-4">
                        <img src="avatars/${sessionScope.user.getAvatar_icon()}" alt="avatar"
                             style="border-radius:50%;padding-top: 10%"
                             class="img-fluid">
                    </div>
                    <span class="subheading">My Profile</span>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <form id="signupform" class="form-horizontal" role="form" method="post" action="editprofile"
          enctype="multipart/form-data">
        <div class="row">
            <div class="col-xs-12 col-lg-6">
                <div class="form-group">
                    <input type="hidden" id="csrfToken" name="csrfToken"
                           value="${sessionScope.get("csrfSessionToken")}">
                    <label for="fname" class="control-label">First Name</label>
                    <div class="col-md-9">
                        <input type="text" id="fname" class="form-control" name="fname"
                               value="${sessionScope.user.getFname()}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="lname" class="control-label">Last Name</label>
                    <div class="col-md-9">
                        <input type="text" id="lname" class="form-control" name="lname"
                               value="${sessionScope.user.getLname()}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="dob" class="control-label">Date of Birth</label>
                    <div class="col-md-9">
                        <input type="date" id="dob" class="form-control" name="dob"
                               value="${sessionScope.user.getDateOfBirth()}">
                    </div>
                </div>

                <div class="form-group">
                    <label for="country" class="control-label">Country</label>
                    <div class="col-md-9">
                        <select name="country" id="country" class="form-control">
                            <option value="nz" <c:if test="${sessionScope.user.getCountry() eq 'nz'}">selected</c:if>>
                                New
                                Zealand
                            </option>
                            <option value="aus" <c:if test="${sessionScope.user.getCountry() eq 'au'}">selected</c:if>>
                                Australia
                            </option>
                            <option value="in" <c:if test="${sessionScope.user.getCountry() eq 'in'}">selected</c:if>>
                                India
                            </option>
                            <option value="us" <c:if test="${sessionScope.user.getCountry() eq 'us'}">selected</c:if>>
                                United
                                States
                            </option>
                            <option value="other"
                                    <c:if test="${sessionScope.user.getCountry() eq 'other'}">selected</c:if>>
                                Other
                            </option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="security_q" class="control-label">Security Question</label>
                    <div class="col-md-9">
                        <select name="security_q" id="security_q" class="form-control" required>
                            <option value="secret_key"
                                    <c:if test="${sessionScope.user.getSecurity_q() eq 'secret_key'}">selected</c:if>>
                                Secret Key (Alphanumeric)
                            </option>
                            <option value="dad_fname"
                                    <c:if test="${sessionScope.user.getSecurity_q() eq 'dad_fname'}">selected</c:if>>
                                What's your Dad's first name?
                            </option>
                            <option value="pet_name"
                                    <c:if test="${sessionScope.user.getSecurity_q() eq 'pet_name'}">selected</c:if>>
                                What's your first pet's name?
                            </option>
                            <option value="bestf_fname"
                                    <c:if test="${sessionScope.user.getSecurity_q() eq 'bestf_fname'}">selected</c:if>>
                                What's your best friend's first name?
                            </option>
                            <option value="hometown"
                                    <c:if test="${sessionScope.user.getSecurity_q() eq 'hometown'}">selected</c:if>>
                                Where's your home town?
                            </option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="security_a" class="control-label">Security Answer</label>
                    <div class="col-md-9">
                        <input type="text" id="security_a" class="form-control" name="security_a"
                               value="${sessionScope.user.getSecurity_a()}" required>
                    </div>
                </div>

            </div>
            <div class="col-xs-12 col-lg-6">
                <div class="form-group">
                    <label for="description" class="ccontrol-label">Description</label>
                    <div>
                        <textarea id="description" class="form-control" name="description" rows="4"
                                  columns="40">${sessionScope.user.getDescription()}</textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label for="dob" class="control-label">Profile Photo</label>
                    <div>

                        <input type="radio" id="avatar01" name="avatar" value="avatar_01.png"
                               <c:if test="${sessionScope.user.getAvatar_icon() eq 'avatar_01.png'}">checked</c:if>>
                        <label for="avatar01"><img src="avatars/avatar_01.png" height="40"></label>

                        <input type="radio" id="avatar02" name="avatar" value="avatar_02.png"
                               <c:if test="${sessionScope.user.getAvatar_icon() eq 'avatar_02.png'}">checked</c:if>>
                        <label for="avatar02"><img src="avatars/avatar_02.png" height="40"></label>

                        <input type="radio" id="avatar03" name="avatar" value="avatar_03.png"
                               <c:if test="${sessionScope.user.getAvatar_icon() eq 'avatar_03.png'}">checked</c:if>>
                        <label for="avatar03"><img src="avatars/avatar_03.png" height="40"></label>

                        <input type="radio" id="avatar04" name="avatar" value="avatar_04.png"
                               <c:if test="${sessionScope.user.getAvatar_icon() eq 'avatar_04.png'}">checked</c:if>>
                        <label for="avatar04"><img src="avatars/avatar_04.png" height="40"></label>

                        <input type="radio" id="avatar05" name="avatar" value="avatar_05.png"
                               <c:if test="${sessionScope.user.getAvatar_icon() eq 'avatar_05.png'}">checked</c:if>>
                        <label for="avatar05"><img src="avatars/avatar_05.png" height="40"></label>

                        <input type="radio" id="avatar06" name="avatar" value="avatar_06.png"
                               <c:if test="${sessionScope.user.getAvatar_icon() eq 'avatar_06.png'}">checked</c:if>>
                        <label for="avatar06"><img src="avatars/avatar_06.png" height="40"></label>

                        <input type="radio" id="avatar07" name="avatar" value="avatar_07.png"
                               <c:if test="${sessionScope.user.getAvatar_icon() eq 'avatar_07.png'}">checked</c:if>>
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
                        <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                data-target="#deleteProfile">Delete
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="deleteProfile" role="dialog">
                            <div class="modal-dialog modal-sm">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h6 class="modal-title">Are you sure you want to delete your profile?</h6>
                                    </div>
                                    <div class="modal-body">
                                        Your articles and comments will still be accessible on the website, but you will
                                        never access them again.
                                        Ever.
                                    </div>
                                    <div class="modal-body">
                                        <button id="btn-delete"
                                                onclick="window.location.href='deleteuser?csrfToken=${sessionScope.get('csrfSessionToken')}'"
                                                type="button" class="btn btn-danger">  
                                            Delete
                                        </button>
                                        <button type="button" class="btn btn-default float-right" data-dismiss="modal">
                                            Cancel
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>


<%@include file="footer.jsp" %>


</body>
</html>
