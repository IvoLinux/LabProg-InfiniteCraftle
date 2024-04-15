<style>

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

    .items[data-v-32e5f4a8] {
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
        padding: 9px;
        min-height: calc(100svh - 71px);
        line-height: 0.5em;
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

    .item-emoji[data-v-32e5f4a8] {
        font-size: 15px;
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

    @media screen and (min-width: 1150px) {
        .sidebar[data-v-32e5f4a8] {
            width: 350px;
        }

        .items[data-v-32e5f4a8] {
            min-height: calc(100svh - 76px);
        }

        .item-emoji[data-v-32e5f4a8] {
            font-size: 16px;
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
    }
</style>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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