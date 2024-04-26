<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" data-n-head="%7B%22lang%22:%7B%22ssr%22:%22en%22%7D%7D">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <title>Infinite Craftle</title>
    <meta data-n-head="ssr" charset="utf-8"/>
    <meta data-n-head="ssr" name="title" content="Infinite Craftle"/>
    <meta data-n-head="ssr" name="description" content="Infinite Craftle with daily challenges. Recipes may vary"/>
    <meta data-n-head="ssr" property="og:type" content="website"/>
    <meta data-n-head="ssr" property="og:title" content="Infinite Craftle"/>
    <meta data-n-head="ssr" property="og:description" content="Infinite Craftle with daily challenges"/>
    <meta data-n-head="ssr" property="og:image" content="https://neal.fun/share-cards/infinite-craft.png"/>
    <link data-n-head="ssr" rel="canonical" href="https://neal.fun/infinite-craft/"/>
    <link data-n-head="ssr" rel="icon" type="image/png" href="https://neal.fun/favicons/infinite-craft.png"/>
    <link rel="stylesheet" href="global.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css"/>
</head>

<body class="infinite-craft-body vsc-initialized" style="background: white">
<div class="container">
    <%@include file="components/upper-left-logo.jsp" %>

    <script src="resources/javascript/datedreamer.js"></script>
    <div class="calendar-container">
        <div id="calendar" class="calendar"></div>
    </div>

    <div class="side-controls">
        <svg class="clear" viewBox="0 0 45 51" xmlns="http://www.w3.org/2000/svg"
             xml:space="preserve"
             style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;">
    <g transform="matrix(1,0,0,1,-5.99606,0.0332823)">
        <path d="M46.438,-0.031C46.27,-0.039 46.098,-0.023 45.938,0C45.266,0.094 44.688,0.422 44.281,1.031L44.25,1.094L44.219,1.125L35.656,17.219C34.691,16.859 33.734,16.648 32.844,16.625C31.883,16.602 30.977,16.75 30.156,17.094C28.574,17.754 27.379,19.047 26.594,20.688C26.559,20.738 26.527,20.789 26.5,20.844C26.496,20.852 26.504,20.867 26.5,20.875C26.488,20.895 26.477,20.918 26.469,20.938C26.457,20.977 26.445,21.02 26.438,21.063C25.895,22.418 25.27,23.637 24.563,24.719C24.555,24.73 24.539,24.738 24.531,24.75C24.441,24.828 24.367,24.926 24.313,25.031C24.309,25.039 24.316,25.055 24.313,25.063C24.277,25.113 24.246,25.164 24.219,25.219C21.832,28.637 18.723,30.695 15.781,31.969C11.773,33.703 7.938,33.887 7.094,33.813C6.691,33.773 6.305,33.977 6.113,34.332C5.926,34.688 5.965,35.125 6.219,35.438C17.613,49.5 34.375,50 34.375,50C34.574,50.004 34.77,49.949 34.938,49.844C34.938,49.844 37.008,48.531 39.5,45.406C41.371,43.059 43.504,39.664 45.344,34.969C45.355,34.957 45.363,34.949 45.375,34.938C45.605,34.723 45.723,34.41 45.688,34.094L45.688,34.063C46.172,32.754 46.641,31.379 47.063,29.875C47.078,29.813 47.09,29.75 47.094,29.688L47.094,29.656C48.426,26.219 46.941,22.434 43.75,20.781L49.938,3.625L49.938,3.594L49.969,3.563C50.172,2.852 49.938,2.168 49.563,1.625C49.207,1.113 48.688,0.711 48.063,0.438L48.063,0.406C48.043,0.398 48.02,0.414 48,0.406C47.988,0.402 47.98,0.379 47.969,0.375C47.48,0.145 46.945,-0.012 46.438,-0.031ZM46.313,2.063C46.539,2.027 46.836,2.027 47.156,2.188L47.188,2.219L47.219,2.219C47.543,2.348 47.813,2.566 47.938,2.75C48.063,2.934 48.027,3.043 48.031,3.031L41.938,19.938C41.203,19.605 40.695,19.371 39.656,18.906C38.883,18.559 38.148,18.223 37.5,17.938L45.938,2.156C45.93,2.164 46.086,2.098 46.313,2.063ZM32.813,18.625C33.508,18.645 34.27,18.785 35.125,19.125C35.145,19.137 35.168,19.148 35.188,19.156C35.414,19.512 35.84,19.688 36.25,19.594C36.363,19.641 36.352,19.637 36.469,19.688C37.145,19.98 37.996,20.34 38.844,20.719C40.086,21.273 40.871,21.613 41.594,21.938C41.613,21.961 41.633,21.98 41.656,22C41.871,22.297 42.23,22.453 42.594,22.406L42.625,22.406C45.016,23.5 46.07,26.105 45.25,28.625C44.855,28.613 44.555,28.633 43.813,28.469C43.258,28.348 42.719,28.152 42.313,27.906C41.906,27.66 41.672,27.418 41.563,27.094C41.477,26.813 41.27,26.586 40.996,26.473C40.727,26.355 40.418,26.367 40.156,26.5C39.82,26.668 38.973,26.605 38.219,26.219C37.844,26.027 37.508,25.758 37.281,25.531C37.055,25.305 36.992,25.09 37,25.125C36.945,24.832 36.766,24.578 36.504,24.434C36.246,24.289 35.934,24.27 35.656,24.375C35.629,24.387 35.297,24.418 34.906,24.344C34.516,24.27 34.063,24.109 33.625,23.906C33.188,23.703 32.785,23.457 32.531,23.25C32.277,23.043 32.254,22.828 32.281,23.094C32.215,22.566 31.75,22.18 31.219,22.219C30.215,22.313 29.273,21.574 28.719,21.094C29.305,20.105 30.031,19.316 30.938,18.938C31.492,18.707 32.117,18.605 32.813,18.625ZM27.813,22.969C28.508,23.469 29.473,23.988 30.625,24.094C30.809,24.363 31.008,24.582 31.25,24.781C31.684,25.141 32.219,25.457 32.781,25.719C33.344,25.98 33.934,26.199 34.531,26.313C34.84,26.371 35.156,26.254 35.469,26.25C35.617,26.477 35.684,26.777 35.875,26.969C36.281,27.375 36.766,27.719 37.313,28C38.125,28.418 39.102,28.563 40.063,28.438C40.391,28.93 40.785,29.344 41.25,29.625C41.934,30.035 42.68,30.285 43.375,30.438C43.863,30.543 44.309,30.59 44.719,30.625C44.441,31.523 44.141,32.367 43.844,33.188C43.484,33.176 43.043,33.156 42.563,33.063C41.469,32.852 40.434,32.367 40,31.531C39.766,31.094 39.246,30.895 38.781,31.063C38.285,31.238 37.387,31.164 36.625,30.813C35.863,30.461 35.285,29.852 35.156,29.406C35.074,29.137 34.879,28.914 34.621,28.797C34.367,28.676 34.074,28.672 33.813,28.781C33.57,28.883 32.625,28.855 31.844,28.5C31.063,28.145 30.559,27.547 30.5,27.219C30.449,26.941 30.285,26.703 30.047,26.555C29.809,26.406 29.52,26.363 29.25,26.438C28.305,26.691 27.566,26.355 26.969,25.906C26.762,25.754 26.609,25.586 26.469,25.438C26.953,24.668 27.402,23.852 27.813,22.969ZM25.313,27.094C25.461,27.23 25.602,27.363 25.781,27.5C26.52,28.055 27.656,28.449 28.938,28.375C29.402,29.246 30.156,29.914 31.031,30.313C31.895,30.707 32.816,30.832 33.719,30.719C34.219,31.535 34.914,32.227 35.781,32.625C36.707,33.051 37.746,33.16 38.75,33C39.684,34.168 41.012,34.805 42.188,35.031C42.5,35.09 42.809,35.129 43.094,35.156C41.43,39.176 39.566,42.117 37.938,44.156C35.852,46.77 34.441,47.758 34.125,47.969C33.77,47.953 31.164,47.77 27.5,46.75C27.801,46.555 28.125,46.352 28.469,46.094C30.137,44.844 32.32,42.805 34.438,39.656C34.66,39.332 34.676,38.91 34.473,38.574C34.27,38.234 33.891,38.047 33.5,38.094C33.207,38.125 32.945,38.285 32.781,38.531C30.797,41.484 28.754,43.375 27.25,44.5C25.82,45.57 24.992,45.902 24.906,45.938C22.656,45.145 20.164,44.059 17.625,42.531C17.992,42.41 18.383,42.25 18.813,42.063C20.711,41.234 23.25,39.688 25.844,36.781C26.156,36.469 26.227,35.988 26.02,35.602C25.809,35.211 25.371,35.004 24.938,35.094C24.707,35.133 24.496,35.258 24.344,35.438C21.938,38.129 19.684,39.496 18.031,40.219C16.379,40.941 15.438,41 15.438,41C15.395,41.008 15.352,41.02 15.313,41.031C13.238,39.57 11.168,37.793 9.219,35.656C11.121,35.508 13.57,35.121 16.594,33.813C19.578,32.52 22.762,30.41 25.313,27.094Z"
              style="fill-rule:nonzero;"></path>
    </g>
</svg>

    </div>
    <canvas class="particles" width="1920" height="972"></canvas>
    <%@include file="components/element-playground.jsp" %>

    <div class="reset">Reset</div>
    <a class="login" href="./login">Log in</a>
    <a class="logout">Log out</a>
</div>

<script>
    const clearButton = document.querySelector('.clear')
    let retrievedData = sessionStorage.getItem("test-data")
    if (retrievedData == null) {
        let gameInstance = {
            "element-of-the-day": "Water",
            "elements": [{"text": "Water", "emoji": "💧", "discovered": true}, {
                "text": "Fire",
                "emoji": "🔥",
                "discovered": true
            }, {"text": "Wind", "emoji": "🌬️", "discovered": false}, {
                "text": "Earth",
                "emoji": "🌍",
                "discovered": false
            }, {"text": "Ebert is Mega Gay", "emoji": "🏳️‍🌈", "discovered": true}, {
                "text": "Mountain",
                "emoji": "🏔️",
                "discovered": false
            }, {"text": "Dust", "emoji": "🌫️", "discovered": false}, {
                "text": "Wave",
                "emoji": "🌊",
                "discovered": false
            }, {"text": "Tornado", "emoji": "🌪️", "discovered": false}, {
                "text": "Volcano",
                "emoji": "🌋",
                "discovered": false
            }, {"text": "Lake", "emoji": "🌊", "discovered": false}, {
                "text": "Island",
                "emoji": "🏝️",
                "discovered": false
            }, {"text": "Lava", "emoji": "🌋", "discovered": false}, {
                "text": "Mountain Range",
                "emoji": "🏔️",
                "discovered": false
            }, {"text": "Fjord", "emoji": "🏞️", "discovered": false}, {
                "text": "Tsunami",
                "emoji": "🌊",
                "discovered": false
            }, {"text": "Ocean", "emoji": "🌊", "discovered": false}, {
                "text": "Tree",
                "emoji": "🌳",
                "discovered": false
            }, {"text": "Forest", "emoji": "🌲", "discovered": false}, {
                "text": "Jungle",
                "emoji": "🌴",
                "discovered": false
            }, {"text": "Earthquake", "emoji": "🌋", "discovered": false}, {
                "text": "Smoke",
                "emoji": "💨",
                "discovered": false
            }, {"text": "Eruption", "emoji": "🌋", "discovered": false}, {
                "text": "Hurricane",
                "emoji": "🌀",
                "discovered": false
            }, {"text": "Steam", "emoji": "💨", "discovered": false}, {
                "text": "Cloud",
                "emoji": "☁️",
                "discovered": false
            }, {"text": "Rain", "emoji": "🌧️", "discovered": false}, {
                "text": "Rainbow",
                "emoji": "🌈",
                "discovered": false
            }, {"text": "Flood", "emoji": "🌊", "discovered": false}, {
                "text": "Unicorn",
                "emoji": "🦄",
                "discovered": false
            }, {"text": "Dragon", "emoji": "🐉", "discovered": false}, {
                "text": "Sea Serpent",
                "emoji": "🐍",
                "discovered": false
            }, {"text": "Kraken", "emoji": "🐙", "discovered": false}, {
                "text": "Poseidon",
                "emoji": "🌊",
                "discovered": false
            }, {"text": "Triton", "emoji": "🔱", "discovered": false}, {
                "text": "Mermaid",
                "emoji": "🧜‍♀️",
                "discovered": false
            }, {"text": "Atlantis", "emoji": "🌊", "discovered": false}, {
                "text": "Sand",
                "emoji": "🏖️",
                "discovered": false
            }, {"text": "Desert", "emoji": "🏜️", "discovered": false}, {
                "text": "Mirage",
                "emoji": "🌵",
                "discovered": false
            }, {"text": "Oasis", "emoji": "🏜️", "discovered": false}, {
                "text": "Cum",
                "emoji": "💦",
                "discovered": false
            }, {"text": "Potato", "emoji": "🥔", "discovered": false}, {
                "text": "Colonel",
                "emoji": "🪖",
                "discovered": false
            }, {"text": "Microprocessors", "emoji": "🖥️", "discovered": false}, {
                "text": "French Fries",
                "emoji": "🍟",
                "discovered": false
            }, {"text": "Mud", "emoji": "💩", "discovered": false}, {
                "text": "Dragonborn",
                "emoji": "🐉",
                "discovered": false
            }, {"text": "French Cum", "emoji": "🥐💦", "discovered": false}]
        }
        sessionStorage.setItem("test-data", JSON.stringify(gameInstance))
    }
    sessionStorage.setItem("listDates", JSON.stringify({"dates": ["2024-04-01", "2024-04-02", "2024-04-03", "2024-04-04", "2024-04-05", "2024-04-06", "2024-04-07", "2024-04-08", "2024-04-09", "2024-04-10", "2024-04-11", "2024-04-12", "2024-04-13", "2024-04-14", "2024-04-15", "2024-04-16", "2024-04-17", "2024-04-18", "2024-04-19", "2024-04-20"]}))
    document.addEventListener('DOMContentLoaded', function () {
        clearButton.addEventListener('mousedown', function () {
            document.querySelector('.instances').innerHTML = ''
        })
        new datedreamer.calendarToggle({
            element: "#calendar",
            format: "YYYY-MM-DD",
            theme: "lite-purple",
            styles: `
                #date-input {
                    width: 80px;
                    background-size: 23px 23px;
                    height: 32px;
                    font-size: 14px;
                    text-align: center;
                    padding: 0 8px 0 8px;
                }`,
            onChange: (e) => {
                checkIfDateAvailable(e.detail)
            }
        })
        if (sessionStorage.getItem('loggedIn') === 'true') document.querySelector('.logout').style.display = 'block';
        else document.querySelector('.login').style.display = 'block';
    })

    function checkIfDateAvailable(text) {
        if (!JSON.parse(sessionStorage.getItem("listDates")).dates.includes(text)) {
            window.alert('Data não disponível')
        }
    }
</script>

</body>
</html>
