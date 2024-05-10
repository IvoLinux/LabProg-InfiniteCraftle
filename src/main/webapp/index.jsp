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

    <script src="${pageContext.request.contextPath}/resources/javascript/datedreamer.js"></script>
    <div class="calendar-container">
        <div id="calendar" class="calendar"></div>
    </div>

    <div class="side-controls">
        <img src="resources/images/clear.svg" class="clear" alt="clear canvas icon"/>
    </div>

    <%@include file="components/element-playground.jsp" %>
    <img src="resources/images/logo.svg" class="logo" alt="logo"/>
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
            "elements": [
            {
                "text": "Water",
                "emoji": "💧",
                "discovered": false
            }, {
                "text": "Fire",
                "emoji": "🔥",
                "discovered": false
            }, {
                "text": "Wind",
                "emoji": "🌬️",
                "discovered": false
            }, {
                "text": "Earth",
                "emoji": "🌍",
                "discovered": false
            }]
        }
        sessionStorage.setItem("test-data", JSON.stringify(gameInstance))
    }
    sessionStorage.setItem("listDates", JSON.stringify({"dates": ["2024-04-01", "2024-04-02", "2024-04-03", "2024-04-04", "2024-04-05", "2024-04-06", "2024-04-07", "2024-04-08", "2024-04-09", "2024-04-10", "2024-04-11", "2024-04-12", "2024-04-13", "2024-04-14", "2024-04-15", "2024-04-16", "2024-04-17", "2024-04-18", "2024-04-19", "2024-04-20"]}))
    document.addEventListener('DOMContentLoaded', function () {
        clearButton.addEventListener('mousedown', function () {
            document.querySelector('.instances').innerHTML = ''
        })
        if (sessionStorage.getItem('loggedIn') === 'true') document.querySelector('.logout').style.display = 'block';
        else document.querySelector('.login').style.display = 'block';
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
    })

    // Implement date changing functionality here. Comm with back will be in this function too
    function checkIfDateAvailable(text) {
        if (!JSON.parse(sessionStorage.getItem("listDates")).dates.includes(text)) {
            window.alert('Data não disponível')
        }
    }
</script>

</body>
</html>
