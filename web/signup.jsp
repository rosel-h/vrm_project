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
</head>
<body>

<form method="get" action="/SignUp">
    <label>Username</label>
    <input type="text" name="username" minlength="4" maxlength="10"/>
    <br/>

    <label>Password</label>
    <input type="password" name="password" minlength="4" maxlength="10"/>
    <br/>

    <label>Confirm Password</label>
    <input type="password" name="cPassword" minlength="4" maxlength="10"/>
    <br/>

    <label>First Name</label>
    <input type="text" name="fname" minlength="1" maxlength="10"/>
    <br/>

    <label>Last Name</label>
    <input type="text" name="lname" minlength="1" maxlength="10"/>
    <br/>

    <label>Date of Birth</label>
    <input type="date" name="dob"/>
    <br/>

    <label>Country</label>
    <select name="country">
        <option value="nz" selected>New Zealand</option>
        <option value="aus">Australia</option>
        <option value="in">India</option>
        <option value="us">United States</option>
        <option value="other">other</option>
    </select>
    <br/>

    <label>Description</label>
    <br/>
    <textarea name="description" rows="4" cols="40">
write something about yourself
    </textarea>
    <br/>
    
    <label>Choose Avatar</label>
    <br/>
    <input type="radio" id="avatar01" name="avatar" value="avatar_01.png">
    <label for="avatar01"><img src="avatars/avatar_01.png" height="40"></label>

    <input type="radio" id="avatar02" name="avatar" value="avatar_02.png">
    <label for="avatar02"><img src="avatars/avatar_02.png" height="40"></label>

    <input type="radio" id="avatar03" name="avatar" value="avatar_03.png">
    <label for="avatar03"><img src="avatars/avatar_03.png" height="40"></label>

    <input type="radio" id="avatar04" name="avatar" value="avatar_04.png">
    <label for="avatar04"><img src="avatars/avatar_04.png" height="40"></label>

    <button type="submit">Sign Up</button>
    

</form>
</body>
</html>
