<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Material design profile page</title>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css"
    />

    <link
            href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet"
    />

    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="/event_details/style.css"/>
    <style>
        header nav {
            position: fixed;
            z-index: 1000;
            background: #2c2c2c;
        }
        header nav ul {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header nav ul li a {
            line-height: 1;
        }
        header nav ul li:hover {
            background: transparent;
        }
        header nav ul #title {
            font-size: 22px;
            font-weight: 300;
        }

        main {
            padding-top: 64px;
            padding-bottom: 300px;
        }
        main .jumbo {
            width: 100%;
            height: 400px;
            background: url(https://cosmos-solutions.herokuapp.com/events/retrive/images/${cover_image})
            center center no-repeat;
            background-size: cover;
        }
        main .icons {
            display: flex;
            justify-content: space-between;
        }
        main .icons .big-icon {
            width: 180px;
            height: 180px;
            background: url(https://media.licdn.com/dms/image/C5103AQHu6pKUbxYzhg/profile-displayphoto-shrink_200_200/0?e=1575504000&v=beta&t=nF660qxeTp5LfTzKegSNEuuUaBrC5kk9NRfgF_XQNh4)
            center top;
            background-size: 140%;
            border-radius: 50%;
            border: 2px solid white;
            margin-top: -90px;
        }
        main .icons .rate {
            width: 125px;
            display: flex;
            justify-content: space-between;
            order: -1;
        }
        main .icons .rate .star-btn {
            margin-top: -27.5px;
        }
        main .icons .rate .star-btn i {
            font-size: 26px;
        }
        main .icons .rate .like-btn {
            margin-top: -27.5px;
        }
        main .icons .rate .like-btn i {
            font-size: 22px;
        }
        main .icons .add {
            width: 125px;
            display: flex;
            justify-content: flex-end;
        }
        main .icons .add .add-btn {
            margin-top: -27.5px;
        }
        main .icons .add .add-btn i {
            font-size: 28px;
        }
        main .details {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 50px;
        }
        main .details h3 {
            color: #212121;
            font-size: 28px;
            margin-top: 15px;
        }
        main .details p {
            color: #727272;
            margin-top: 0px;
        }
        main .bio {
            margin-bottom: 80px;
        }
        main .bio .title h6 {
            color: #212121;
            font-size: 18px;
        }
        main .bio .content p {
            color: #727272;
        }
        main .pics {
            margin-bottom: 50px;
        }
        main .pics .title {
            margin-bottom: 20px;
        }
        main .pics .title h6 {
            color: #212121;
            font-size: 18px;
        }
        main .pics .row-1 .s12:nth-of-type(2) {
            margin-bottom: -10px;
        }
        main .pics .row .s12:nth-of-type(1) {
            margin-bottom: 10px;
        }
        main .pics .row .col .card {
            height: 520px;
        }

        main .pics .row .col .card #first-img {
            height: 100%;
            background: url(https://cosmos-solutions.herokuapp.com/events/retrive/images/${image_id})
            center center;
            background-size: cover;
        }
        main .posts {
            margin-bottom: 50px;
        }
        main .posts .title h6 {
            color: #212121;
            font-size: 18px;
            margin-bottom: 20px;
        }
        main .posts .row {
            margin-bottom: 0px;
        }
        main .posts .row .col .card {
            position: relative;
        }
        main .posts .row .col .card .card-action {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        main .posts .row .col .card .card-action .tags {
            display: flex;
        }
        main .posts .row .col .card .card-action .tags .chip:first-child {
            margin-right: 5px;
        }
        main .posts .row .col .card .card-action .card-love {
            cursor: pointer;
            font-size: 25px;
            position: absolute;
            right: 10px;
            top: 10px;
            color: white;
            transition: all 100ms ease-in-out;
        }
        main .posts .row .col .card .card-action .card-love:hover {
            color: #f9a825;
        }
        main .blogs {
            margin-bottom: 80px;
        }
        main .blogs .title {
            margin-bottom: 20px;
        }
        main .blogs .title h6 {
            color: #212121;
            font-size: 18px;
        }
        main .likes .title {
            margin-bottom: 20px;
        }
        main .likes .title h6 {
            color: #212121;
            font-size: 18px;
        }
        main .likes .row .col .tabs {
            margin-bottom: 10px;
            box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
        }
        main .stretch {
            height: 500px;
        }
        main .fab {
            transition: all 120ms ease-in-out;
            bottom: 20px !important;
        }
        main .fab .btn-large i {
            font-size: 40px;
        }
        main .fab .orange i {
            font-size: 20px;
        }

        @media screen and (max-width: 600px) {
            main {
                padding-top: 40px;
            }

            .jumbo {
                height: 200px !important;
            }

            .icons {
                justify-content: center !important;
            }

            .rate {
                display: none !important;
            }

            .add {
                display: none !important;
            }
        }
        @media screen and (min-width: 600px) {
            .fab {
                display: none;
            }
        }

    </style>
</head>
<body>
<!-- partial:index.partial.html -->
<header>
    <nav role="navigation">
        <ul>
            <li id="menu"><a href="#">Back</a></li>
            <li id="title">Event Details</li>
            <li id="more"><a href="#">Date</a></li>
        </ul>
    </nav>
</header>
<main>
    <div class="jumbo"></div>
    <div class="details">
        <h3>${eventName}</h3>
    </div>
    <div class="container bio">
        <div class="title">
            <h6>Description</h6>
        </div>
        <div class="content">
            <p>
               ${description}
            </p>
        </div>
        <hr />
    </div>
    <div class="container pics">
        <div class="title">
            <h6>Pictures</h6>
        </div>

        <div class="row">
            <div class="col m12 s12">
                <div class="card">
                    <div class="card-image" id="first-img"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="container blogs">
        <div class="title">
            <h6>Event Details</h6>
        </div>
        <ul class="collapsible" data-collapsible="accordion">
            <li>
                <div class="collapsible-header active">
                    <i class="material-icons">book</i>Rules
                </div>
                <div class="collapsible-body">
                    <p>
                        ${rules}
                    </p>
                </div>
            </li>

            <li>
                <div class="collapsible-header">
                    <i class="material-icons">date_range</i>Date
                </div>
                <div class="collapsible-body">
                    <p>
                       ${date}
                    </p>
                </div>
            </li>
            <li>
                <div class="collapsible-header">
                    <i class="material-icons">place</i>Place
                </div>
                <div class="collapsible-body">
                    <p><a href="ulgvablvsa.com">${location}</a></p>
                </div>
            </li>
        </ul>
    </div>

    <div class="fixed-action-btn fab" style="bottom: 45px; right: 24px;">
        <a class="btn-floating btn-large red">
            <i class="large material-icons">arrow_drop_up</i>
        </a>
        <ul>
            <li>
                <a class="btn-floating orange"
                ><i class="material-icons">thumb_up</i></a
                >
            </li>
            <li>
                <a class="btn-floating green"><i class="material-icons">star</i></a>
            </li>
            <li>
                <a class="btn-floating blue"><i class="material-icons">add</i></a>
            </li>
        </ul>
    </div>
</main>

<script
        type="text/javascript"
        src="https://code.jquery.com/jquery-2.1.1.min.js"
></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/js/materialize.min.js"></script>
<!-- partial -->
<script src="/event_details/script.js"></script>
</body>
</html>
