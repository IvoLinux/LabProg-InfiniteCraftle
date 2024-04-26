<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <link href="../resources/css/form.css" rel="stylesheet">
    <link href="../resources/css/modal.css" rel="stylesheet">
    <link href="../global.css" rel="stylesheet">
</head>
<body>
<%@include file="../components/upper-left-logo.jsp" %>

<div class="session">
    <form method="POST" action="/signup" class="log-in" autocomplete="off">
        <h4><span>Infinite Craftle</span></h4>
        <p>Sign up to save your progress</p>
        <span class="error-msg">
        <%
            String error = (String) request.getSession().getAttribute("error");
//            if (error.contains("Authentication")) out.print("Incorrect User or Password");
            out.print("Sign up error");
        %>
        </span>
        <div class="floating-label">
            <input placeholder="Username" type="text" name="username" id="username" autocomplete="off">
            <label for="username">Username:</label>
        </div>
        <div class="floating-label">
            <input placeholder="Password" type="password" name="password" id="password" autocomplete="off">
            <label for="password">Password</label>
        </div>
        <div class="floating-label">
            <input placeholder="Confirm Password" type="password" name="confirm-password" id="confirm-password"
                   autocomplete="off">
            <label for="confirm-password">Password</label>
        </div>
        <button class="btn-open" type="submit" onClick="">Sign up</button>
        <a href="../login" class="discrete" target="_self">Log in</a>
    </form>
</div>

</body>
</html>
