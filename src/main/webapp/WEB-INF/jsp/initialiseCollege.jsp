<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Initialise College</title>
</head>
<body>
<form action="/college/initialise" method="post">
    CollegeName::<input type="text" name="collegeId" required="required"><br>
    CollegeName::<input type="text" name="collegeName" required="required"><br>
    PrincipalName::<input type="text" name="principal" required="required"><br>
    Description::<input type="text" name="description" required="required"><br>
    City::<input type="text" name="city" required="required"><br>
    <select  required="required" name="modules">
        <option value="Notice">Notice</option>
        <option value="SIS">SIS</option>
    </select>
    <input type="submit">Submit
</form>
</body>
</html>