<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <%--    <link href="../resources/css/form.css" rel="stylesheet">--%>
    <%--    <link href="../resources/css/modal.css" rel="stylesheet">--%>
    <%--    <link href="../global.css" rel="stylesheet">--%>

    <style>
        body {
            height: 100vh;
            width: 100vw;
            margin: 0 0;
            display: flex;
            align-items: flex-start;
            justify-content: flex-start;
            background: url("https://img.freepik.com/free-vector/light-grey-dots-background_78370-2583.jpg?t=st=1713324459~exp=1713325059~hmac=a6a3c443e894f26da1cc303868fc9d9caafb1ab853913d48c589f1febccb7724");
        }

        h4 {
            font-size: 30px;
            font-weight: 600;
        }

        label {
            font-size: 13px;
            color: #000;
            opacity: 0.8;
            font-weight: 400;
        }

        form {
            background: #fefefe;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 40px 30px 20px;
        }

        form h4 {
            margin-bottom: 20px;
            color: rgba(0, 0, 0, 0.5);
        }

        form h4 span {
            color: black;
            font-weight: 700;
        }

        form p {
            line-height: 155%;
            font-size: 14px;
            color: #000;
            opacity: 0.7;
            font-weight: 400;
            max-width: 200px;
            margin-bottom: 40px;
        }

        a.discrete {
            color: rgba(0, 0, 0, 0.4);
            font-size: 14px;
            border-bottom: solid 1px rgba(0, 0, 0, 0);
            padding-bottom: 4px;
            margin-left: auto;
            font-weight: 300;
            transition: all 0.3s ease;
            margin-top: 40px;
        }

        a.discrete:hover {
            border-bottom: solid 1px rgba(0, 0, 0, 0.2);
        }

        button {
            -webkit-appearance: none;
            width: auto;
            min-width: 100px;
            border-radius: 24px;
            text-align: center;
            padding: 15px 40px;
            margin-top: 5px;
            background-color: #383d69;
            color: #fff;
            font-size: 14px;
            margin-left: auto;
            font-weight: 500;
            box-shadow: 0 2px 6px -1px rgba(0, 0, 0, 0.13);
            border: none;
            transition: all 0.3s ease;
            outline: 0;
            cursor: pointer;
        }

        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 2px 6px -1px rgba(182, 157, 230, 0.65);
        }

        button:hover:active {
            transform: scale(0.99);
        }

        input {
            font-size: 16px;
            padding: 20px 0;
            height: 56px;
            border: none;
            border-bottom: solid 1px rgba(0, 0, 0, 0.1);
            background: #fff;
            min-width: 280px;
            box-sizing: border-box;
            transition: all 0.3s linear;
            color: #000;
            font-weight: 400;
            -webkit-appearance: none;
        }

        input:focus {
            border-bottom: solid 1px #b69de6;
            outline: 0;
            box-shadow: 0 2px 6px -8px rgba(182, 157, 230, 0.45);
        }

        .floating-label {
            position: relative;
            margin-bottom: 10px;
        }

        .floating-label label {
            position: absolute;
            top: calc(50% - 7px);
            left: 0;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .floating-label input:not {
            padding: 28px 0 12px 0;
        }

        .floating-label input:not(:-ms-input-placeholder) {
            padding: 28px 0 12px 0;
        }

        .floating-label input:not(:placeholder-shown) {
            padding: 28px 0 12px 0;
        }

        .floating-label input:not + label {
            transform: translateY(-10px);
            opacity: 0.7;
        }

        .floating-label input:not(:-ms-input-placeholder) + label {
            transform: translateY(-10px);
            opacity: 0.7;
        }

        .floating-label input:not(:placeholder-shown) + label {
            transform: translateY(-10px);
            opacity: 0.7;
        }

        .session {
            display: flex;
            justify-content: center;
            align-items: center;
            width: auto;
            height: auto;
            margin: auto auto;
            background: #ffffff;
            border-radius: 4px;
            box-shadow: 0 2px 6px -1px rgba(0, 0, 0, 0.12);
        }

        .left {
            width: 220px;
            height: auto;
            min-height: 100%;
            position: relative;
            background-image: url("https://images.pexels.com/photos/114979/pexels-photo-114979.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
            background-size: cover;
            border-top-left-radius: 4px;
            border-bottom-left-radius: 4px;
        }

        .left svg {
            height: 40px;
            width: auto;
            margin: 20px;
        }
    </style>
    <style>
        html,
        body {
            font-family: Roboto, sans-serif;
            scroll-behavior: smooth;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        .hidden {
            display: none !important;
        }

        .modal {
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 0.4rem;
            width: 450px;
            padding: 1.3rem;
            min-height: 250px;
            z-index: 2;
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 15px;
            position: absolute;
        }

        .modal p {
            font-size: 0.9rem;
            color: #777;
            margin: 0.6rem 0 0.8rem;
        }

        .overlay {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(3px);
            z-index: 1;
        }

    </style>
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

</body>
</html>
