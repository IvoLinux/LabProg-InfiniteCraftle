<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="../resources/css/form.css" rel="stylesheet">
    <link href="../resources/css/modal.css" rel="stylesheet">
    <link href="../global.css" rel="stylesheet">
</head>
<body>
<%@include file="../components/upper-left-logo.jsp" %>

<div class="session">
    <form id="loginForm" method="POST" action="/login" class="log-in" autocomplete="off">
        <h4><span>Infinite Craftle</span></h4>
        <p>Log in to recover your progress</p>
        <span class="error-msg">
        <%
            String error = (String) request.getSession().getAttribute("error");
            if (error.contains("Authentication")) out.print("Incorrect User or Password");
        %>
        </span>
        <div class="floating-label">
            <input placeholder="Username" type="text" name="username" id="username" autocomplete="off">
            <label for="username">Username:</label>
        </div>
        <div class="floating-label">
            <input placeholder="Password" type="password" name="password" id="password" autocomplete="off">
            <label for="password">Password:</label>
        </div>
        <button class="btn-open" type="submit" value="Login" onClick="">Log in</button>
        <a href="../signup" class="discrete" target="_self">Sign up</a>
    </form>
</div>

</body>
</html>
