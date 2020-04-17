<!DOCTYPE html>
<html>

<head>
    <title>All Events</title>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet"  href="/indexCss/style.css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <!-- Our Custom CSS -->

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>


    <script>
        function search(){
            var search_value = document.getElementById("search-box").value;
            var card_holder = document.getElementById("card-holder");
            $.ajax({
                url:"/events/searchHtml?keyword="+search_value,
                async:true,
                method:"GET",
                success:function (result) {
                    card_holder.innerHTML = result;
                }
            });
        }
        function getEvents() {
            var card_holder = document.getElementById("card-holder");
            $.ajax({
                    url: "/events/cards",
                    method: "GET",
                    success: function (result) {
                        card_holder.innerHTML = result;
                    },
                    error: function (error) {
                        console.log(JSON.stringify(error));
                    }
                }
            );
        }
        function getLocalEvents() {
            var card_holder = document.getElementById("card-holder");
            $.ajax({
                    url: "/events/localEventCards",
                    method: "GET",
                    success: function (result) {
                        card_holder.innerHTML = result;
                    },
                    error: function (error) {
                        console.log(JSON.stringify(error));
                    }
                }
            );
        }
    </script>

</head>

<body onload="${method}">

<div class="wrapper">
    <!-- Sidebar  -->
    <nav id="sidebar" class=".fixed-left">
        <div class="sidebar-header">
            <h3>Cosmos</h3>
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
            <li class ="${activeManageAccounts}">
                <a href="${manageAccounts}" class="download">Manage Accounts</a>
            </li>
            <li>
                <a href="/logout" class="article">Logout</a>
            </li>
        </ul>
    </nav>

    <!-- Page Content  -->
    <div id="content">

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">

                <button type="button" id="sidebarCollapse" class="btn btn-outline-warning">
                    <i class="fas fa-align-left"></i>
                    <span>Navigate</span>
                </button>
                <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="fas fa-align-justify"></i>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="nav navbar-nav ml-auto">
                        <li class="nav-item ${active_global_events}">
                            <a class="nav-link" href="/event">Global Events</a>
                        </li>
                        <li class="nav-item ${active_local_events}">
                            <a class="nav-link" href="/event/getLocalEventPage">Local Events</a>
                        </li>
                    </ul>
                    <form class="form-inline">
                        <input id="search-box" class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" onkeyup="search()">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="search()">Search</button>
                    </form>
                </div>
            </div>
        </nav>

        <div class="add-event">
            ${add_event_button}
        </div>


        <div class="modal fade" id="event-form" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <form id="event-data-form" enctype="multipart/form-data" action="/event/add" method="post">
                        <div class="modal-header">
                            <h4 class="modal-title">Modal Heading</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-name">EventName:</label></div>
                                <div class="col-sm-8">
                                    <input id="event-name" class="form-control form-horizontal" required="required" type="text" name="eventName"><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-location">EventLocation:</label></div>
                                <div class="col-sm-8">
                                    <input id="event-location" class="form-control form-horizontal" required="required" type="text" name="location"><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-organiser">Event Organiser:</label></div>
                                <div class="col-sm-8">
                                    <input id="event-organiser" class="form-control form-horizontal" required="required" type="text" name="organiser"><br>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-organiser-phone">Event Organiser Phone:</label></div>
                                <div class="col-sm-8">
                                    <input id="event-organiser-phone" class="form-control form-horizontal" required="required" type="text" name="organiser_phone"><br>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-date">Event Date</label></div>
                                <div class="col-sm-8">
                                    <input id ="event-date"  class="form-control form-horizontal" required="required" type="date" name="eventDate"><br>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-type">Event Type</label></div>
                                <div class="col-sm-8">
                                    <select id ="event-type" class="form-control form-horizontal" required="required" name="eventType">
                                        <option value="Technical">Technical</option>
                                        <option value="Music">Music</option>
                                        <option value="Dance">Dance</option>
                                        <option value="Drama and Art">Drama and Art</option>
                                        <option value="Entertainment">Entertainment</option>
                                    </select>
                                    <br>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="local-event">Local Event</label></div>
                                <div class="col-sm-8">
                                    <select id="local-event" class="form-control form-horizontal" required="required" name="localEvents">
                                        <option value="YES">YES</option>
                                        <option value="NO">NO</option>
                                    </select>
                                </div>
                                <br>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-description">Event Description</label></div>
                                <div class="col-sm-8">
                                    <input id="event-description" class="form-control form-horizontal" required="required" type="text" name="description"><br>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-Rules">Event Rules</label></div>
                                <div class="col-sm-8">
                                    <input id="event-Rules" class="form-control form-horizontal" required="required" type="text" name="eventRules"><br>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="event-image">Event Image</label></div>
                                <div class="col-sm-8">
                                    <input id="event-image" class="form-control form-horizontal" type="file" name="image" ><br>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="control-label" for="cover-image">Background Image</label></div>
                                <div class="col-sm-8">
                                    <input id="cover-image" class="form-control form-horizontal" type="file" name="coverImage" ><br>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Save</button>
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>


        <div id="card-holder" class="container">
            <div class="row justify-content-center">
            </div>
        </div>
        <section>
            <div class="wave-bottom wave1"></div>
            <div class="wave-bottom wave2"></div>
            <div class="wave-bottom wave3"></div>
            <div class="wave-bottom wave4"></div>
        </section>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

<script type="text/javascript">
    $(document).ready(function () {
        $('#sidebarCollapse').on('click', function () {
            $('#sidebar').toggleClass('active');
        });
    });
</script>
</body>

</html>