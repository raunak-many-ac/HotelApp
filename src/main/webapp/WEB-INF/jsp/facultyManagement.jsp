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
        function getData() {
            let userEmail="${email}"
            let tableData=document.getElementById("savedBatches").innerHTML;
            $.ajax({
                url:"/faculty/getAllBatches",
                async:false,
                method:"GET",
                success:function(result) {
                    for(data in result){
                        let value = result[data]
                        let branch = value["branchName"]
                        let college = value["collegeName"]
                        let subjects = value["subjects"]
                        let batchId=value["batchId"]
                        for(val in subjects){
                            let v=subjects[val]
                            let email = v["facultyEmail"]
                            let subjectName =v['subjectName']
                            let subjectCode= v['subjectCode']
                            if(userEmail.localeCompare(email)==0){
                                tableData+='<tr><td>'+batchId+'</td><td>'+subjectName+'</td>'+
                                    '<td data-toggle="modal" data-target="#addUpdate">\n' +
                                    '                            <a class="edit" data-id='+batchId+' title="Edit" onclick="editBatch(\''+batchId+'\',\''+subjectName+'\',\''+subjectCode+'\',\''+email+ '\')" ><i class="material-icons">&#xE254;</i></a></td>\n' +
                                    '                        <td>\n' +
                                    '                            <a class="delete" title="Delete" onclick="deleteBatch(\''+batchId+'\',\''+subjectName+'\',\''+subjectCode+'\',\''+email+ '\')"><i class="material-icons">&#xE872;</i></a>\n' +
                                    '                        </td></tr>';
                            }
                        }

                    }
                    document.getElementById("savedBatches").innerHTML = tableData;
                },
                error: function (error) {
                    console.log(JSON.stringify(error));
                }

            });
        }
        function editBatch(batchId,subjectName,subjectCode,email) {
            document.getElementById("batchId").value=batchId;
            document.getElementById("subjectName").value=subjectName
            document.getElementById("subjectCode").value=subjectCode
            $('#updateBatchForm').modal('show');

        }
        function deleteBatch(batchId,subjectName,subjectCode,email) {
            document.getElementById("batchsId").innerText=batchId
            document.getElementById("subjectsName").innerText=subjectName
            $('#deleteConfirm').modal('show');
            $("#deleteYes").val(batchId+'$'+subjectName+'$'+subjectCode+'$'+email);

        }
        function deleteData(){
            dataarr = $("#deleteYes").val()
            data=dataarr.split("$")
            batchId = data[0]
            subjectName=data[1]
            subjectCode =data[2]
            email = data[3]
            alert(subjectCode)
            $.ajax({
                type: "GET",
                url: "/faculty/deleteBatch/"+batchId+"/"+subjectCode,
                data: { name: "abc", age: "20" },
                success:function(response){
                    setInterval('refreshPage()', 1000);
                    $('#deleteConfirm').modal('hide');
                }, error: function (error) {
                    console.log(JSON.stringify(error));
                    alert(JSON.stringify(error))
                }
            })

        }
        function addBatch() {

            let selectData="";
            $.ajax({
                url:"/faculty/getAllBatches",
                async:false,
                method:"GET",
                success:function(result) {
                    for(data in result){
                        let value = result[data]
                        let op = value["batchId"]
                        selectData+='<option>'+ op+'</option>';

                    }
                    document.getElementById("batches").innerHTML = selectData;
                }

            });
            $('#addBatchForm').modal('show');
        }

        function getSubjects(batchId) {
            val=batchId.value
           // alert(val)
            var subjectData="";
            $.ajax({
                url: "/faculty/getSubjects/"+val,
                async: false,
                method: "GET",
                success: function (result) {
                    for (data in result) {
                        let value = result[data]
                        let op = value["subjectName"]
                        alert(op)
                        subjectData += '<option value="'+op+'">' + op + '</option>';

                    }
                    //alert(subjectData);
                    document.getElementById("subjects").innerHTML = subjectData;
                },error: function (error) {
                    console.log(JSON.stringify(error));
                    alert(JSON.stringify(error))
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
                <a href="/event">
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
                            <a class="nav-link" href="${console}">Console</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${dashboard}">Dashboard</a>
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
                            <button type="button" class="btn btn-info add-new" onclick="addBatch()"><i class="fa fa-plus"></i>Add Batch</button>
                        </div>
                    </div>
                </div>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th> Batch </th>
                        <th> Subjects</th>
                        <th> Edit </th>
                        <th> Delete </th>
                    </tr>
                    </thead>
                    <tbody id="savedBatches">
                    </tbody>
                </table>
                ${userAuthorisation}
                ${manageAccounts}
                ${success}



                <!--Modal for adding Student -->



                <!--Modal for deleteting Student -->




                <!-- Modal for adding batch-->
                <div class="modal fade" id="addBatchForm" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <form id="add-batch" action="/faculty/saveBatch" method="post">
                                <div class="form-group">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Add Batch Details here</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="batches">Batch</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <select id="batches" class="form-control form-horizontal" required="required" name="batches" onchange="getSubjects(this);"><option>Select Any Batch</option></select>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="subjects">Subjects</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <select id="subjects" class="form-control form-horizontal" required="required" name="subjects"></select>
                                            </div>
                                        </div><br>

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



                <!--Modal for deleting batches -->
                <div id="deleteConfirm" class="modal fade" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <p class="modal-title" style="margin: 0 auto;">Delete <span id="batchsId"></span>
                                <br>
                                Subject: <span id="subjectsName"></span>
                                </p>
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



                <!--update Modal for Batches -->

                <div class="modal fade" id="updateBatchForm" role="dialog">
                    <div class="modal-dialog">

                        <!-- Modal content-->
                        <div class="modal-content">
                            <form id="update-admin" action="/faculty/editBatch" method="get">
                                <div class="form-group">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Add Batch Details here</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="batchId">Batch Id</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input readonly="readonly" id="batchId" class="form-control form-horizontal" required="required" type="text" name="batchId" placeholder="BatchId">
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="subjectName">Subject Name</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input  id="subjectName" class="form-control form-horizontal" required="required" type="text" name="subjectName" placeholder="subject" >
                                            </div>
                                        </div><br>

                                        <div class="row">
                                            <div class="col-sm-4">
                                                <label class="control-label" for="subjectCode">Subject Code</label>
                                            </div>
                                            <div class="col-sm-8">
                                                <input id="subjectCode" class="form-control form-horizontal" required="required" type="text" name="subjectCode">
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