<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>COSMOS</title>
    <script
            src="https://code.jquery.com/jquery-3.4.0.min.js"
            integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg="
            crossorigin="anonymous"></script>
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }

        function checkUser() {
            email = document.getElementById("email_sign_up")
            $.ajax({
                url:"/data/checkUser",
                data:{
                    "email":email.value
                },
                success:function (result) {
                    if(result==true)
                        email.setCustomValidity("User Already Exists");
                    else
                        email.setCustomValidity('');
                }
            })
        }

        function validatePassword(){

            var password = document.getElementById("password")
                , confirm_password = document.getElementById("password_confirm");

            if(password.value != confirm_password.value) {
                confirm_password.setCustomValidity("Passwords Don't Match");
            } else {
                confirm_password.setCustomValidity('');
            }
        }

    </script>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.7.2/css/all.min.css"
    />
    <link rel="stylesheet" href="/login/style.css" />
</head>
<body>
<canvas id="sky"></canvas>
<!-- partial:index.partial.html -->

<div class="container" id="container">
    <div class="form-container sign-up-container">
        <form id=sign-up-form" action="/signUp" method="post">
            <h1>Create Account</h1>
            <div class="social-container">
                <a href="/facebook/login" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="/google/login" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="/linkedin/login" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>or use your email for registration</span>
            <input type="text" name="name" placeholder="Name" required="">
            <input id="email_sign_up" onchange="checkUser()" type="email" name="email" placeholder="Email" required="">
            <input id="password" onchange="validatePassword()" type="password" name="password" placeholder="Password" required="">
            <button type="submit">Sign Up</button>
        </form>
    </div>
    <div class="form-container sign-in-container">

        <form action="/login" method="post">
            <h1>Sign in</h1>
            <div class="social-container">
                <a href="/facebook/login" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="/google/login" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="/linkedin/login" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>or use your account</span>
            <span style="color:${color}">${message}</span>
            <input type="email" name="email" placeholder="Username" required="required">
            <input type="password" name="password" placeholder="Password" required="required">
            <a href="#">Forgot your password?</a>
            <button type="submit">Sign In</button>
        </form>
    </div>
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>Welcome!</h1>
                <p>
                    Already have an account? <br />
                    Please login with your registered email address and password.
                </p>
                <button class="ghost" id="signIn">Sign In</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>Hello, Friend!</h1>
                <p>Don't have an Account? Register Now!!!</p>
                <button class="ghost" id="signUp">Sign Up</button>
            </div>
        </div>
    </div>
</div>

<!-- partial -->
<script src="/login/sky.js"></script>
<script src="/login/script.js"></script>
</body>
</html>
