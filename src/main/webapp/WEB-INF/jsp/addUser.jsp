<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add USER</title>
</head>
<body>
<form action="" method="post">
    userName: <input type="text" name="email" required="required"><br>
    password: <input type="text" name="password" required="required"><br>
    UserType:
    <select id ="user-type" required="required" name="userType">
        <option value="STUDENT">STUDENT</option>
        <option value="ADMIN">ADMIN</option>
        <option value="SUPERADMIN">SUPER_ADMIN</option>
        <option value="FACULTY">FACULTY</option>
    </select><br><br>
    College
    <select id ="college" required="required" name="collegeId">
        <option value="Sir M.Visvesvaraya Institute Of Technology">Sir M.Visvesvaraya Institute Of Technology</option>
    </select><br><br>

</form>
</body>
</html>