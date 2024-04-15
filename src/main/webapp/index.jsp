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
    <style data-vue-ssr-id="1a73ea6b:0 2ccdeb7a:0 53aeea86:0 636a0312:0">

        @font-face {
            font-family: Roboto;
            src: url(/_nuxt/fonts/Roboto-Medium.70ace38.woff2);
        }

        @font-face {
            font-family: Roboto;
            font-weight: 700;
            src: url(/_nuxt/fonts/Roboto-Bold.002079d.woff2);
        }

        html {
            font-size: 16px;
            -ms-text-size-adjust: 100%;
            -webkit-text-size-adjust: 100%;
            -moz-osx-font-smoothing: grayscale;
            -webkit-font-smoothing: antialiased;
            box-sizing: border-box;
            color: #000;
            font-family: Roboto, sans-serif;
            background: #fff;
        }

        *,
        :after,
        :before {
            box-sizing: border-box;
            margin: 0;
        }

        @media screen and (max-width: 800px) {
            .infinite-craft-body {
                position: fixed;
                top: 0;
                left: 0;
                overflow: hidden;
            }
        }

        .container[data-v-32e5f4a8] {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            font-family: Roboto, sans-serif;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            --text-color: #040404;
            --background-color: #fff;
            --border-color: #c8c8c8;
            --item-bg: #fff;
            --instance-bg: linear-gradient(0deg, #f7feff, #fff 70%);
            --instance-bg-hover: linear-gradient(0deg, #d6fcff, #fff 90%);
            --instance-border: #91a8c1;
            --instance-border-hover: #91a8c1;
            --sidebar-bg: hsla(0, 0%, 100%, 0.93);
            --discoveries-bg-active: #fff9ea;
            background: var(--background-color);
            color: var(--text-color);
        }

        .sidebar[data-v-32e5f4a8] {
            position: fixed;
            top: 0;
            right: 0;
            width: 305px;
            height: 100vh;
            z-index: 10;
            overflow-y: scroll;
            overflow-x: visible;
            background: var(--sidebar-bg);
            border-left: 1px solid var(--border-color);
            contain: strict;
        }

        .logo[data-v-32e5f4a8] {
            position: fixed;
            top: 10px;
            right: 320px;
            width: 80px;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            pointer-events: none;
        }

        .dark-mode .logo[data-v-32e5f4a8] {
            filter: invert(1);
        }

        .items[data-v-32e5f4a8] {
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
            padding: 9px;
            min-height: calc(100svh - 71px);
            line-height: 0.5em;
        }

        .item[data-v-32e5f4a8] {
            margin: 4px;
            cursor: pointer;
            padding: 8px 8px 7px;
            border-radius: 5px;
            display: inline-block;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            border: 1px solid var(--border-color);
            transition: background 0.15s linear;
            background: var(--item-bg);
            line-height: 1em;
            contain: layout style paint;
        }

        .item-emoji[data-v-32e5f4a8],
        .item[data-v-32e5f4a8] {
            font-size: 15px;
        }

        .is-delete-mode .item[data-v-32e5f4a8] {
            contain: layout style;
            position: relative;
        }

        @keyframes itemRemoveScale-32e5f4a8 {
            0% {
                scale: 0;
            }

            to {
                scale: 1;
            }
        }

        .is-delete-mode .item[data-v-32e5f4a8]:hover {
            background: 0 0;
            border: 1px solid #c8c8c8;
            cursor: auto;
        }

        .instance[data-v-32e5f4a8] {
            position: fixed;
            font-size: 18px;
            z-index: 11;
            left: 0;
            top: 0;
            padding: 11px 10px 10px;
            transition: scale 0.15s ease-in;
            border-radius: 5px;
            transform-origin: center center;
            display: flex;
            align-items: center;
            contain: layout;
            border: 1px solid var(--instance-border);
            background: var(--instance-bg);
        }

        @keyframes pinwheelSpin-32e5f4a8 {
            to {
                rotate: 90deg;
            }
        }

        @keyframes scaleIn-32e5f4a8 {
            0% {
                scale: 0.5;
            }

            to {
                scale: 1;
            }
        }

        @media (hover: hover) {
            .item[data-v-32e5f4a8]:hover {
                background: var(--instance-bg-hover);
                border: 1px solid var(--instance-border-hover);
            }
        }

        @keyframes pulse-32e5f4a8 {
            0% {
                opacity: 0.2;
            }

            to {
                opacity: 0.7;
            }
        }

        .side-controls[data-v-32e5f4a8] {
            position: fixed;
            right: 314px;
            bottom: 7px;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            display: flex;
            grid-gap: 19px;
        }

        .dark-mode .side-controls[data-v-32e5f4a8] {
            filter: invert(1);
        }

        .clear[data-v-32e5f4a8],
        .sound[data-v-32e5f4a8] {
            width: 21px;
            cursor: pointer;
            opacity: 0.8;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        .sound[data-v-32e5f4a8] {
            transform: scale(0.92);
        }

        .dark-mode-icon[data-v-32e5f4a8] {
            width: 21px;
            cursor: pointer;
        }

        .sidebar-controls[data-v-32e5f4a8] {
            position: sticky;
            bottom: 0;
            left: 0;
            width: 100%;
            font-size: 13px;
            text-align: right;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            background: var(--sidebar-bg);
        }

        .sidebar-controls[data-v-32e5f4a8]:after {
            content: "";
            position: absolute;
            top: -30px;
            left: 0;
            width: 100%;
            height: 30px;
            background: linear-gradient(180deg,
            hsla(0, 0%, 100%, 0),
            hsla(0, 0%, 100%, 0.9));
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.15s linear;
        }

        .dark-mode .sidebar-controls[data-v-32e5f4a8]:after {
            background: linear-gradient(180deg, transparent, rgba(0, 0, 0, 0.9));
        }

        .sidebar-controls-fade-show[data-v-32e5f4a8]:after {
            opacity: 1;
        }

        .sidebar-search[data-v-32e5f4a8] {
            display: flex;
            align-items: center;
            justify-content: right;
            position: relative;
            background: var(--background-color);
        }

        .sidebar-sorting[data-v-32e5f4a8] {
            display: grid;
            grid-template-columns: 1fr 1fr;
            text-align: center;
            border-top: 1px solid var(--border-color);
            cursor: pointer;
            grid-gap: 1px;
            background: var(--border-color);
        }

        .sidebar-sorting-item[data-v-32e5f4a8] {
            padding: 7px 0;
            background: var(--background-color);
        }

        .sidebar-input[data-v-32e5f4a8] {
            width: 100%;
            font-size: 15px;
            border: 1px solid var(--border-color);
            border-left: none;
            border-right: none;
            border-bottom: none;
            outline: 0;
            padding: 0 20px 0 40px;
            height: 40px;
            line-height: 18px;
            position: relative;
            background-size: 21px 21px;
            background: url("data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiB2aWV3Qm94PSIwIDAgNTAgNTAiIHZlcnNpb249IjEuMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSIgeG1sbnM6c2VyaWY9Imh0dHA6Ly93d3cuc2VyaWYuY29tLyIgc3R5bGU9ImZpbGwtcnVsZTpldmVub2RkO2NsaXAtcnVsZTpldmVub2RkO3N0cm9rZS1saW5lam9pbjpyb3VuZDtzdHJva2UtbWl0ZXJsaW1pdDoyOyI+CiAgICA8cGF0aCBkPSJNMjEsM0MxMS42MjEsMyA0LDEwLjYyMSA0LDIwQzQsMjkuMzc5IDExLjYyMSwzNyAyMSwzN0MyNC43MTEsMzcgMjguMTQxLDM1LjgwNSAzMC45MzgsMzMuNzgxTDQ0LjA5NCw0Ni45MDZMNDYuOTA2LDQ0LjA5NEwzMy45MDYsMzEuMDYzQzM2LjQ2MSwyOC4wODYgMzgsMjQuMjIzIDM4LDIwQzM4LDEwLjYyMSAzMC4zNzksMyAyMSwzWk0yMSw1QzI5LjI5Nyw1IDM2LDExLjcwMyAzNiwyMEMzNiwyOC4yOTcgMjkuMjk3LDM1IDIxLDM1QzEyLjcwMywzNSA2LDI4LjI5NyA2LDIwQzYsMTEuNzAzIDEyLjcwMyw1IDIxLDVaIiBzdHlsZT0iZmlsbDpyZ2IoMTU5LDE1OSwxNTkpO2ZpbGwtcnVsZTpub256ZXJvOyIvPgo8L3N2Zz4=") no-repeat 10px 10px;
            color: var(--text-color);
        }

        .sidebar-input[data-v-32e5f4a8]::-moz-placeholder {
            opacity: 0.5;
        }

        .sidebar-input[data-v-32e5f4a8]::placeholder {
            opacity: 0.5;
        }

        .dark-mode .sidebar-input[data-v-32e5f4a8]::-moz-placeholder {
            opacity: 0.75;
        }

        .dark-mode .sidebar-input[data-v-32e5f4a8]::placeholder {
            opacity: 0.75;
        }

        .sidebar-input[data-v-32e5f4a8]:after {
            content: "";
            left: 10px;
            top: 50%;
            font-size: 20px;
            pointer-events: none;
        }

        .sidebar-input-close[data-v-32e5f4a8],
        .sidebar-input[data-v-32e5f4a8]:after {
            position: absolute;
            transform: translateY(-50%);
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        .sidebar-input-close[data-v-32e5f4a8] {
            right: 10px;
            top: calc(50% + 1px);
            cursor: pointer;
            opacity: 0.45;
            width: 15px;
        }

        .dark-mode .sidebar-input-close[data-v-32e5f4a8] {
            filter: invert(1);
        }

        .instance-emoji[data-v-32e5f4a8] {
            font-size: 21px;
            margin-right: 5px;
        }

        .instance-hide[data-v-32e5f4a8] {
            display: none !important;
            pointer-events: none !important;
        }

        .particles[data-v-32e5f4a8] {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
        }

        .reset[data-v-32e5f4a8] {
            position: fixed;
            left: 10px;
            bottom: 10px;
            cursor: pointer;
            opacity: 0.7;
            font-size: 15px;
        }

        .sidebar-sorting-icon[data-v-32e5f4a8] {
            height: 13px;
            line-height: 0;
            position: relative;
            top: 2px;
            margin-right: 1px;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            pointer-events: none;
        }

        .dark-mode .sidebar-sorting-icon[data-v-32e5f4a8] {
            filter: invert(1);
        }

        .trash[data-v-32e5f4a8] {
            width: 19px;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        .dark-mode-mobile[data-v-32e5f4a8],
        .sound-mobile[data-v-32e5f4a8] {
            width: 20px;
        }

        .dark-mode .side-controls-mobile[data-v-32e5f4a8] {
            filter: invert(1);
        }

        .side-controls-mobile[data-v-32e5f4a8] {
            position: fixed;
            bottom: 190px;
            right: 10px;
            display: none;
            grid-gap: 14px;
        }

        @keyframes sway-32e5f4a8 {
            0% {
                rotate: -6deg;
            }

            to {
                rotate: 6deg;
            }
        }

        @media screen and (min-width: 1150px) {
            .sidebar[data-v-32e5f4a8] {
                width: 350px;
            }

            .logo[data-v-32e5f4a8] {
                right: 362px;
                width: 85px;
            }

            .item[data-v-32e5f4a8] {
                font-size: 16px;
                padding: 9px 10px 8px;
            }

            .items[data-v-32e5f4a8] {
                min-height: calc(100svh - 76px);
            }

            .item-emoji[data-v-32e5f4a8] {
                font-size: 16px;
            }

            .instance[data-v-32e5f4a8] {
                font-size: 20px;
                padding: 11px 11px 10px;
            }

            .side-controls[data-v-32e5f4a8] {
                right: 361px;
            }

            .clear[data-v-32e5f4a8],
            .sound[data-v-32e5f4a8] {
                width: 23px;
            }

            .dark-mode-icon[data-v-32e5f4a8] {
                width: 22px;
            }

            .trash[data-v-32e5f4a8] {
                width: 20px;
            }

            .sidebar-input[data-v-32e5f4a8] {
                background-size: 23px 23px;
                background-position: 11px 12px;
                height: 45px;
                font-size: 16px;
                line-height: 21px;
                padding-left: 43px;
                padding-top: 2px;
            }

            .sidebar-input-close[data-v-32e5f4a8] {
                width: 18px;
                right: 12px;
            }

        }

        @media screen and (max-width: 800px) {
            .sidebar[data-v-32e5f4a8] {
                width: 100%;
                height: 183px;
                bottom: 0;
                top: auto;
                border-top: 1px solid #9f9f9f;
                overflow-y: hidden;
                overflow-x: scroll;
                border-left: none;
            }

            .sidebar[data-v-32e5f4a8]::-webkit-scrollbar {
                display: none;
            }

            .sidebar-controls[data-v-32e5f4a8] {
                display: none;
            }

            .items[data-v-32e5f4a8] {
                min-height: auto;
                padding: 5px 5px 7px;
                height: 183px;
            }

            .items-inner[data-v-32e5f4a8] {
                height: 100px;
                width: auto;
            }

            .item[data-v-32e5f4a8] {
                width: auto;
                min-height: 32px;
                grid-gap: 5px;
                line-height: 32px;
                font-size: 15px;
                padding: 1px 9px 0;
                border: 1px solid #9f9f9f;
                color: var(--text-color);
                transition: background 0.1s linear;
                touch-action: manipulation;
            }

            .instance[data-v-32e5f4a8] {
                min-height: 34px;
                line-height: 34px;
                font-size: 16px;
            }

            .particles[data-v-32e5f4a8] {
                z-index: 1;
            }

            .side-controls[data-v-32e5f4a8] {
                display: none;
            }

            .logo[data-v-32e5f4a8] {
                position: absolute;
                right: 10px;
                left: auto;
                top: 10px;
            }

            .reset[data-v-32e5f4a8] {
                bottom: 190px;
            }

            .side-controls-mobile[data-v-32e5f4a8] {
                display: flex;
            }
        }
    </style>
    <style>
        @font-face {
            font-family: RobotoCondensedLight;
            src: url(/_nuxt/fonts/RobotoCondensed-Light.f982e4a.woff2);
        }
    </style>
    <style>
        @font-face {
            font-family: RobotoCondensedLight;
            src: url(/_nuxt/fonts/RobotoCondensed-Light.f982e4a.woff2);
        }

        .container[data-v-7b1d768e] {
            margin-left: auto;
            margin-right: auto;
            color: #000;
            font-family: RobotoCondensedLight, sans-serif;
        }

        @media only screen and (max-width: 1280px) {
        }

        @media only screen and (max-width: 1130px) {
        }

        @media only screen and (max-width: 700px) {
        }

        @media only screen and (max-width: 600px) {
        }
    </style>
</head>

<body class="infinite-craft-body vsc-initialized" style="background: white">
<div id="__nuxt">
    <div id="__layout">
        <div data-v-32e5f4a8="" class="container">
            <%@include file="components/upper-left-logo.jsp" %>
            <div data-v-32e5f4a8="" class="side-controls">
                <img data-v-32e5f4a8="" src="./resources/trash.svg" class="trash" alt="delete element icon"/>
                <img data-v-32e5f4a8="" src="./resources/dark-mode.svg" class="dark-mode-icon"
                     alt="toggle dark mode icon"/>
                <img data-v-32e5f4a8="" src="./resources/clear.svg" class="clear" alt="clear canvas icon"/>
                <img data-v-32e5f4a8="" src="./resources/sound.svg" class="sound" alt="toggle sound icon"/>
            </div>
            <div data-v-32e5f4a8="" class="side-controls-mobile">
                <img data-v-32e5f4a8="" src="./resources/dark-mode.svg" class="dark-mode-mobile"
                     alt="toggle dark mode icon"/>
                <img data-v-32e5f4a8="" src="./resources/sound.svg" class="sound-mobile" alt="toggle sound icon"/>
            </div>
            <div data-v-8af1cc2e="" data-v-32e5f4a8=""></div>
            <ins data-v-8af1cc2e="" data-v-32e5f4a8="" data-ad-client="ca-pub-4556406968269041"
                 data-ad-slot="1550169597" data-ad-format="none" class="adsbygoogle" style="
								display: inline-block;
								width: 475px;
								height: 60px;
								position: fixed;
								bottom: 0;
								left: 50%;
								transform: translateX(calc(-50% - 162px));
							"></ins>
            <canvas data-v-32e5f4a8="" class="particles" width="1920" height="972"></canvas>
            <div data-v-32e5f4a8="" class="sidebar">
                <div data-v-32e5f4a8="" class="sidebar-inner">
                    <div data-v-32e5f4a8="" class="items">
                        <div data-v-32e5f4a8="" class="items-inner">
                            <div data-v-32e5f4a8="" class="item item-discovered">
                                <span data-v-32e5f4a8="" class="item-emoji">💧</span>
                                Water
                            </div>
                            <div data-v-32e5f4a8="" class="item item-discovered">
                                <span data-v-32e5f4a8="" class="item-emoji">🔥</span>
                                Fire
                            </div>
                            <div data-v-32e5f4a8="" class="item">
                                <span data-v-32e5f4a8="" class="item-emoji">🌬️</span>
                                Wind
                            </div>
                            <div data-v-32e5f4a8="" class="item">
                                <span data-v-32e5f4a8="" class="item-emoji">🌍</span>
                                Earth
                            </div>
                        </div>
                        <div data-v-32e5f4a8="" style="display: none"></div>
                    </div>
                </div>
                <div data-v-32e5f4a8="" class="sidebar-controls sidebar-controls-fade-show">
                    <div data-v-32e5f4a8="" class="sidebar-sorting">
                        <div data-v-32e5f4a8="" class="sidebar-discoveries sidebar-sorting-item">
                            <img data-v-32e5f4a8="" src="./resources/magic.svg"
                                 class="sidebar-sorting-icon" alt="first discoveries icon"/>
                            Discoveries
                        </div>
                        <div data-v-32e5f4a8="" class="sidebar-sort sidebar-sorting-item">
                            <img data-v-32e5f4a8="" src="./resources/time.svg"
                                 class="sidebar-sorting-icon" alt="sort by time icon"/>
                            Sort by time
                        </div>
                    </div>
                    <div data-v-32e5f4a8="" class="sidebar-search">
                        <input data-v-32e5f4a8="" placeholder="Search (n) items..." class="sidebar-input"/>
                        <img data-v-32e5f4a8="" src="./resources/close.svg"
                             class="sidebar-input-close" style="display: none" alt="close icon"/>
                    </div>
                </div>
            </div>
            <div data-v-32e5f4a8="" class="instances">
                <div data-v-32e5f4a8="">
                    <div data-v-32e5f4a8="" id="instance-0" class="item instance instance-hide">
                        <span data-v-32e5f4a8="" class="instance-emoji">💧</span>
                        Water
                    </div>
                </div>
            </div>
            <img data-v-32e5f4a8="" src="./resources/logo.svg" class="logo" alt="logo"/>
            <div data-v-32e5f4a8="" class="reset">Reset</div>
        </div>
    </div>
</div>
</body>

</html>

