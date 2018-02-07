<%--
  Created by IntelliJ IDEA.
  User: Rose
  Date: 29/01/2018
  Time: 10:22 PM
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
    <meta charset="utf-8">
    <title>Revising Article: ${articleToEdit.getTitle()}</title>

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
    <!-- Custom scripts for this template -->
    <script src="vendor/js/clean-blog.min.js"></script>
    <script src="vendor/js/featured.js"></script>
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

    <!-- include summernote css/js -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>

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
            $('#summernote').summernote({
                toolbar: [
                    // [groupName, [list of button]]
                    ['style', ['bold', 'italic', 'underline', 'clear']],
                    ['font', ['strikethrough', 'superscript', 'subscript']],
                    ['fontsize', ['fontsize']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                    ['insert', ['picture']]
                ],
                maximumImageFileSize: 2097152,
                height: 600,
                maxWidth: 300,
                popover: {
                    image: [],
                    link: [],
                    air: []
                },
                prettifyHtml: true
            });
            $('#summernote').summernote('insertImage', url, filename);
        });
    </script>
</head>

<body style="background-color: #e6e6e6">
<nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">

    <div id="top" class="container">

        <a class="navbar-brand">Welcome ${sessionScope.get("personLoggedIn")}</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false"
                aria-label="Toggle navigation">Menu
        </button>

        <div class="collapse navbar-collapse float-right" id="navbarResponsive">
            <ul style="float: right" class="navbar-nav ml-auto">
                <li class="nav-item">

                    <a class="nav-link" href="javascript:window.history.back()">back</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Welcome">Home</a>
                </li>
            </ul>
        </div>

    </div>
</nav>

<header id="backgroundImage" class="masthead">

    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-md-10 col-sm-12 mx-auto" id="headingID">
                <div class="page-heading" style="margin: 10%; padding: 10%">
                    <h2>${articleToEdit.getUsername()}, edit your article below</h2>
                    <span class="meta">Originally posted on ${articleToEdit.getDate()}</span>
                </div>
            </div>
        </div>
    </div>

</header>

<article>
    <div class="container">
        <!--  A form letting users add new articles. -->
        <div class="">

            <div class="">
                <h3 class="post-title">Edit Article
                    <form class="form-inline" action="OneArticle" method="POST" style="display: inline-block; float: right;">
                        <input type="hidden" id="csrfToken1" name="csrfToken" value="${sessionScope.get("csrfSessionToken")}">
                        <input type="hidden" name="operation" value="delete">
                        <input type="hidden" name="articleID" value="${articleToEdit.getArticleID()}">
                        <%--<button style="float: right" type="submit" class="btn btn-danger pull-right">Delete</button>--%>

                        <button type="button" class="btn btn-danger" data-toggle="modal"
                                data-target="#article${articleToEdit.getArticleID()}">Delete
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="article${articleToEdit.getArticleID()}" role="dialog">
                            <div class="modal-dialog modal-sm">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h6 class="modal-title">Are you sure you want to delete the article?</h6>
                                    </div>
                                    <div class="modal-body">
                                        <button type="submit" class="btn btn-danger float-left">Delete</button>
                                        <button type="button" class="btn btn-default float-right" data-dismiss="modal">
                                            Cancel
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </h3>
            </div>
            <div class="">
                <form action="editArticles" method="POST">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" id="title" name="title" class="form-control" maxlength="50" value="${articleToEdit.getTitle()}"
                               required>
                    </div>
                    <div class="form-group">
                        <label for="summernote">Content</label>
                        <textarea id="summernote" name="content" class="form-control" rows="10"
                                  required>${articleToEdit.getContent()}</textarea>
                        <label for="futureDate">Change date published (optional)</label>
                        <input type="date" id="futureDate" name="futureDate" value="new Date()">
                    </div>
                    <div class="form-group">
                        <input type="hidden" name="articleID" value="${articleToEdit.getArticleID()}">
                        <input type="hidden" name="author" value="${articleToEdit.getUsername()}">
                        <input type="hidden" name="operation" value="userHasEditedArticle">
                        <input type="hidden" name="publishedDate" value="${articleToEdit.getDate()}">
                        <input type="hidden" id="csrfToken" name="csrfToken"
                               value="${sessionScope.get("csrfSessionToken")}">
                        <button type="submit" class="btn btn-primary float-right">Done</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</article>
<br>
<%@include file="footer.jsp" %>
</body>
</html>

