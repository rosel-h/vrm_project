<%--
  Created by IntelliJ IDEA.
  User: rher490
  Date: 22/01/2018
  Time: 3:49 PM
  To change this template use File | Settings | File Templates.
--%>

<script>
    var searchselect = document.getElementById("searchselect");
    searchselect.addEventListener("change", myFc);

    function myFc() {
        var x = document.getElementById("searchkeyword");
        console.log(searchselect.value());
        if (searchselect.value().eq("date")) {

        } else {

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
        "background12.jpg"
    ];

    function loadRandomImage() {
        var numImage = Math.floor(Math.random() * (imageCollection.length));
        $('#backgroundImage').css('background-image', 'url(/img/' + imageCollection[numImage] + ')');
        console.log(imageCollection[numImage]);
    }

    $(document).ready(function() {
        loadRandomImage();
    });


</script>
<script>
    $(function () {
        $("#datepicker").datepicker();
    });
</script>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% response.setHeader("Cache-Control","no-cache, no-store, must-revalidate"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<c:if test="${sessionScope.personLoggedIn == null}">
    <c:redirect url="Index"/>
</c:if>

<head>

</head>

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
                <li class="nav-item">
                    <a class="nav-link" href="editprofile">My Profile</a>
                </li>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="Main?logout_button=Logout">Log Out</a>--%>
                <%--</li>--%>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Header -->
<header id="backgroundImage" class="masthead" style="background-image: url('img/background02.jpg');">
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
                    <span class="subheading">By the travellers, for the travellers. Make every heartbeat count.</span>
                    <div class="btn-group btn-group-justified col-xs-10" role="group"
                         style="padding: 1%">
                        <div style="padding: 1%;margin: 1%">
                            <a href="myArticles" class="btn btn-default"
                               style=" background-color: white; opacity: 0.8">
                                My Articles
                            </a>
                        </div>
                        <div style="padding: 1%;margin: 1%">
                            <a href="Articles" class="btn btn-default"
                               style=" background-color: white; opacity: 0.8">
                                Community
                            </a>
                        </div>
                        <div style="padding: 1%;margin: 1%">
                            <a href="NewArticle" class="btn btn-danger"
                               style=" color: white;opacity: 0.8">
                                New Article
                            </a>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
</header>
