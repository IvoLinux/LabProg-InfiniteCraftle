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
    <div class="side-controls">
        <img src="resources/images/clear.svg" class="clear" alt="clear canvas icon"/>
    </div>
    <canvas class="particles" width="1920" height="972"></canvas>
    <%@include file="modules/element-playground.jsp" %>
    <img src="resources/images/logo.svg" class="logo" alt="logo"/>
    <div class="reset">Reset</div>
</div>

<script>
    let retrievedData = localStorage.getItem("test-data")
    if(retrievedData == null){
        let data = {"date": "15/04", "elements":[{"text":"Water","emoji":"💧","discovered":true},{"text":"Fire","emoji":"🔥","discovered":true},{"text":"Wind","emoji":"🌬️","discovered":false},{"text":"Earth","emoji":"🌍","discovered":false},{"text":"Ebert is Mega Gay","emoji":"🏳️‍🌈","discovered":true},{"text":"Mountain","emoji":"🏔️","discovered":false},{"text":"Dust","emoji":"🌫️","discovered":false},{"text":"Wave","emoji":"🌊","discovered":false},{"text":"Tornado","emoji":"🌪️","discovered":false},{"text":"Volcano","emoji":"🌋","discovered":false},{"text":"Lake","emoji":"🌊","discovered":false},{"text":"Island","emoji":"🏝️","discovered":false},{"text":"Lava","emoji":"🌋","discovered":false},{"text":"Mountain Range","emoji":"🏔️","discovered":false},{"text":"Fjord","emoji":"🏞️","discovered":false},{"text":"Tsunami","emoji":"🌊","discovered":false},{"text":"Ocean","emoji":"🌊","discovered":false},{"text":"Tree","emoji":"🌳","discovered":false},{"text":"Forest","emoji":"🌲","discovered":false},{"text":"Jungle","emoji":"🌴","discovered":false},{"text":"Earthquake","emoji":"🌋","discovered":false},{"text":"Smoke","emoji":"💨","discovered":false},{"text":"Eruption","emoji":"🌋","discovered":false},{"text":"Hurricane","emoji":"🌀","discovered":false},{"text":"Steam","emoji":"💨","discovered":false},{"text":"Cloud","emoji":"☁️","discovered":false},{"text":"Rain","emoji":"🌧️","discovered":false},{"text":"Rainbow","emoji":"🌈","discovered":false},{"text":"Flood","emoji":"🌊","discovered":false},{"text":"Unicorn","emoji":"🦄","discovered":false},{"text":"Dragon","emoji":"🐉","discovered":false},{"text":"Sea Serpent","emoji":"🐍","discovered":false},{"text":"Kraken","emoji":"🐙","discovered":false},{"text":"Poseidon","emoji":"🌊","discovered":false},{"text":"Triton","emoji":"🔱","discovered":false},{"text":"Mermaid","emoji":"🧜‍♀️","discovered":false},{"text":"Atlantis","emoji":"🌊","discovered":false},{"text":"Sand","emoji":"🏖️","discovered":false},{"text":"Desert","emoji":"🏜️","discovered":false},{"text":"Mirage","emoji":"🌵","discovered":false},{"text":"Oasis","emoji":"🏜️","discovered":false},{"text":"Cum","emoji":"💦","discovered":false},{"text":"Potato","emoji":"🥔","discovered":false},{"text":"Colonel","emoji":"🪖","discovered":false},{"text":"Microprocessors","emoji":"🖥️","discovered":false},{"text":"French Fries","emoji":"🍟","discovered":false},{"text":"Mud","emoji":"💩","discovered":false},{"text":"Dragonborn","emoji":"🐉","discovered":false},{"text":"French Cum","emoji":"🥐💦","discovered":false}]}
        localStorage.setItem("test-data", JSON.stringify(data))
    }
</script>


</body>

</html>

