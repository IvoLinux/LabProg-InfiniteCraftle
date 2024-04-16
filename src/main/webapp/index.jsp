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
<div id="__nuxt">
    <div id="__layout">
        <div class="container">
            <%@include file="components/upper-left-logo.jsp" %>
            <div class="side-controls">
                <img src="resources/images/clear.svg" class="clear" alt="clear canvas icon"/>
            </div>
            <canvas class="particles" width="1920" height="972"></canvas>
            <%@include file="modules/sidebar.jsp" %>
            <%@include file="modules/element-instances.jsp" %>
            <img src="resources/images/logo.svg" class="logo" alt="logo"/>
            <div class="reset">Reset</div>
        </div>
    </div>
</div>
</body>

</html>

