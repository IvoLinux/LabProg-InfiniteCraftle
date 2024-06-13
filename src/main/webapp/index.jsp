<%@ page import="com.google.gson.Gson" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css"/>
</head>

<body class="infinite-craft-body vsc-initialized" style="background: white">
<div class="container">
    <%@include file="components/upper-left-logo.jsp" %>

    <script src="${pageContext.request.contextPath}/resources/javascript/datedreamer.js"></script>
    <div id="calendar-container" class="calendar-container">
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
    <div class="overlay hidden">
        <div id="modal-fail" class="modal">
            <div>
                <h2>You have found today's element of the day!</h2><br>
                <p id="modal-element-text">Element</p>
                <p id="modal-score-text">Score</p>
                <br>
                <h5>You may keep playing, however this day's score will no longer change</h5>
            </div>
            <button class="btn btn-close">Close</button>
        </div>
    </div>
</div>

<script>
    const clearButton = document.querySelector('.clear')
    const game = <%= new Gson().toJson(session.getAttribute("game")) %>;
    const listDates = <%= new Gson().toJson(session.getAttribute("listDates")) %>;
    if (game && game.elements) sessionStorage.setItem("game", JSON.stringify(game))
    if (listDates) sessionStorage.setItem("listDates", JSON.stringify(listDates))

    clearButton.addEventListener('mousedown', function () {
        document.querySelector('.instances').innerHTML = ''
    })
    if (sessionStorage.getItem('loggedIn') === 'true') document.querySelector('.logout').style.display = 'block';
    else document.querySelector('.login').style.display = 'block';
</script>
<script src="${pageContext.request.contextPath}/resources/javascript/homeCalendar.js"></script>
<script src="${pageContext.request.contextPath}/resources/javascript/modal.js"></script>

</body>
</html>
