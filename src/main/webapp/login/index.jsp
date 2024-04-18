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
    <form action="" class="log-in" autocomplete="off">
        <h4><span>Infinite Craftle</span></h4>
        <p>Log in to recover your progress:</p>
        <div class="floating-label">
            <input placeholder="Username" type="text" name="username" id="username" autocomplete="off">
            <label for="username">Username:</label>
        </div>
        <div class="floating-label">
            <input placeholder="Password" type="password" name="password" id="password" autocomplete="off">
            <label for="password">Password:</label>
        </div>
        <button class="btn-open" type="button" onClick="">Log in</button>
        <a href="../signup/" class="discrete" target="_self">Sign up</a>
    </form>

    <div>
        <% String
        %>>
    </div>

    <div id="modal-success" class="modal hidden">
        <div>
            <h3>Logged in Successfully</h3>
            <p>Press the button to be redirected to the home page</p>
        </div>
        <button class="btn btn-close">Go to home</button>
    </div>
    <%--    <div id="modal-fail" class="modal hidden">--%>
    <%--        <div>--%>
    <%--            <h3>Login Failed</h3>--%>
    <%--            <p>Incorrect Username or Password</p>--%>
    <%--        </div>--%>
    <%--        <button class="btn btn-close">Close</button>--%>
    <%--    </div>--%>
</div>

<div class="overlay hidden"></div>

<script>
    const modal = document.querySelector(".modal");
    const overlay = document.querySelector(".overlay");
    const openModalBtn = document.querySelector(".btn-open");
    const closeModalBtn = document.querySelector(".btn-close");

    const openModal = function () {
        modal.classList.remove("hidden");
        overlay.classList.remove("hidden");
    };

    const closeModal = function () {
        modal.classList.add("hidden");
        overlay.classList.add("hidden");
    };

    closeModalBtn.addEventListener("click", closeModal);
    overlay.addEventListener("click", closeModal);
    openModalBtn.addEventListener("click", openModal);

    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape" && !modal.classList.contains("hidden")) closeModal();
    });
</script>

<script>if (window.location.pathname.includes("/components/")) window.location.href = '<%= request.getContextPath() %>'</script>

</body>
</html>
