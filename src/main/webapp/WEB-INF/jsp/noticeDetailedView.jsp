<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notice</title>

    <link href='https://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet'>
    <style>
        #embedded {
            margin-left: auto;
            text-align: center;
            width: 80%;
            height: 100vh;
            display: inherit;
            margin-right: auto;
            margin-top: 3vh;
        }
        #header{
            text-align: center;
            color: blueviolet;
            text-shadow: 2px 0 0 #ffffff, -2px 0 0 #ffffff, 0 2px 0 #ffffff, 0 -2px 0 #ffffff, 1px 1px #ffffff, -1px -1px 0 #ffffff, 1px -1px 0 #ffffff, -1px 1px 0 #ffffff;
        }
        #collegeName{
            text-align: center;
            color: blueviolet;
            text-shadow: 1px 0 0 #ffffff, -1px 0 0 #ffffff, 0 1px 0 #ffffff, 0 -1px 0 #ffffff, 1px 1px #ffffff, -1px -1px 0 #ffffff, 1px -1px 0 #ffffff, -1px 1px 0 #ffffff;
        }
        #date{
            text-align: center;
            color: blueviolet;
            text-shadow: 1px 0 0 #ffffff, -1px 0 0 #ffffff, 0 1px 0 #ffffff, 0 -1px 0 #ffffff, 1px 1px #ffffff, -1px -1px 0 #ffffff, 1px -1px 0 #ffffff, -1px 1px 0 #ffffff;
        }

        body{
            background-color: black;
            font-family: 'Montserrat';
        }

        #info{
            width: 1024px;
            margin: auto;
            text-align: center;
        }
    </style>
</head>
<body>
<div id="info">
    <h1 id="header">${notice_header}</h1>
    <p><span id="collegeName" style="float: left">${collegeID}</span><span id="date" style="float: right">${date}</span></p>
</div>
<div id="embedded">
   ${render_element}
</div>
</body>
</html>