<%String resourcesURL = request.getContextPath() + "/resources";%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<link rel="stylesheet" href="<%= resourcesURL + "/css/sidebar.css"%>">--%>
<style>
    .sidebar {
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

    .items {
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
        padding: 9px;
        min-height: calc(100svh - 71px);
        line-height: 0.5em;
    }

    .item {
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
        font-size: 15px;
    }

    .is-delete-mode .item {
        contain: layout style;
        position: relative;
    }

    .is-delete-mode .item:hover {
        background: 0 0;
        border: 1px solid #c8c8c8;
        cursor: auto;
    }

    .sidebar-controls {
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

    .sidebar-controls:after {
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

    .sidebar-controls-fade-show:after {
        opacity: 1;
    }

    .sidebar-search {
        display: flex;
        align-items: center;
        justify-content: right;
        position: relative;
        background: var(--background-color);
    }

    .sidebar-sorting {
        display: grid;
        grid-template-columns: 1fr 1fr;
        text-align: center;
        border-top: 1px solid var(--border-color);
        cursor: pointer;
        grid-gap: 1px;
        background: var(--border-color);
    }

    .sidebar-sorting-item {
        padding: 7px 0;
        background: var(--background-color);
    }

    .sidebar-input {
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
        background-size: 21px 21px !important;
        background: url("https://neal.fun/infinite-craft/search.svg") no-repeat 10px 10px;
        color: var(--text-color);
    }

    .sidebar-input::-moz-placeholder {
        opacity: 0.5;
    }

    .sidebar-input::placeholder {
        opacity: 0.5;
    }

    .sidebar-input:after {
        content: "";
        left: 10px;
        top: 50%;
        font-size: 20px;
        pointer-events: none;
    }

    .sidebar-input-close,
    .sidebar-input:after {
        position: absolute;
        transform: translateY(-50%);
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
    }

    .sidebar-input-close {
        right: 10px;
        top: calc(50% + 1px);
        cursor: pointer;
        opacity: 0.45;
        width: 15px;
    }

    .sidebar-sorting-icon {
        line-height: 0;
        position: relative;
        top: 2px;
        margin-right: 1px;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
        pointer-events: none;
    }

    @media (hover: hover) {
        .item:hover {
            background: var(--instance-bg-hover);
            border: 1px solid var(--instance-border-hover);
        }
    }

    @media screen and (min-width: 1150px) {
        .sidebar {
            width: 350px;
        }

        .items {
            min-height: calc(100svh - 76px);
        }

        .item {
            font-size: 16px;
            padding: 9px 10px 8px;
        }

        .sidebar-input {
            background-size: 23px 23px;
            background-position: 11px 12px;
            height: 45px;
            font-size: 16px;
            line-height: 21px;
            padding-left: 43px;
            padding-top: 2px;
        }

        .sidebar-input-close {
            width: 18px;
            right: 12px;
        }
    }

    @media screen and (max-width: 800px) {
        .sidebar {
            width: 100%;
            height: 183px;
            bottom: 0;
            top: auto;
            border-top: 1px solid #9f9f9f;
            overflow-y: hidden;
            overflow-x: scroll;
            border-left: none;
        }

        .sidebar::-webkit-scrollbar {
            display: none;
        }

        .sidebar-controls {
            display: none;
        }

        .items {
            min-height: auto;
            padding: 5px 5px 7px;
            height: 183px;
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

        .items-inner {
            height: 100px;
            width: auto;
        }
    }

    .instance {
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

    .instances {
        overflow: auto;
    }

    .instance-emoji {
        font-size: 21px;
        margin-right: 5px;
        pointer-events: none;
    }

    .instance-hide {
        display: none !important;
        pointer-events: none !important;
    }

    .instance-hover {
        scale: 1.04;
        background: var(--instance-bg-hover);
        border: 1px solid var(--instance-border-hover);
    }

    @media screen and (min-width: 1150px) {
        .instance {
            font-size: 20px;
            padding: 11px 11px 10px;
        }
    }

    @media screen and (max-width: 800px) {
        .instance {
            min-height: 34px;
            line-height: 34px;
            font-size: 16px;
        }
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
        display: none;
    }
</style>

<div class="sidebar">
    <div class="sidebar-inner">
        <div class="items">
            <div class="items-inner"></div>
        </div>
    </div>
    <div class="sidebar-controls sidebar-controls-fade-show">
        <div class="sidebar-sorting">
            <div class="sidebar-discoveries sidebar-sorting-item">
                <svg width="13px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 50 50">
                    <path d="M49.306 26.548l-11.24-3.613-3.613-11.241C34.319 11.28 33.935 11 33.5 11s-.819.28-.952.694l-3.613 11.241-11.24 3.613C17.28 26.681 17 27.065 17 27.5s.28.819.694.952l11.24 3.613 3.613 11.241C32.681 43.72 33.065 44 33.5 44s.819-.28.952-.694l3.613-11.241 11.24-3.613C49.72 28.319 50 27.935 50 27.5S49.72 26.681 49.306 26.548zM1.684 13.949l7.776 2.592 2.592 7.776C12.188 24.725 12.569 25 13 25s.813-.275.948-.684l2.592-7.776 7.776-2.592C24.725 13.813 25 13.431 25 13s-.275-.813-.684-.949L16.54 9.459l-2.592-7.776C13.813 1.275 13.431 1 13 1s-.813.275-.948.684L9.46 9.459l-7.776 2.592C1.275 12.188 1 12.569 1 13S1.275 13.813 1.684 13.949zM17.316 39.05l-5.526-1.842-1.842-5.524C9.813 31.276 9.431 31 9 31s-.813.275-.948.684L6.21 37.208.685 39.05c-.408.136-.684.518-.684.949s.275.813.684.949l5.526 1.842 1.841 5.524C8.188 48.721 8.569 48.997 9 48.997s.813-.275.948-.684l1.842-5.524 5.526-1.842C17.725 40.811 18 40.429 18 39.999S17.725 39.186 17.316 39.05z"></path>
                </svg>
                Discoveries
            </div>
            <div class="sidebar-sort sidebar-sorting-item">
                <svg width="13px" viewBox="0 0 43 47" xmlns="http://www.w3.org/2000/svg" xml:space="preserve"
                     style="fill-rule:evenodd;clip-rule:evenodd;stroke-linejoin:round;stroke-miterlimit:2;">
    <g transform="matrix(1,0,0,1,-3.725,-1.725)">
        <path d="M21,2L21,5L23,5L23,6.098C12.35,7.107 4,16.089 4,27C4,38.586 13.414,48 25,48C36.586,48 46,38.586 46,27C46,16.089 37.65,7.107 27,6.098L27,5L29,5L29,2L21,2ZM40.236,5.146L38.23,7.152L42.846,11.768L44.852,9.762L40.236,5.146ZM25,8C35.505,8 44,16.495 44,27C44,37.505 35.505,46 25,46C14.495,46 6,37.505 6,27C6,16.495 14.495,8 25,8ZM14.99,15.99C14.442,15.99 13.99,16.442 13.99,16.99C13.99,17.26 14.1,17.519 14.293,17.707L23.07,26.484C23.025,26.652 23.001,26.826 23,27C23,28.097 23.903,29 25,29C25.175,29 25.349,28.977 25.518,28.932L27.293,30.707C27.481,30.903 27.742,31.014 28.014,31.014C28.563,31.014 29.014,30.563 29.014,30.014C29.014,29.742 28.903,29.481 28.707,29.293L26.93,27.516C26.975,27.348 26.999,27.174 27,27C27,25.903 26.097,25 25,25C24.825,25 24.651,25.023 24.482,25.068L15.707,16.293C15.519,16.1 15.26,15.99 14.99,15.99Z"
              style="fill-rule:nonzero;stroke:black;stroke-width:0.55px;"></path>
    </g>
</svg>
                Sort by time
            </div>
        </div>
        <div class="sidebar-search">
            <input class="sidebar-input"/>
            <img src="<%= resourcesURL + "/images/close.svg" %>" class="sidebar-input-close" style="display: none"
                 alt="close icon"/>
        </div>
    </div>
</div>
<div class="instances">
    <div id="instance-0" class="item instance instance-hide">
        <span class="instance-emoji">💧</span>
        Water
    </div>
</div>

<script>
    const itemSidebar = document.querySelector('.items-inner')
    const itemInstances = document.querySelector('.instances')
    const input = document.querySelector('.sidebar-input');
    let instanceIdTracker = 10;

    // Waits for DOM to fully load
    document.addEventListener('DOMContentLoaded', function () {
        // Retrieves local storage
        let retrievedData0 = sessionStorage.getItem("test-data")
        let elements = JSON.parse(retrievedData0).elements
        // Fills element sidebar
        elements.forEach(item => {
            itemSidebar.appendChild(createElement(item.emoji, item.text))
        });
        document.querySelector('.sidebar-input').placeholder = 'Search (' + elements.length + ') items...';

        // Adds an on click event listener to all "item" divs in Sidebar
        itemSidebar.addEventListener('mousedown', function (event) {
            if (event.target.classList.contains('item')) {
                // Copies the item and implements dragging functionality
                const itemInstance = event.target.cloneNode(true)
                itemInstance.classList.add('instance')
                itemInstances.appendChild(itemInstance)
                instanceIdTracker++
                itemInstance.id = 'instance-' + instanceIdTracker
                handleItemDrag(event, itemInstance)
            }
        })

        // Adds an on click event listener to all "item" instances
        itemInstances.addEventListener('mousedown', function (event) {
            // Drags item
            instanceIdTracker++
            if (event.target.classList.contains('item')) handleItemDrag(event, event.target)
        })

        // Updates visible elements based on search input
        input.addEventListener('input', function () {
            const searchText = input.value.toLowerCase();
            const items = document.querySelectorAll('.items-inner .item');
            items.forEach(function (item) {
                const itemText = item.textContent.toLowerCase();
                if (itemText.includes(searchText)) item.style.display = 'inline-block';
                else item.style.display = 'none';
            });
        });
    })
    const sendRequest = async (component, matchedElement) => {
        const url = 'http://localhost:8080/home' // Substitua pelo URL do seu servidor
        const data = {
            'type': 'craft',
            'parent1': component.innerText.replace(/^[^A-Za-z0-9]*/, ''),
            'parent2': matchedElement.innerText.replace(/^[^A-Za-z0-9]*/, '')
        };
        try {
            var json = JSON.stringify(data);
            console.log("oi" + json)

            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Accept': 'application/json, text/plain, *//*',
                    'Content-Type': 'application/json'
                },
                body: json
            });

            const responseData = await response.text();
            console.log(responseData + "dsfds"); // Aqui você pode fazer o que quiser com os dados retornados pelo servidor
        } catch (error) {
            console.error('Erro ao enviar os dados:', error);
        }
    };

    function handleItemDrag(event, component) {
        // Adds selected class and saves initial cursor offset
        component.classList.add('instance-selected')
        component.style.zIndex = instanceIdTracker + ''
        const shiftX = event.clientX - event.target.getBoundingClientRect().left + 4
        const shiftY = event.clientY - event.target.getBoundingClientRect().top + 4
        // Adds event listeners for dragging/dropping
        document.addEventListener('mouseup', stopElementDrag)
        document.addEventListener('mousemove', updateComponentPosition)
        updateComponentPosition(event)

        function updateComponentPosition(event) {
            // Updates (x, y) of the component
            component.style.left = event.pageX - shiftX + 'px'
            component.style.top = event.pageY - shiftY + 'px'
            // Adds instance-hover class highest Z and intersecting
            for (let j = 0; j < itemInstances.children.length; j++) itemInstances.children[j].classList.remove('instance-hover')
            if (getHighestZ(component) !== null) getHighestZ(component).classList.add('instance-hover')
        }

        function stopElementDrag() {
            const matchedElement = document.querySelector('.instance-hover')
            if (matchedElement !== null) {
                instanceIdTracker++
                sendRequest(component, matchedElement)
                    .then(result => {

                    })
                    .catch(error => {
                        // Lidar com erros da chamada assíncrona, se houver
                        console.error('Erro na chamada assíncrona:', error);
                    });
                const text = ""
                const emoji = "🔥";
                const newElement = createElement(emoji, text, true)
                newElement.id = 'instance-' + instanceIdTracker
                newElement.style.zIndex = instanceIdTracker + ''
                newElement.style.left = (parseFloat(matchedElement.style.left) + parseFloat(component.style.left)) / 2 + 'px'
                newElement.style.top = (parseFloat(matchedElement.style.top) + parseFloat(component.style.top)) / 2 + 'px'
                itemInstances.appendChild(newElement)
                let elementExists = false
                for (let i = 0; i < itemSidebar.children.length; i++) {
                    if (itemSidebar.children[i].innerText.replace(/^[^A-Za-z0-9]*/, '') === text) elementExists = true
                }

                if (!elementExists) {
                    itemSidebar.appendChild(createElement(emoji, text))
                    let data = JSON.parse(sessionStorage.getItem('test-data'))
                    data.elements.push({
                        "text": text,
                        "emoji": emoji,
                        "discovered": false
                    })
                    sessionStorage.setItem('test-data', JSON.stringify(data))
                    document.querySelector('.sidebar-input').placeholder = 'Search (' + itemSidebar.children.length + ') items...';
                }
                matchedElement.remove()
                component.remove()
            }
            document.removeEventListener('mouseup', stopElementDrag)
            document.removeEventListener('mousemove', updateComponentPosition)
            component.classList.remove('instance-selected')
            let children = itemInstances.children
            for (let i = 0; i < children.length; i++) children[i].classList.remove('instance-hover')
            if (doDivsOverlap(component, document.querySelector('.items'))) component.remove()
        }
    }

    function getHighestZ(selected) {
        let highestZIndex = -Infinity
        let highestZIndexChild = null
        for (let i = 0; i < itemInstances.children.length; i++) {
            const child = itemInstances.children[i]
            if (child.id === selected.id) continue
            if (!doDivsOverlap(child, selected)) continue
            const zIndex = parseInt(child.style.zIndex)
            if (zIndex > highestZIndex) {
                highestZIndex = zIndex
                highestZIndexChild = child
            }
        }
        return highestZIndexChild
    }

    function createElement(emoji, text, instance = false) {
        const newElement = document.createElement('div')
        if (instance) newElement.classList.add('instance')
        newElement.classList.add('item')
        const emojiElement = document.createElement('span')
        emojiElement.classList.add('instance-emoji')
        emojiElement.textContent = emoji
        const textNode = document.createTextNode(text)
        newElement.appendChild(emojiElement)
        newElement.appendChild(textNode)
        return newElement
    }

    function doDivsOverlap(div1, div2) {
        const rect1 = div1.getBoundingClientRect();
        const rect2 = div2.getBoundingClientRect();

        return !(rect1.right < rect2.left ||
            rect1.left > rect2.right ||
            rect1.bottom < rect2.top ||
            rect1.top > rect2.bottom);
    }

</script>