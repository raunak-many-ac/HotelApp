<!DOCTYPE html>
<html>

<head>
    <title>Home</title>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="/homeCss/style.css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <!-- Our Custom CSS -->

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js"
            integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ"
            crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js"
            integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY"
            crossorigin="anonymous"></script>


</head>

<body>

<div class="wrapper">
    <!-- Sidebar  -->
    <nav id="sidebar" class=".fixed-left">
        <div class="sidebar-header">
            <h3>CoSMOS</h3>
            <strong>C</strong>
        </div>

        <ul class="list-unstyled components">
            <li class="${activeHome}">
                <a href="/">
                    <i class="material-icons">
                        home
                    </i>
                    Home
                </a>
            </li>
            <li class="${activeEvent}">
                <a href="/event/getLocalEventPage">
                    <i class="material-icons">whatshot</i>
                    Events
                </a>
            </li>
            <li class="${activeNotice}">
                <a href="/notices">
                    <i class="material-icons">
                        notifications
                    </i>
                    Notice
                </a>
            </li>
            <li>
                <a href="${activeContact}">
                    <i class="material-icons">
                        contact_support
                    </i>
                    Contact
                </a>
            </li>
        </ul>

        <ul class="list-unstyled CTAs">
            <li class="${activeManageAccounts}">
                <a href="${manageAccounts}" class="download">Manage Accounts</a>
            </li>
            <li>
                <a href="/logout" class="article">Logout</a>
            </li>
        </ul>
    </nav>

    <!-- Page Content  -->
    <div class="container-fluid">

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">

                <button type="button" id="sidebarCollapse" class="btn btn-outline-warning">
                    <i class="fas fa-align-left"></i>
                    <span>Navigate</span>
                </button>
                <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fas fa-align-justify"></i>
                </button>


            </div>
        </nav>

        <!--        Welcome card-->
        <div id="content">
            <div class="card-container">
                <div class="upper-container">
                    <div id="welcome">
                        <br>
                        <h5 class="blink">${college}</h5>
                        <h5 class="blink">${branch}</h5>
                        <br>
                        <h1 class="blink">Welcome</h1>
                    </div>


                    <!--                    Image slider-->
                </div>

                <div id="slides" class="carousel slide" data-ride="carousel">
                    <ul class="carousel-indicators">
                        <li data-target="#slides" data-slide-to="0" class="active"></li>
                        <li data-target="#slides" data-slide-to="1"></li>
                        <li data-target="#slides" data-slide-to="2"></li>
                    </ul>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="hardCodedImages/lottie/easy_to_user.gif" class="img">
                        </div>
                        <div class="carousel-item">
                            <img src="hardCodedImages/lottie/working-room.gif" class="img">
                        </div>
                        <div class="carousel-item">
                            <img src="hardCodedImages/lottie/office_two_people.gif" class="img">
                        </div>
                    </div>
                </div>
                <div class="lower-container">
                    <div>
                        <h4>${name}</h4>


                    </div>
                    <div >
                        <h3>Your Privilages</h3>
                        <ul>
                            <li class="card">${privilage1}</li>
                            <li class="card">${privilage2}</li>
                            <li class="card">${privilage3}</li>
                            <li class="card">${privilage4}</li>
                        </ul>
                    </div>
                    <br>
                    <br>


                </div>

            </div>

        </div>

    </div>
</div>
<!-- Footer -->
<div class="footer">

    <!-- Footer Elements -->
    <div class="footer-copyright text-center py-3" style="text-color:white">© 2019 Copyright:
        <a href="#">Cosmos Company</a>
    </div>
    <!-- Copyright -->

</div>

</div>
</div>

<!-- Popper.JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
        integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
        crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
        integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
        crossorigin="anonymous"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $('#sidebarCollapse').on('click', function () {
            $('#sidebar').toggleClass('active');
        });
    });
</script>
</body>

</html>