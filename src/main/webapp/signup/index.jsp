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
        <p>Sign up to save your progress:</p>
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
        <%
            // Obtém o valor da variável de sessão
            String error = (String) request.getSession().getAttribute("error");%>
        <button class="btn-open" type="submit" onClick="">Sign up</button>
        <a href="../login" class="discrete" target="_self">Log in</a>
    </form>


    <%
        // Verifica se há erro
        if (error != null) {
    %>
    <!-- Divs para exibir mensagem de erro -->
    <div id="modal-success" class="modal hidden">
        <div>
            <h3>Sign up Fail</h3>
            <p>Usuario ja existente</p>
        </div>
        <button class="btn btn-close">Go to home</button>
    </div>
    <%
    } else {
    %>
    <!-- Divs para outro conteúdo -->
    <div id="modal-success" class="modal hidden">
        <div>
            <h3>Sign up Successful</h3>
            <p>Press the button to be redirected to the home page</p>
        </div>
        <button class="btn btn-close">Go to home</button>
    </div>
    <%
        }
    %>

    <%--    <div id="modal-fail" class="modal hidden">--%>
    <%--        <div>--%>
    <%--            <h3>Sign up Failed</h3>--%>
    <%--            <p>Username already taken</p>--%>
    <%--        </div>--%>
    <%--        <button class="btn btn-close">Close</button>--%>
    <%--    </div>--%>
</div>

</body>
</html>
