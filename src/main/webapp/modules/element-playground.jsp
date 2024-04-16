<%String resourcesURL = request.getContextPath() + "/resources";%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="<%= resourcesURL + "/css/sidebar.css"%>">

<div class="sidebar">
    <div class="sidebar-inner">
        <div class="items">
            <div class="items-inner"></div>
        </div>
    </div>
    <div class="sidebar-controls sidebar-controls-fade-show">
        <div class="sidebar-sorting">
            <div class="sidebar-discoveries sidebar-sorting-item">
                <img src="<%= resourcesURL + "/magic.svg" %>" class="sidebar-sorting-icon"
                     alt="first discoveries icon"/>
                Discoveries
            </div>
            <div class="sidebar-sort sidebar-sorting-item">
                <img src="<%= resourcesURL + "/time.svg" %>" class="sidebar-sorting-icon"
                     alt="sort by time icon" height="13px"/>
                Sort by time
            </div>
        </div>
        <div class="sidebar-search">
            <input placeholder="Search (n) items..." class="sidebar-input"/>
            <img src="<%= resourcesURL + "/close.svg" %>" class="sidebar-input-close" style="display: none"
                 alt="close icon"/>
        </div>
    </div>
</div>
<div class="instances">
    <div>
        <div id="instance-0" class="item instance instance-hide">
            <span class="instance-emoji">💧</span>
            Water
        </div>
        <div id="instance-1" class="item instance" style="translate: 292px 249px; z-index: 22;">
            <span class="instance-emoji">🥐💦</span>
            French Cum
        </div>
    </div>
</div>

<script>
    // Waits for DOM to fully load
    document.addEventListener('DOMContentLoaded', function () {
        // Retrieves local storage and creates components for each element
        let retrievedData0 = localStorage.getItem("test-data")
        let elements = JSON.parse(retrievedData0).elements
        const itemsContainer = document.querySelector('.items-inner')
        elements.forEach(item => {
            const itemElement = document.createElement('div')
            itemElement.classList.add('item')
            if (item.discovered) itemElement.classList.add('item-discovered')

            const emojiElement = document.createElement('span')
            emojiElement.classList.add('item-emoji')
            emojiElement.textContent = item.emoji
            const textNode = document.createTextNode(item.text)

            itemElement.appendChild(emojiElement)
            itemElement.appendChild(textNode)
            itemsContainer.appendChild(itemElement)
        });

        // Adds an on click event listener to all "item" divs
        itemsContainer.addEventListener('mousedown', function (event) {
            if (event.target.classList.contains('item')) {
                let shiftX = event.clientX - event.target.getBoundingClientRect().left;
                let shiftY = event.clientY - event.target.getBoundingClientRect().top;

                event.target.style.position = 'absolute';
                event.target.style.zIndex = 1000;
                document.body.append(event.target);

                moveAt(event.pageX, event.pageY);

                // moves the ball at (pageX, pageY) coordinates
                // taking initial shifts into account
                function moveAt(pageX, pageY) {
                    event.target.style.left = pageX - shiftX + 'px';
                    event.target.style.top = pageY - shiftY + 'px';
                }

                function onMouseMove(event) {
                    moveAt(event.pageX, event.pageY);
                }

                // move the ball on mousemove
                document.addEventListener('mousemove', onMouseMove);

                // drop the ball, remove unneeded handlers
                event.target.onmouseup = function () {
                    document.removeEventListener('mousemove', onMouseMove);
                    event.target.onmouseup = null;
                }
            }
        })
    })
</script>