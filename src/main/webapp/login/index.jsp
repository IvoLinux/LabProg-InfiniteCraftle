<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="index.css" rel="stylesheet">
    <link href="../global.css" rel="stylesheet">
</head>
<body>
<%@include file="../components/upper-left-logo.jsp"%>
<div class="container">
    <form action="" method="post">
        <div>
            <label>
                Username
                <input type="text" name="login-username" placeholder="Username" required/>
            </label>
        </div>
        <div>
            <label>
                Password
                <input type="password" name="login-password" placeholder="Password" required/>
            </label>
        </div>
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>
