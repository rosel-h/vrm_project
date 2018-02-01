<%--
  Created by IntelliJ IDEA.
  User: Mengjie
  Date: 2018/1/30
  Time: 13:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Index"/>
</c:if>

<html>
<head>
    <title>Save profile successfully | VRM Blog</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="saveprofilesuccess" style="margin-top:50px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
    <div class="panel panel-info">

        <div class="panel-heading">
            <div class="panel-title">${successMessage}</div>
        </div>

        <div class="panel-body">
            <div class="control-label">You will be directed to welcome page in <span id="countdown">6</span> seconds</div>
            <script type="text/javascript">

                // Total seconds to wait
                var seconds = 4;

                function countdown() {
                    seconds = seconds - 1;
                    if (seconds < 0) {
                        // Chnage your redirection link here
                        window.location = "welcome.jsp";
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
                <div class="control-label">Or click <ins><a href="welcome.jsp">here</a></ins> to login!</div>
            </c:if>
        </div>
    </div>


</div>

</body>
</html>
