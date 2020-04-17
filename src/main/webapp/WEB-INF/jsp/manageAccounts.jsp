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

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js"></script>



    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <script>
        function openDeleteDialog(branchId, branchName) {
            document.getElementById("branchName").innerText = branchName
            $('#deleteConfirm').modal('show');
            $("#deleteYes").val(branchId)

        }
        
        function deleteData(){
            branchId = $("#deleteYes").val()
            $.ajax({
                type: "POST",
                url: "/delAdmin/"+branchId,
                data: { name: "abc", age: "20" },
                success:function(response){
                    alert(branchId)
                    $('#deleteConfirm').modal('hide');
                }
            })

        }
        function updateAdminDialogue(branchId,branchName,hodName,hodEmail) {
                 document.getElementById("branchName").value =branchName
                document.getElementById("branchId").value =branchId
                document.getElementById("hodName").value =hodName
                 document.getElementById("hodEmail").value =hodEmail
                $('#updateAdminForm').modal('show');
        }

        /*
        {"branchID":"IS","collegeID":"1MV","collegeName":"Sir M. Visvesvaraya Institute Of Technology","branchName":"Information Science and Engineering","hod":"Dr. P. Vijaykarthik"}
         */
        function getData() {
            let tableData=document.getElementById("branchData").innerHTML;
            $.ajax({
                url:"/getAllBranches",
                async:false,
                method:"GET",
                success:function(result) {
                    for(data in result){
                        let value = result[data]
                        let branch = value["branchName"]
                        let hod = value["hod"]
                        let email = value["emailHod"]
                        let branchId=value["branchID"]


                        tableData+='<tr><td>'+ branch +'</td>' +
                            '<td>'+ hod +'</td>' +
                            '<td>'+ email +'</td>' +
                            '<td data-toggle="modal" data-target="#addUpdate">\n' +
                            '                            <a class="edit" data-id='+branchId+' title="Edit" onclick="updateAdminDialogue(\''+branchId+'\',\''+branch+'\',\''+hod+'\',\''+email+ '\')" ><i class="material-icons">&#xE254;</i></a></td>\n' +
                            '                        <td>\n' +
                            '                            <a class="delete" title="Delete" onclick="openDeleteDialog(\''+ branchId +'\',\''+ branch + '\')"><i class="material-icons">&#xE872;</i></a>\n' +
                            '                        </td></tr>';

                    }
                    document.getElementById("branchData").innerHTML = tableData;
                }

            });
        }


        $(document).on("click", ".delete", function () {
            var eventId = $(this).data('id');
            $('#idHolder').html( eventId );
        });

        $(document).on("click", ".edit", function () {
            var eventId = $(this).data('id');
            $('#idHolder').html( eventId );
        });
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
                        <li class="nav-item active">
                            <a class="nav-link" href="#">Page</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Page</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Page</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Page</a>
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
                        <th> H.O.D.</th>
                        <th> Email </th>
                        <th> Edit </th>
                        <th> Delete </th>
                    </tr>
                    </thead>
                    <tbody id="branchData">
                    </tbody>
                </table>
                ${userAuthorisation}
                ${manageAccounts}
                ${success}



                <!--Modal for adding branch -->
                <div class="modal fade" id="addAdminForm" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <form id="create-admin" action="/addAdmin" method="post">
                                <div class="form-group">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Add Branch Details here</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="Hod">Head Of Department</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="Hod" class="form-control form-horizontal" required="required" type="text" name="hodName" placeholder="Hod">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="branch-Id">Branch Name</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <select id="branch-Id" class="form-control form-horizontal" required="required" name="branchId">
                                                    <option value="IS">Information Science and Engineering</option>
                                                    <option value="CS">Computer Science and Engineering</option>
                                                    <option value="EC">Electronics and Communication Engineering</option>
                                                    <option value="EE">Electrical and Electronics Engineering</option>
                                                    <option value="CV">Civil Engineering</option>
                                                    <option value="ME">Mechanical Engineering</option>
                                                    <option value="BT">Biotech Engineering</option>
                                                    <option value="TE">Telecommunication Engineering</option>
                                                    <option value="other">Other</option>

                                                </select>
                                            </div>
                                        </div><br>

                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="admin-email">email</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="admin-email" class="form-control form-horizontal" required="required" type="text" name="adminEmail">
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
                                <p class="modal-title" style="margin: 0 auto;">Delete <span id="branchName"></span></p>
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
                                                <label class="control-label" for="hodName">Head Of Department</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="hodName" class="form-control form-horizontal" required="required" type="text" name="hodName" placeholder="Hod">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="branchId">Branch Name</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input readonly="readonly" id="branchId" class="form-control form-horizontal" required="required" type="text" name="branchId" placeholder="Branch" >
                                            </div>
                                        </div><br>

                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="hodEmail">email</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="hodEmail" class="form-control form-horizontal" required="required" type="text" name="adminEmail">
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