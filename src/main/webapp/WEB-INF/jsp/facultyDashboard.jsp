<!DOCTYPE html>
<html>

<head>
    <title>Faculty Dashboard</title>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="/facultyDashboardCss/style.css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
          rel="stylesheet">
    <!-- Our Custom CSS -->

    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js"
            integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ"
            crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js"
            integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY"
            crossorigin="anonymous"></script>


    <script>
        var bId = "";
        var subName = "";
        var tableData = "";
        var maxMarks = "";
        var testName = "";
        var studentList = [];
        var usnList = [];
        var inputList = [];
        var attendanceList = [];

        function getBatch() {
            let selectData = "";
            selectData += '<option>' + "select Your Batch" + '</option>';
            $.ajax({
                url: "/faculty/getAllBatches",
                async: false,
                method: "GET",
                success: function (result) {
                    for (data in result) {
                        let value = result[data]
                        batchData = value;
                        let op = value["batchId"]
                        bId = op;
                        selectData += '<option>' + op + '</option>';

                    }
                    document.getElementById("batches").innerHTML = selectData;
                }

            });
        }

        function getSubjects(batchId) {
            val = batchId.value
            bId = val;
            var subjectData = "";
            var name = "${name}"
            subjectData += '<option>' + "select Your subject" + '</option>';
            $.ajax({
                url: "/faculty/getSubjects/" + val,
                async: false,
                method: "GET",
                success: function (result) {
                    for (data in result) {
                        let value = result[data]
                        let op = value["subjectName"]
                        let fName = value["facultyName"];
                        subName = op;
                        if(name.localeCompare(fName)==0) {
                            subjectData += '<option value="' + op + '">' + op + '</option>';
                        }
                    }
                    document.getElementById("subjects").innerHTML = subjectData;
                }

            });
        }

        function getStudentsData() {
            let batchId = bId;
            $.ajax({
                url: "/faculty/getAcademicsDetails/" + batchId,
                async: false,
                method: "GET",
                success: function (result) {
                    tableData = result;
                }

            });
        }

        function changeValue(_this) {
            let val = _this.innerText
            if (val.localeCompare("Present") == 0) {
                _this.innerText = "Absent"
                _this.style.backgroundColor = "#E60000";
            } else {
                _this.innerText = "Present"
                _this.style.backgroundColor = "#4caf50";
            }


        }

        function buildAttendanceTableData() {
            var result = checkSelectedBatchAndSubject();
            if("success".localeCompare(result)!=0) {
                alert("Select Batch And Subject Field First");
                return;
            }
            var TableData = new Array();
            $('#tableView tr').each(function (row, tr) {
                TableData[row] = {
                    "studentName": $(tr).find('td:eq(0)').text(),
                    "studentId": $(tr).find('td:eq(1)').text(),
                    "inputValue": $(tr).find('td:eq(2)').text()
                }//tableData[row]

            });
            studentList = []
            usnList = []
            inputList = []
            TableData.shift(); // first row will be empty - so remove
            for (dataarr in TableData) {
                let res = TableData[dataarr]
                studentList.push(res["studentName"])
                usnList.push(res["studentId"])
                inputList.push(res["inputValue"])
                let index = document.getElementById("subjects");
                subName = index.options[index.selectedIndex].value;
            }
            $.ajax({
                type: "POST",
                url: "/faculty/saveAttendance",
                data: {
                    'subjectName': subName,
                    'batchId': bId,
                    'studentIds': usnList.toString(),
                    'attendanceList': inputList.toString()
                },
                success: function (response) {
                }, error: function (error) {
                    console.log(JSON.stringify(error));
                }
            })
        }

        function takeAttendance() {
            var result = checkSelectedBatchAndSubject();
            if("success".localeCompare(result)!=0) {
                alert("Select Batch And Subject Field First");
                return;
            }
            getStudentsData();
            let val = "";
            let v = '<p  style="color: #ffffff; padding-left:10px;">Select Date of attendees</p>\n' +
                '                <input id="submit_button" type="submit"  onclick="buildAttendanceTableData()">';
            document.getElementById("divHeading").innerHTML = v;
            document.getElementById("divHeader").innerHTML = "";


            val += '<thead>\n' +
                '                <tr>\n' +
                '                    <th>Name</th>\n' +
                '                    <th>Student ID</th>\n' +
                '                    <th>Action</th>\n' +
                '                </tr>\n' +
                '                </thead>\n' +
                '                <tbody>\n'


            for (data in tableData) {
                result = tableData[data]
                let studentId = result["studentId"]
                let studentName = result["studentName"];
                studentList.push(studentName)
                usnList.push(studentId)

                val += '<tr><td>' + studentName + '</td><td>' + studentId + '</td><td><button id="' + studentId + '" class="present_absent_button" onclick="changeValue(this)">Present</button></td></tr>'
            }

            val += '                </tbody>';
            document.getElementById("tableView").innerHTML = val;
            alert("Attendance saved Successfully");

        }

        function testCreationFunction() {
            let testName = document.getElementById("tName").value
            maxMarks = document.getElementById("maxMarks").value
            $('#testSelection').append($('<option>').val(testName).text(testName));
        }


        function buildTableData() {
            var TableData = new Array();
            $('#tableView tr').each(function (row, tr) {
                TableData[row] = {
                    "studentName": $(tr).find('td:eq(0)').text(),
                    "studentId": $(tr).find('td:eq(1)').text(),
                    "inputValue": $(tr).find('td:eq(2)').find('input').val()
                }//tableData[row]

            });
            studentList = []
            usnList = []
            inputList = []
            TableData.shift(); // first row will be empty - so remove
            for (dataarr in TableData) {
                let res = TableData[dataarr]
                studentList.push(res["studentName"])
                usnList.push(res["studentId"])
                inputList.push(res["inputValue"])
            }
            maxMarks = document.getElementById("maximumMarks").innerText
            let index = document.getElementById("testSelection");
            testName = index.options[index.selectedIndex].value;
            index = document.getElementById("subjects");
            subName = index.options[index.selectedIndex].value;
            $.ajax({
                type: "POST",
                url: "/faculty/saveTest",
                data: {
                    'subjectName': subName,
                    'batchId': bId,
                    'testName': testName,
                    'totalMarks': maxMarks,
                    'studentId': usnList.toString(),
                    'marksObtained': inputList.toString()
                },
                success: function (response) {
                    alert("marks saved sucessfully")
                }, error: function (error) {
                    console.log(JSON.stringify(error));
                }
            })

        }


        function viewAttendance() {
            var result = checkSelectedBatchAndSubject();
            if("success".localeCompare(result)!=0) {
                alert("Select Batch And Subject Field First");
                return;
            }
            getStudentsData();
            let val = "";
            document.getElementById("divHeading").innerHTML = val;
            document.getElementById("divHeader").innerHTML = val;
            val += '<thead>\n' +
                '\t\t\t\t  <tr>\n' +
                '\t\t\t\t\t    <th>Name</th>\n' +
                '\t\t\t\t\t    <th>Student ID</th>\n' +
                '\t\t\t\t\t    <th>Percentage</th>\n' +
                '                        <th>Classes Attended</th>\n' +
                '\t\t\t\t  </tr>\n' +
                '\t\t\t\t</thead>\n' +
                '\t\t\t\t<tbody>\n';
            studentList = [];
            usnList = [];
            for (data in tableData) {
                result = tableData[data]
                subjects = result["subjects"]
                let studentName = result["studentName"]
                let studentId = result["studentId"]
                for (subject in subjects) {
                    let sub = subjects[subject]
                    let subjectName = sub["subjectName"]
                    if (subName.localeCompare(subjectName) == 0) {
                        let attended = sub["attended"]
                        let totalClasses = sub["totalClasses"]
                        let per= 0;
                        if(totalClasses!= 0){
                             let percentage = attended/totalClasses;
                                per = percentage.toFixed(2);
                        }
                        per=per*100;
                        studentList.push(studentName);
                        usnList.push(studentId);
                        val += '\t\t\t\t\t<tr><td>' + studentName + '</td><td>' + studentId + '</td><td>' + per + '%</td><td>'+attended+'</td></tr>\n'
                    }
                }
            }

            val += '\t\t\t\t</tbody>'
            document.getElementById("tableView").innerHTML = val;
        }

        function addMarks() {
            var result = checkSelectedBatchAndSubject();
            if("success".localeCompare(result)!=0) {
                alert("Select Batch And Subject Field First");
                return;
            }

            getStudentsData();
            let val = "";
            let testNameData= "";
            let flag=0;
            let index= document.getElementById("subjects")
            let nameOfSubject = index.options[index.selectedIndex].value;
            for(data in tableData){
                if(flag==0){
                    flag=1;
                let res = tableData[data]
                let subj = res["subjects"]
                for(sub in subj) {
                    res = subj[sub]
                    let s = res["subjectName"]
                    if (nameOfSubject.localeCompare(s) == 0) {
                        let marks = res["score"]
                        for (score in marks) {
                            res = marks[score]
                            let tN = res["testName"]
                            testNameData += '<option>' + tN + '</option>';
                        }
                    }
                }

                }
            }
            val += '<thead>\n' +
                '\t\t\t\t  <tr>\n' +
                '\t\t\t\t\t    <th>Name</th>\n' +
                '\t\t\t\t\t    <th>Student ID</th>\n' +
                '                        <th>Marks Obtained</th>\n' +
                '\t\t\t\t  </tr>\n' +
                '\t\t\t\t</thead>\n' +
                '\t\t\t\t<tbody>\n'

            for (data in tableData) {
                result = tableData[data]
                let studentId = result["studentId"];
                let studentName = result["studentName"];
                studentList.push(studentName);
                usnList.push(studentId);
                val += '\t\t\t\t\t<tr><td>' + studentName + '</td><td>' + studentId + '</td><td><input type="text" style="width: 50px; height: 30px;"></td></tr>\n'
            }

            val += '\t\t\t\t</tbody>'
            document.getElementById("tableView").innerHTML = val
            let res = '<h5 style="color: #000000; padding-left:10px">Max. Marks</h5>\n' +
                '<h5 id="maximumMarks" style="color: #000000; padding-left:10px">20</h5>\n' +
                '            <select id="testSelection" class="testselector">\n' +
                '                <option>Select Test</option>\n' +testNameData+
                '            </select>\n' +
                '\n' +
                '            <div style="float: left; color: #000000; margin-left: 10px;font-weight: bold;">OR</div>\n' +
                '                <div  class="enter_marks_head_text">Test Name</div>\n' +
                '                <input id ="tName" type="text" style="float: left">\n' +
                '\n' +
                '                <div  class="enter_marks_head_text" style="float: left">Max. Marks</div>\n' +
                '                <input id ="maxMarks" type="text" style="float: left">\n' +
                '            <button class="redactionbtn" onclick="testCreationFunction()">Create Test</button>\n' +
                '            <br>'
            document.getElementById("divHeader").innerHTML = res

            let v = '<p  style="color: #ffffff; padding-left:10px;">Select Date of attendees</p>\n' +
                '                <input id="submit_button" type="submit"  onclick="buildTableData()">';
            document.getElementById("divHeading").innerHTML = v;


        }

        function viewMarks() {
            var result = checkSelectedBatchAndSubject();
            if("success".localeCompare(result)!=0) {
                alert("Select Batch And Subject Field First");
                return;
            }
            getStudentsData();
            document.getElementById("divHeading").innerHTML = "";
            document.getElementById("divHeader").innerHTML = "";
            let testNameData = "";
            let flag = 0;
            let index = document.getElementById("subjects")
            let nameOfSubject = index.options[index.selectedIndex].value;
            for (data in tableData) {
                if (flag == 0) {
                    flag = 1;
                    let res = tableData[data]
                    let subj = res["subjects"]
                    for (sub in subj) {
                        res = subj[sub]
                        let s = res["subjectName"]
                        if (nameOfSubject.localeCompare(s) == 0) {
                            let marks = res["score"]
                            for (score in marks) {
                                res = marks[score]
                                let tN = res["testName"]
                                testNameData += '<option>' + tN + '</option>';
                            }
                        }
                    }

                }
            }
            let res = '<h5 style="color: #000000; padding-left:10px">Max. Marks</h5>\n' +
                '<h5 id="maximumMarks" style="color: #000000; padding-left:10px">20</h5>\n' +
                '            <select id="testSelection" class="testselector" onchange="addTableForViewMarks();">\n' +
                '                <option>Select Test</option>\n' +testNameData+
                '            </select>\n'
            document.getElementById("divHeader").innerHTML = res

            let v = '<p  style="color: #ffffff; padding-left:10px;">Updated Marks of Student</p>\n'
            document.getElementById("divHeading").innerHTML = v;
        }

        function addTableForViewMarks() {
            let index = document.getElementById("subjects")
            let nameOfSubject = index.options[index.selectedIndex].value;
            index = document.getElementById("testSelection")
            let testName = index.options[index.selectedIndex].value
            let val ="";
            val += '<thead>\n' +
                '\t\t\t\t  <tr>\n' +
                '\t\t\t\t\t    <th>Name</th>\n' +
                '\t\t\t\t\t    <th>Student ID</th>\n' +
                '                        <th>Marks Obtained</th>\n' +
                '\t\t\t\t  </tr>\n' +
                '\t\t\t\t</thead>\n' +
                '\t\t\t\t<tbody>\n'

            for (data in tableData) {
                result = tableData[data]
                let studentId = result["studentId"];
                let studentName = result["studentName"];
                let subject = result["subjects"];
                for (data in subject) {
                    result = subject[data];
                    let s = result["subjectName"]
                    if (nameOfSubject.localeCompare(s) == 0) {
                        let marks = result["score"]
                        for (data in marks) {
                            result = marks[data]
                            let tesName = result["testName"]
                            if (testName.localeCompare(tesName) == 0) {
                                val += '\t\t\t\t\t<tr><td>' + studentName + '</td><td>' + studentId + '</td><td>' + result["marksObtained"] + '</td></tr>\n'
                            }
                        }
                    }
                }
            }
            val += '\t\t\t\t</tbody>'
            document.getElementById("tableView").innerHTML = val
        }
        function addStudent() {
            var result = checkSelectedBatchAndSubject();
            if("success".localeCompare(result)!=0) {
                alert("Select Batch And Subject Field First");
                return;
            }
            $('#addStudentForm').modal('show');
        }
        function deleteStudent() {
            var result = checkSelectedBatchAndSubject();
            if("success".localeCompare(result)!=0) {
                alert("Select Batch And Subject Field First");
                return;
            }
            let index = document.getElementById("batches")
            let tableData = "";

            let batchId = index.options[index.selectedIndex].value;
            $.ajax({
                type: "GET",
                url: "/faculty/getAllStudents/"+batchId,
                data: { name: "abc", age: "20" },
                success:function(result){
                    for(data in result){
                        let res = result[data]
                        let usn = res["usn"];
                        let name = res ["name"];
                        let email = res["email"];
                        tableData+= '<tr class="bg-warning"><td>'+usn+'</td><td>'+name+'</td>'+'                        <td>\n' +
                            '                            <a class="delete" title="Delete" onclick="deleteOneStudent(\''+batchId+'\',\''+email+ '\',\''+name+'\')"><i class="fas fa-trash"></i></a>\n' +
                            '                        </td></tr>';
                    }
                    document.getElementById("subjectData").innerHTML = tableData

                }, error: function (error) {
                }
            })

            $('#delStudent').modal('show');
        }
        function deleteOneStudent(batchId,email,name) {
            document.getElementById("batchsId").innerText=batchId
            document.getElementById("studentName").innerText=name
            $('#deleteConfirm').modal('show');
            $("#deleteYes").val(email);
        }
        function deleteData() {
            let email = $('#deleteYes').val()
            $.ajax({
                type: "GET",
                url: "/faculty/deleteStudent/"+email,
                success:function(response){
                    $('#deleteConfirm').modal('hide');
                    $('#delStudent').modal('hide');
                }, error: function (error) {
                    console.log(JSON.stringify(error));
                }
            })

        }
        function checkSelectedBatchAndSubject(){
            var defaultBatch = "select Your Batch";
            var defaultSubject= "select Your subject";
            let index= document.getElementById("subjects")
            let nameOfSubject = index.options[index.selectedIndex].value;
            index=document.getElementById("batches")
            let nameOfBatch = index.options[index.selectedIndex].value;
           // alert(nameOfBatch+" "+nameOfSubject);
            if(defaultBatch.localeCompare(nameOfBatch)==0||defaultSubject.localeCompare(nameOfSubject)==0)
                return "Select Batch And Subject Before Continuing";
            else
                return "success";

        }
    </script>

</head>

<body onload="getBatch()">

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
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="nav navbar-nav ml-auto">
                        <li class="nav-item">
                            <button class="btn btn-outline-warning" onclick="addStudent()">Add Student
                            <i class="fas fa-user-plus"></i>
                            </button>
                        </li>
                        <li class="nav-item">
                            <button class="btn btn-outline-danger" onclick="deleteStudent()">Delete Student
                                <i class="fas fa-user-times"></i>
                            </button>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="${console}">Console</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="${dashboard}">Dashboard</a>
                        </li>
                    </ul>
                </div>
            </div>
            <select style="margin-right: 7px" id="batches" onchange="getSubjects(this);">
            </select>
            <select id="subjects" onchange="getStudentsData()">
            </select>
        </nav>

        <div class="row">
            <div class="column">
                <div class="card" onclick="takeAttendance()">
                    <i class="fas fa-user-graduate"></i>
                    <p class="card_text_top">
                        Take Attendance
                    </p>
                </div>
            </div>
            <div class="column">
                <div class="card" onclick="viewAttendance()">
                    <i class="fas fa-chart-area"></i>
                    <p class="card_text_top">
                        View Attendance
                    </p>
                </div>
            </div>
            <div class="column">
                <div class="card" onclick="addMarks()">
                    <i class="fas fa-chalkboard-teacher"></i>
                    <p class="card_text_top">
                        Enter marks
                    </p>
                </div>
            </div>
            <div class="column">
                <div class="card" onclick="viewMarks()">
                    <i class="fas fa-users"></i>
                    <p class="card_text_top">
                        View Marks
                    </p>
                </div>
            </div>
        </div>
        <br>
        <br>

        <!--take attendance-->
        <div class="dynamic">
            <div id="divHeading" style="background-color:#e60000;">
            </div>
            <div id="divHeader">
            </div>
            <br>
            <table id="tableView" class="table-striped" style="text-align:center">
            </table>
        </div>
    </div>
</div>
<div class="modal fade" id="addStudentForm" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <form id="create-admin" action="/faculty/addStudent" method="post">
                <div class="form-group">
                    <div class="modal-header">
                        <h4 class="modal-title">Add Student Details here</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label" for="name">Student Name:</label>
                            </div>
                            <div class="col-sm-8">
                                <input id="name" class="form-control form-horizontal" required="required" type="text" name="name" placeholder="Name">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label" for="usn">Usn:</label>
                            </div>
                            <div class="col-sm-8">
                                <input id="usn" class="form-control form-horizontal" required="required" type="text" name="usn" placeholder="Usn">
                            </div>
                        </div><br>
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label" for="roll">Roll No.</label>
                            </div>
                            <div class="col-sm-8">
                                <input id="roll" class="form-control form-horizontal" required="required" type="text" name="roll" placeholder="roll">
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
<!-- model for view and delete of of all the students-->
<div id="delStudent" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <p class="modal-title" style="margin: 0 auto;">List Of Student <span id="showBatch"></span></p>
            </div>
            <div class="modal-body">
                <p class="text-center">Data</p>
                <div class="text-center">
                    <table class="table table-dark">
                        <thead>
                        <tr>
                            <th scope="col">Usn</th>
                            <th scope="col">Student Name</th>
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

<!--Delete Confirm-->
<div id="deleteConfirm" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <p class="modal-title" style="margin: 0 auto;">Delete <span id="batchsId"></span>
                    <br>
                    Subject: <span id="studentName"></span>
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

<!-- Footer -->

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