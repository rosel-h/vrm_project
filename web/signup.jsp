<%--
  Created by IntelliJ IDEA.
  User: mshe666
  Date: 23/01/2018
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>

<body>


<div id="signupbox" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
    <div class="panel panel-info">
        <div class="panel-heading">
            <div class="panel-title">Sign Up</div>
            <div style="float:right; font-size: 85%; position: relative; top:-10px"><a id="signinlink" href="#" onclick="$('#signupbox').hide(); $('#loginbox').show()">Sign In</a></div>
        </div>
        <div class="panel-body" >
            <form id="signupform" class="form-horizontal" role="form" method="post" action="/SignUp">

                <div id="signupalert" style="display:none" class="alert alert-danger">
                    <p>Error:</p>
                    <span></span>
                </div>

                <div class="form-group">
                    <label for="username" class="col-md-3 control-label">Username</label>
                    <div class="col-md-9">
                        <input type="text" id="username" class="form-control" name="username" placeholder="Enter Username 4~20 characters">
                        <div style="color:red">${usernameError}</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password" class="col-md-3 control-label">Password</label>
                    <div class="col-md-9">
                        <input type="password" id="password" class="form-control" name="password" placeholder="Enter Password 4~20 characters">
                    </div>
                </div>

                <div class="form-group">
                    <label for="cPassword" class="col-md-3 control-label">Confirm Password</label>
                    <div class="col-md-9">
                        <input type="password" id="cPassword" class="form-control" name="cPassword" placeholder="Confirm Password">
                        <div style="color:red">${passwordError}</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="fname" class="col-md-3 control-label">First Name</label>
                    <div class="col-md-9">
                        <input type="text" id="fname" class="form-control" name="fname" placeholder="Enter First Name">
                    </div>
                </div>

                <div class="form-group">
                    <label for="lname" class="col-md-3 control-label">Last Name</label>
                    <div class="col-md-9">
                        <input type="text" id="lname" class="form-control" name="lname" placeholder="Enter Last Name">
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
                </div>

                <div class="form-group">
                    <label for="dob" class="col-md-3 control-label">Choose Your Profile Photo</label>
                    <div class="col-md-9">

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

                <div class="form-group">
                    <!-- Button -->
                    <div class="col-md-offset-3 col-md-9">
                        <button id="btn-signup" type="submit" class="btn btn-info">Sign Up</button>
                        <span style="margin-left:8px;">or</span>
                    </div>
                </div>

                <div style="border-top: 1px solid #999; padding-top:20px"  class="form-group">

                    <div class="col-md-offset-3 col-md-9">
                        <button id="btn-fbsignup" type="button" class="btn btn-primary"><i class="icon-facebook"></i>   Sign Up with Facebook</button>
                    </div>

                </div>



            </form>
        </div>
    </div>



</div>

</body>
</html>
