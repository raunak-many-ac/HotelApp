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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

    <script>
        //batch data
        //batch data
        /*
        {"branchID":"IS","collegeID":"1MV","collegeName":"Sir M. Visvesvaraya Institute Of Technology","branchName":"Information Science and Engineering","hod":"Dr. P. Vijaykarthik"}
         */
        function getData() {
            let tableData=document.getElementById("batchData").innerHTML;
            $.ajax({
                url:"/admin/getAllBatches",
                async:false,
                method:"GET",
                success:function(result) {
                    for(data in result){
                        let value = result[data]
                        let batchId = value["batchId"]
                        let branchName = value["branchName"]
                        let collegeName = value["collegeName"]
                        tableData+='<tr><td>'+ collegeName +'</td>' +
                            '<td>'+ batchId +'</td>' +
                            '<td>'+ branchName +'</td>' +
                            '<td data-toggle="modal" data-target="#addUpdate">\n' +
                            '                            <a class="edit" data-id='+batchId+' title="Edit" onclick="updateSubjectDialogue(\''+collegeName+'\',\''+batchId+'\',\''+branchName+'\')" ><i class="material-icons">&#xE254;</i></a></td>\n' +
                            '                        <td>\n' +
                            '                            <a class="delete" title="Delete" onclick="openDeleteDialog(\''+ branchName +'\',\''+ batchId + '\')"><i class="material-icons">&#xE872;</i></a>\n' +
                            '                        </td></tr>';
                    }
                    document.getElementById("batchData").innerHTML = tableData;
                },
                error: function (error) {
                    console.log(JSON.stringify(error));
                    alert(JSON.stringify(error));
                }
            });
        }
        function openDeleteDialog(branchName,batchId) {
            document.getElementById("batchId").innerText = batchId
            $('#deleteConfirm').modal('show');
            $("#deleteYes").val(batchId)
        }
        function deleteData(){
            batchId = $("#deleteYes").val()
            $.ajax({
                type: "GET",
                url: "/admin/deleteBatch/"+batchId,
                data: { name: "abc", age: "20" },
                success:function(response){
                    alert(batchId)
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
        //subject Data
        function updateSubjectDialogue(collegeName,batchId,branchName) {
            let subjectTable ="";
            $.ajax({
                url:"/admin/getAllSubjects/"+batchId,
                async:false,
                method:"GET",
                success:function(result) {
                    for(data in result){
                        let value = result[data]
                        let subjectCode = value["subjectCode"]
                        let subjectName = value["subjectName"]
                        subjectTable+='<tr><td>'+ subjectCode +'</td>' +
                            '<td>'+ subjectName +'</td>' +
                            '<td data-toggle="modal" data-target="#addUpdate">\n' +
                            '                        <td>\n' +
                            '                            <a class="delete" title="Delete" onclick="openDeleteSubjectDialogue(\''+ subjectCode +'\',\''+ batchId + '\',\''+ subjectName + '\')"><i class="material-icons">&#xE872;</i></a>\n' +
                            '                        </td></tr>';
                    }
                    document.getElementById("subjectData").innerHTML = subjectTable;
                },
                error: function (error) {
                    console.log(JSON.stringify(error));
                    alert(JSON.stringify(error));
                }
            });
            document.getElementById("showBatch").innerText=batchId
            $('#addSub').val(batchId);
            $('#addSubject').modal('show');
        }
        function openDeleteSubjectDialogue(subjectCode,batchId,subjectName) {
            document.getElementById("subject").innerText = subjectName
            $('#deleteSubjectConfirm').modal('show');
            $("#deleteSub").val(batchId+" "+subjectCode)
        }
        function deleteSubject(){
            data=$("#deleteSub").val().split(' ');
            batchId=data[0];
            subjectCode=data[1];
            $.ajax({
                type: "GET",
                url: "/admin/deleteSubject/"+batchId+"/"+subjectCode,
                data: { name: "abc", age: "20" },
                success:function(response){
                    $('#deleteSubjectConfirm').modal('hide');
                    $('#addSubject').modal('hide');
                },
                error: function (error) {
                    console.log(JSON.stringify(error));
                    alert(JSON.stringify(error));
                }
            })
        }
        //add new subject
        function addNewSubject(){
            batchId = $("#addSub").val()
            document.getElementById("batchIds").value = batchId;
            $('#addNewSubject').modal('show');
        }
        //add batch
        function addBatchDialogue(branchName,collegeName) {
            document.getElementById("branchName").value = branchName;
            document.getElementById("collegeName").value = collegeName;
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
                <a href="/admin/manageAccounts" class="download">Manage Accounts</a>
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
                            <button type="button" class="btn btn-info add-new" data-toggle="modal" data-target="#addBatchForm"><i class="fa fa-plus"></i>Add New</button>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th> College </th>
                        <th> Year</th>
                        <th> Branch </th>
                        <th> Edit </th>
                        <th> Delete </th>
                    </tr>
                    </thead>
                    <tbody id="batchData">
                    </tbody>
                </table>
                ${userAuthorisation}
                ${manageAccounts}
                ${success}



                <!--Modal for adding batch -->
                <div class="modal fade" id="addBatchForm" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <form id="create-admin" action="/admin/createBatch" method="get">
                                <div class="form-group">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Add Batch Details here</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="collegeName">College</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input readonly="readonly" id="collegeName" class="form-control form-horizontal" required="required" type="text" name="college" placeholder="College" value="${college}">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="batch-year">Batch Year</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <select id="batch-year" class="form-control form-horizontal" required="required" name="batchYear">
                                                    <option value="16">2016</option>
                                                    <option value="17">2017</option>
                                                    <option value="18">2018</option>
                                                    <option value="19">2019</option>
                                                    <option value="20">2020</option>
                                                    <option value="21">2021</option>
                                                    <option value="22">2022</option>
                                                    <option value="23">2023</option>
                                                    <option value="24">2024</option>
                                                    <option value="25">2025</option>
                                                    <option value="26">2026</option>
                                                    <option value="27">2027</option>
                                                    <option value="28">2028</option>
                                                    <option value="29">2029</option>
                                                    <option value="30">2030</option>
                                                </select>
                                            </div>
                                        </div><br>

                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="branchName">Branch</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input readonly="readonly" id="branchName" class="form-control form-horizontal" required="required" type="text" name="branch" value="${branch}">
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



                <!--Modal for deleteting batch -->
                <div id="deleteConfirm" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <p class="modal-title" style="margin: 0 auto;">Delete <span id="batchId"></span></p>
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





                <!--Add new Subject Modal -->
                <div class="modal fade" id="addNewSubject" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <form id="update-admin" action="/admin/saveSubject" method="post">
                                <div class="form-group">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Add Subject Details here</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="batchIds">Batch Id</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input readonly= "readonly" style="text-transform:uppercase" id="batchIds" class="form-control form-horizontal" required="required" type="text" name="batchId" placeholder="Batch Id">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="subjectCode">Subject Code</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input style="text-transform:uppercase" id="subjectCode" class="form-control form-horizontal" required="required" type="text" name="subjectCode" placeholder="Subject Code">
                                            </div>
                                        </div>
                                        <br>

                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="subjectName">Subject Name</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input style="text-transform:uppercase" id="subjectName" class="form-control form-horizontal" required="required" type="text" name="subjectName" placeholder="Subject Name" >
                                            </div>
                                        </div><br>

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



                <!-- model for view of all the subjects-->
                <div id="addSubject" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <p class="modal-title" style="margin: 0 auto;">List Of Subjects <span id="showBatch"></span></p>
                            </div>
                            <div class="modal-body">
                                <p class="text-center">Data</p>
                                <div class="text-center">
                                    <table class="table table-striped table-dark">
                                        <thead>
                                        <tr>
                                            <th scope="col">Subject Code</th>
                                            <th scope="col">Subject Name</th>
                                            <th scope="col">Delete</th>
                                        </tr>
                                        </thead>
                                        <tbody id="subjectData">
                                        </tbody>
                                    </table>
                                    <!--   <button type="button" class="btn btn-success" data-dismiss="modal" id ="deleteYes" value="" onclick="deleteData()">Yes</button>-->
                                    <button type="button" class="btn btn-success" data-dismiss="modal" id ="addSub" value="" onclick="addNewSubject()">Add More Subjects</button>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>




                <!--Model for deleting subjects -->
                <div id="deleteSubjectConfirm" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <p class="modal-title" style="margin: 0 auto;">Delete <span id="subject"></span></p>
                            </div>
                            <div class="modal-body">
                                <p class="text-center">Are You Sure?</p>
                                <div class="text-center">
                                    <button type="button" class="btn btn-success" data-dismiss="modal" id ="deleteSub" value="" onclick="deleteSubject()">Yes</button>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                </div>
                            </div>
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