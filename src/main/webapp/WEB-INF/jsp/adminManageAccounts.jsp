<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Manage Accounts</title>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="/manageAccountsCss/style.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js"></script>



    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <script>
        function openDeleteDialog(email, branchName) {
            document.getElementById("branch-name").innerText = branchName
            $('#deleteConfirm').modal('show');
            $("#deleteYes").val(email)

        }

        function deleteData(){
            email = $("#deleteYes").val()
            $.ajax({
                type: "GET",
                url: "/admin/deleteFaculty/"+email,
                data: { name: "abc", age: "20" },
                success:function(response){
                    setInterval('refreshPage()', 1000);
                    alert(email)
                    $('#deleteConfirm').modal('hide');
                },
                error: function (error) {
                    console.log(JSON.stringify(error));
                    setInterval('refreshPage()', 1000);
                }
            })

        }
        function refreshPage() {
            location.reload();
        }
        function updateAdminDialogue(branchName,facultyName,facultyEmail) {
            document.getElementById("branchName").value =branchName
            document.getElementById("facultyName").value =facultyName
            document.getElementById("facultyEmail").value =facultyEmail
            $('#updateAdminForm').modal('show');
        }

        /*
        {"branchID":"IS","collegeID":"1MV","collegeName":"Sir M. Visvesvaraya Institute Of Technology","branchName":"Information Science and Engineering","hod":"Dr. P. Vijaykarthik"}
         */
        function getData() {
            let tableData=document.getElementById("facultyData").innerHTML;
            $.ajax({
                url:"/admin/getFaculty",
                async:false,
                method:"GET",
                success:function(result) {
                    for(data in result){
                        let value = result[data]
                        let branch = value["branchName"]
                        let facultyName = value["name"]
                        let email = value["email"]


                        tableData+='<tr><td>'+ branch +'</td>' +
                            '<td>'+ facultyName +'</td>' +
                            '<td>'+ email +'</td>' +
                            '<td data-toggle="modal" data-target="#addUpdate">\n' +
                            '                            <a class="edit" data-id='+email+' title="Edit" onclick="updateAdminDialogue(\''+email+'\',\''+branch+'\',\''+facultyName+ '\')" ><i class="material-icons">&#xE254;</i></a></td>\n' +
                            '                        <td>\n' +
                            '                            <a class="delete" title="Delete" onclick="openDeleteDialog(\''+ email +'\',\''+ branch + '\')"><i class="material-icons">&#xE872;</i></a>\n' +
                            '                        </td></tr>';

                    }
                    document.getElementById("facultyData").innerHTML = tableData;
                }

            });
        }

    </script>

</head>

<body onload="getData()">

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
                        <li class="nav-item ${adminManageActive}">
                            <a class="nav-link" href="${adminManageAccounts}">FACULTY</a>
                        </li>
                        <li class="nav-item ${batchManipulationActive}">
                            <a class="nav-link" href="${batchManipulation}">BATCH</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-8"><h2> Branches </h2></div>
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-info add-new" data-toggle="modal" data-target="#addAdminForm"><i class="fa fa-plus"></i>Add New</button>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th> Department </th>
                        <th> Faculty</th>
                        <th> Email </th>
                        <th> Edit </th>
                        <th> Delete </th>
                    </tr>
                    </thead>
                    <tbody id="facultyData">
                    </tbody>
                </table>
                ${userAuthorisation}
                ${manageAccounts}
                ${SuccessMessage}



                <!--Modal for adding branch -->
                <div class="modal fade" id="addAdminForm" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <form id="create-admin" action="/admin/addFaculty" method="post">
                                <div class="form-group">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Add Faculty Details here</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="faculty">Name Of Faculty</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="faculty" class="form-control form-horizontal" required="required" type="text" name="facultyName" placeholder="Name">
                                            </div>
                                        </div>
                                        <br>

                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="faculty-email">Faculty email</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="faculty-email" class="form-control form-horizontal" required="required" type="text" name="facultyEmail">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="password">Password</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="password" class="form-control form-horizontal" required="required" type="text" name="password" placeholder="password">
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



                <!--Modal for deleteting branch -->
                <div id="deleteConfirm" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <p class="modal-title" style="margin: 0 auto;">Delete <span id="branch-name"></span></p>
                            </div>
                            <div class="modal-body">
                                <p class="text-center">Are You Sure?</p>
                                <div class="text-center">
                                    <button type="button" class="btn btn-success" data-dismiss="modal" id ="deleteYes" value="" onclick="deleteData()">Yes</button>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>





                <!--update Modal -->
                <div class="modal fade" id="updateAdminForm" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <form id="update-admin" action="/editAdmin" method="post">
                                <div class="form-group">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Add Branch Details here</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="facultyName">Name Of Faculty</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="facultyName" class="form-control form-horizontal" required="required" type="text" name="facultyName" placeholder="Faculty">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="branchName">Branch Name</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input readonly="readonly" id="branchName" class="form-control form-horizontal" required="required" type="text" name="branchName" placeholder="Branch" >
                                            </div>
                                        </div><br>

                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="facultyEmail">email</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="facultyEmail" class="form-control form-horizontal" required="required" type="text" name="facultyEmail">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="pass">Password</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="pass" class="form-control form-horizontal" required="required" type="text" name="password" placeholder="password">
                                            </div>
                                        </div>
                                        <br>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-success" >Save</button>
                                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
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