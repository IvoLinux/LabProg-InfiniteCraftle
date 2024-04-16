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
                <img src="<%= resourcesURL + "/images/magic.svg" %>" class="sidebar-sorting-icon"
                     alt="first discoveries icon" height="13px"/>
                Discoveries
            </div>
            <div class="sidebar-sort sidebar-sorting-item">
                <img src="<%= resourcesURL + "/images/time.svg" %>" class="sidebar-sorting-icon"
                     alt="sort by time icon" height="13px"/>
                Sort by time
            </div>
        </div>
        <div class="sidebar-search">
            <input placeholder="Search (n) items..." class="sidebar-input"/>
            <img src="<%= resourcesURL + "/images/close.svg" %>" class="sidebar-input-close" style="display: none"
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
    </div>
</div>

<script>
    const itemSidebar = document.querySelector('.items-inner')
    const itemInstances = document.querySelector('.instances')

    function handleItemDrag(event, component) {
        const shiftX = event.clientX - event.target.getBoundingClientRect().left + 4
        const shiftY = event.clientY - event.target.getBoundingClientRect().top + 4

        function updateComponentPosition(event) {
            component.style.left = event.pageX - shiftX + 'px'
            component.style.top = event.pageY - shiftY + 'px'
        }

        function stopElementDrag() {
            document.removeEventListener('mouseup', stopElementDrag)
            document.removeEventListener('mousemove', updateComponentPosition)
        }

        document.addEventListener('mouseup', stopElementDrag)
        document.addEventListener('mousemove', updateComponentPosition)
        updateComponentPosition(event)
    }

    // Waits for DOM to fully load
    document.addEventListener('DOMContentLoaded', function () {
        // Retrieves local storage
        let retrievedData0 = localStorage.getItem("test-data")
        let elements = JSON.parse(retrievedData0).elements
        // Creates a component for each element
        elements.forEach(item => {
            const itemComponent = document.createElement('div')
            itemComponent.classList.add('item')
            if (item.discovered) itemComponent.classList.add('item-discovered')

            const emojiElement = document.createElement('span')
            emojiElement.classList.add('item-emoji')
            emojiElement.textContent = item.emoji
            const textNode = document.createTextNode(item.text)

            itemComponent.appendChild(emojiElement)
            itemComponent.appendChild(textNode)
            itemSidebar.appendChild(itemComponent)
        });

        // Adds an on click event listener to all "item" divs in Sidebar
        itemSidebar.addEventListener('mousedown', function (event) {
            if (event.target.classList.contains('item')) {
                // Copies the item and implements dragging functionality
                const itemInstance = event.target.cloneNode(true)
                itemInstance.classList.add('instance')
                itemInstances.appendChild(itemInstance)
                handleItemDrag(event, itemInstance)
            }
        })

        // Adds an on click event listener to all "item" divs in the canvas
        itemInstances.addEventListener('mousedown', function (event) {
            // Drags item
            if (event.target.classList.contains('item')) handleItemDrag(event, event.target)
        })
    })
</script>