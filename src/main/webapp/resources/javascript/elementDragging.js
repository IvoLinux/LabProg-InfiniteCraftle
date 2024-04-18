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
            const text = matchedElement.innerText.slice(3) + ' ' + component.innerText.slice(3)
            const emoji = "🥵"
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
