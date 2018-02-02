<html>
<head>
    <script>
        function onSubmit(token) {
//            alert('thanks ' + document.getElementById('field').value);
            document.getElementById("signupform").submit();
        }

        function validate(event) {
            event.preventDefault();
            grecaptcha.execute();

        }

        function onload() {
            var element = document.getElementById('submit');
            element.onclick = validate;
        }
    </script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>
<form method="POST" action="SignUp" id="signupform">
    Name: (required) <input id="field" name="field">
    <div id='recaptcha' class="g-recaptcha"
         data-sitekey="6LeL70MUAAAAADAjeDRuGsj8vXmrkhH1gckIEd4m"
         data-callback="onSubmit"
         data-size="invisible"></div>
    <button id='submit'>submit</button>
</form>
<script>onload();</script>
</body>
</html>