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
    <input type="text"/>
    <br/>

    <label>Password</label>
    <input type="password"/>
    <br/>

    <label>Confirm Password</label>
    <input type="password"/>
    <br/>

    <label>First Name</label>
    <input type="text"/>
    <br/>

    <label>Last Name</label>
    <input type="text"/>
    <br/>

    <label>Date of Birth</label>
    <input type="date"/>
    <br/>

    <label>Country</label>
    <select name="countryName">
        <option value="nz" selected>New Zealand</option>
        <option value="aus">Australia</option>
        <option value="in">India</option>
        <option value="us">United States</option>
        <option value="other">other</option>
    </select>
    <br/>

    <label>Description</label>
    <textarea rows="4"
              cols="40">
write something about yourself
    </textarea>




</form>
</body>
</html>
