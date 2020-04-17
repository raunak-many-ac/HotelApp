<!DOCTYPE html>
<html>

<head>
    <title>All Notices</title>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet"  href="/noticeCss/style.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>


    <script>
        function showAllNoticeCards() {
            var card_holder = document.getElementById("card-holder");
            $.ajax({
                url: "/notice/cards",
                method: "GET",
                success: function(result) {
                    card_holder.innerHTML = result;
                },
                error: function(error) {
                    console.log(JSON.stringify(error));
                }
            });
        }

        function showCollegeNoticesCards() {
            var card_holder = document.getElementById("card-holder");
            $.ajax({
                url: "/notice/CollegeNoticesCards",
                method: "GET",
                success: function(result) {
                    card_holder.innerHTML = result;
                },
                error: function(error) {
                    console.log(JSON.stringify(error));
                }
            });
        }

        function showBranchNoticeCards() {
            var card_holder = document.getElementById("card-holder");
            $.ajax({
                url: "/notice/DepartmentCards",
                method: "GET",
                success: function(result) {
                    card_holder.innerHTML = result;
                },
                error: function(error) {
                    console.log(JSON.stringify(error));
                }
            });
        }

        function search() {
            var search_value = document.getElementById("search-box").value;
            var card_holder = document.getElementById("card-holder");
            $.ajax({
                url: "/notice/searchHtml?keyword=" + search_value,
                async: true,
                method: "GET",
                success: function(result) {
                    card_holder.innerHTML = result;
                }
            });
        }
    </script>

</head>

<body onload="${showMethod}">

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
                        <li class="nav-item ${active1}">
                            <a class="nav-link" href="/notices/getCollegeNoticePage">College Notice</a>
                        </li>
                        <li class="nav-item ${active2}">
                            <a class="nav-link" href="/notices/getBranchNoticePage">Branch Notice</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Cosmos Notice</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="add-notice">
            ${add_notice_button}
        </div>


        <div class="modal fade" id="notice-form" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <form id="notice-data-form" enctype="multipart/form-data" action="/notices/add" method="post">
                        <div class="form-group">
                            <div class="modal-header">
                                <h4 class="modal-title">Add Notice here</h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label class="control-label" for="topic">Topic</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <input id="topic" class="form-control form-horizontal" required="required" type="text" name="topic" placeholder="Topic">
                                    </div>
                                </div>
                                <br>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label class="control-label" for="college-id">College</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select id="college-id" class="form-control form-horizontal" required="required" name="collegeId">
                                            <option value="Sir M. Visvesvaraya Institute Of Technology">Sir M. Visvesvaraya Institute Of Technology</option>
                                        </select>
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label class="control-label" for="date">Date</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <input id="date" class="form-control form-horizontal" required="required" type="date" name="noticeDate">
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label class="control-label" for="notice-file">Upload Notice File</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <input class="form-control form-horizontal" id="notice-file" type="file" name="noticeFile">
                                    </div>
                                </div>
                                <br>

                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-success">Save</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <div id="card-holder" class="container">
            <div class="row justify-content-center">
            </div>
        </div>
    </div>
</div>

<!-- jQuery CDN - Slim version (=without AJAX) -->
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