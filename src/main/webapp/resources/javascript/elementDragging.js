const itemSidebar = document.querySelector('.items-inner')
const itemInstances = document.querySelector('.instances')
let instanceIdTracker = 0;

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
        if (doDivsOverlap(component, document.querySelector('.items'))) component.remove()
    }

    document.addEventListener('mouseup', stopElementDrag)
    document.addEventListener('mousemove', updateComponentPosition)
    updateComponentPosition(event)
}

function doDivsOverlap(div1, div2) {
    const rect1 = div1.getBoundingClientRect();
    const rect2 = div2.getBoundingClientRect();

    return !(rect1.right < rect2.left ||
        rect1.left > rect2.right ||
        rect1.bottom < rect2.top ||
        rect1.top > rect2.bottom);
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