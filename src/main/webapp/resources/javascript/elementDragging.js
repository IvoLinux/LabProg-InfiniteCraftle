const itemSidebar = document.querySelector('.items-inner')
const itemInstances = document.querySelector('.instances')
const input = document.querySelector('.sidebar-input');
let instanceIdTracker = 10;

// Waits for DOM to fully load
document.addEventListener('DOMContentLoaded', function () {
    // Retrieves local storage
        let retrievedData0 = sessionStorage.getItem("game")
        let elements = JSON.parse(retrievedData0).elements
        // Fills element sidebar
        elements.forEach(item => {
            itemSidebar.appendChild(createElement(item.emoji, item.name))
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
    const baseUrl = window.location.origin;
    const path = '/home';
    const url = `${baseUrl}${path}`;
    const data = {
        'type': 'craft',
        'parent1': component.innerText.replace(/^[^A-Za-z0-9]*/, ''),
        'parent2': matchedElement.innerText.replace(/^[^A-Za-z0-9]*/, '')
    };
    try {
        var json = JSON.stringify(data);
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                'Accept': 'application/json, text/plain, *//*',
                'Content-Type': 'application/json'
            },
            body: json
        });

        const responseData = await response.text();
        return JSON.parse(responseData);
        //console.log(responseData); // Aqui você pode fazer o que quiser com os dados retornados pelo servidor
    } catch (error) {
        console.error('Erro ao enviar os dados:', error);
    }
};

function handleItemDrag(event, component) {
    // Adds "selected" class, saves initial cursor offset, updates z-index to be the highest
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
        // Removes "hovering" class from all elements
        for (let i = 0; i < itemInstances.children.length; i++) itemInstances.children[i].classList.remove('instance-hover')
        // Adds "hovering" class to the single element with highest z-index and is overlapping
        if (getHighestZ(component) !== null) getHighestZ(component).classList.add('instance-hover')
    }

    async function stopElementDrag() {
        // matchedElement is the one selected by the user via dragging
        const matchedElement = document.querySelector('.instance-hover')
        if (matchedElement !== null) {
            console.log("alow");
            let text = ""
            let emoji = "";
            let craftedElement = null
            let newGame = {}
            instanceIdTracker++
            try {
                const obj = await sendRequest(component, matchedElement);
                console.log(obj);
                if (obj && obj.element && !obj.error && obj.crafted && obj.crafted === true) {
                    text = obj.element.name;
                    emoji = obj.element.emoji;
                    newGame = obj.game
                }
            } catch (error) {
                // Handle errors
                console.error('Erro na chamada assíncrona:', error);
            }
            // Handle recipe result
            if(text !== "" && emoji !== ""){
                const newElement = createElement(emoji, text, true)
                newElement.id = 'instance-' + instanceIdTracker
                newElement.style.zIndex = instanceIdTracker + ''
                newElement.style.left = (parseFloat(matchedElement.style.left) + parseFloat(component.style.left)) / 2 + 'px'
                newElement.style.top = (parseFloat(matchedElement.style.top) + parseFloat(component.style.top)) / 2 + 'px'
                itemInstances.appendChild(newElement)
                console.log("oi" + JSON.stringify(newGame))
                sessionStorage.setItem("game", JSON.stringify(newGame))
                // Checks if the resulting element is already in the element tray (also in session storage)
                let elementExists = false
                for (let i = 0; i < itemSidebar.children.length; i++) {
                    if (itemSidebar.children[i].innerText.replace(/^[^A-Za-z0-9]*/, '') === text) elementExists = true
                }
                if (!elementExists) {
                    // If the element was not in the tray, add it to the tray and the session
                    itemSidebar.appendChild(createElement(emoji, text))
                    document.querySelector('.sidebar-input').placeholder = 'Search (' + itemSidebar.children.length + ') items...';
                }
                matchedElement.remove()
            }
            component.remove()
        }
        // Removes event listeners since dragging is over
        document.removeEventListener('mouseup', stopElementDrag)
        document.removeEventListener('mousemove', updateComponentPosition)
        // Removes classes
        component.classList.remove('instance-selected')
        let children = itemInstances.children
        for (let i = 0; i < children.length; i++) children[i].classList.remove('instance-hover');
        // If element is dragged back onto the tray, it is removed
        if (doDivsOverlap(component, document.querySelector('.items'))) component.remove()
    }
}

function getHighestZ(selected) {
    // Returns the element in the canvas that is overlapping with the selected one and has highest z-index
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
    // Creates the element div
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
    // Returns true if divs overlap, false otherwise
    const rect1 = div1.getBoundingClientRect();
    const rect2 = div2.getBoundingClientRect();

    return !(rect1.right < rect2.left ||
        rect1.left > rect2.right ||
        rect1.bottom < rect2.top ||
        rect1.top > rect2.bottom);
}