<%--
  Created by IntelliJ IDEA.
  User: Mengjie
  Date: 2018/1/26
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>My Profile | VRM BLOG</title>
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

</head>
<body>
<div class="container">
    <div id="signupbox" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
        <div class="panel panel-info">

            <div class="panel-heading">
                <div class="panel-title">My Profile</div>
            </div>

            <div class="panel-body">
                <form id="signupform" class="form-horizontal" role="form" method="post" action="editprofile" enctype='multipart/form-data'>

                    <div id="signupalert" style="display:none" class="alert alert-danger">
                        <p>Error:</p>
                        <span></span>
                    </div>

                    <div class="form-group">
                    <div class="col-md-3">
                        <img src="avatars/${user.getAvatar_icon()}" alt="avatar" style="width: 100%" class="img-circle">
                    </div>
                    <%--<div>--%>
                        <%--<span class="col-md-3 control-label">Hello ${user.getUsername()}</span>--%>
                    <%--</div>--%>

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
                            <input type="date" id="dob" class="form-control" name="dob" value="${user.getDateOfBirth()}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="country" class="col-md-3 control-label">Country</label>
                        <div class="col-md-9">
                            <select name="country" id="country" class="form-control">
                                <option value="nz" <c:if test="${user.getCountry() eq 'nz'}">selected</c:if>>New Zealand</option>
                                <option value="aus" <c:if test="${user.getCountry() eq 'au'}">selected</c:if>>Australia</option>
                                <option value="in" <c:if test="${user.getCountry() eq 'in'}">selected</c:if>>India</option>
                                <option value="us" <c:if test="${user.getCountry() eq 'us'}">selected</c:if>>United States</option>
                                <option value="other" <c:if test="${user.getCountry() eq 'other'}">selected</c:if>>other</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
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

                            <input type="radio" id="avatar01" name="avatar" value="avatar_01.png" <c:if test="${user.getAvatar_icon() eq 'avatar_01.png'}">checked</c:if>>
                            <label for="avatar01"><img src="avatars/avatar_01.png" height="40"></label>

                            <input type="radio" id="avatar02" name="avatar" value="avatar_02.png" <c:if test="${user.getAvatar_icon() eq 'avatar_02.png'}">checked</c:if>>
                            <label for="avatar02"><img src="avatars/avatar_02.png" height="40"></label>

                            <input type="radio" id="avatar03" name="avatar" value="avatar_03.png" <c:if test="${user.getAvatar_icon() eq 'avatar_03.png'}">checked</c:if>>
                            <label for="avatar03"><img src="avatars/avatar_03.png" height="40"></label>

                            <input type="radio" id="avatar04" name="avatar" value="avatar_04.png" <c:if test="${user.getAvatar_icon() eq 'avatar_04.png'}">checked</c:if>>
                            <label for="avatar04"><img src="avatars/avatar_04.png" height="40"></label>

                            <input type="radio" id="avatar05" name="avatar" value="avatar_05.png" <c:if test="${user.getAvatar_icon() eq 'avatar_05.png'}">checked</c:if>>
                            <label for="avatar05"><img src="avatars/avatar_05.png" height="40"></label>

                            <input type="radio" id="avatar06" name="avatar" value="avatar_06.png" <c:if test="${user.getAvatar_icon() eq 'avatar_06.png'}">checked</c:if>>
                            <label for="avatar06"><img src="avatars/avatar_06.png" height="40"></label>

                            <input type="radio" id="avatar07" name="avatar" value="avatar_07.png" <c:if test="${user.getAvatar_icon() eq 'avatar_07.png'}">checked</c:if>>
                            <label for="avatar07"><img src="avatars/avatar_07.png" height="40"></label>

                        </div>
                    </div>

                    <div class="form-group">
                        <label for="dob" class="col-md-3 control-label">Upload Photo</label>
                        <input type="file" name="img[]" class="file" style="visibility: hidden; position: absolute;">
                        <div class="input-group col-md-8">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-picture"></i></span>
                            <input type="text" class="form-control input" name="uploadAvatar" disabled placeholder="Upload Image">
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
                        $(document).on('click', '.browse', function(){
                            var file = $(this).parent().parent().parent().find('.file');
                            file.trigger('click');
                        });
                        $(document).on('change', '.file', function(){
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
                    </div>



                </form>
            </div>
        </div>


    </div>



</div>


</body>
</html>
