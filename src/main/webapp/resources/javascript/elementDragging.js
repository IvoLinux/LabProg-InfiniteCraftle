const itemSidebar = document.querySelector('.items-inner')
const itemInstances = document.querySelector('.instances')
const input = document.querySelector('.sidebar-input');
let instanceIdTracker = 0;

function handleItemDrag(event, component) {
    // Adds selected class and saves initial cursor offset
    component.classList.add('instance-selected')
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
        // Determines which single element is being hovered
        let children = itemInstances.children
        for (let i = 0; i < children.length; i++) {
            const child = children[i]
            if (child.id === component.id) continue;
            if (doDivsOverlap(event.target, child)) {
                child.classList.add('instance-hover')
                for (let j = i + 1; j < children.length; j++) children[j].classList.remove('instance-hover')
                break;
            } else {
                child.classList.remove('instance-hover')
            }
        }
    }

    function stopElementDrag() {
        const matchedElement = document.querySelector('.instance-hover')
        if (matchedElement !== null) {
            instanceIdTracker++
            const newElement = createElement("🥵", matchedElement.innerText.slice(3) + ' ' + component.innerText.slice(3), true)
            newElement.id = 'instance-' + instanceIdTracker
            newElement.style.left = (parseFloat(matchedElement.style.left) + parseFloat(component.style.left)) / 2 + 'px'
            newElement.style.top = (parseFloat(matchedElement.style.top) + parseFloat(component.style.top)) / 2 + 'px'
            itemInstances.appendChild(newElement)
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

// Waits for DOM to fully load
document.addEventListener('DOMContentLoaded', function () {
    // Retrieves local storage
    let retrievedData0 = localStorage.getItem("test-data")
    let elements = JSON.parse(retrievedData0).elements
    // Creates a component for each element
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

    // Adds an on click event listener to all "item" divs in the canvas
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

function createElement(emoji, text, instance = false) {
    const newElement = document.createElement('div')
    if (instance) newElement.classList.add('instance')
    newElement.classList.add('item')
    const emojiElement = document.createElement('span')
    emojiElement.classList.add('item-emoji')
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
