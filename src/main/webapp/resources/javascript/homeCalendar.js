// Initializes calendar
document.addEventListener('DOMContentLoaded', function () {
    const calendarContainer = document.getElementById("calendar-container")
    const elementText = document.createElement('div')
    elementText.classList.add('target-element-text')
    calendarContainer.appendChild(elementText)
    elementText.textContent = "This day's element: " + game.targetElement.name
    new datedreamer.calendarToggle({
        element: "#calendar",
        format: "YYYY-MM-DD",
        theme: "lite-purple",
        styles: `
                #date-input {
                    width: 80px;
                    background-size: 23px 23px;
                    height: 32px;
                    font-size: 14px;
                    text-align: center;
                    padding: 0 8px 0 8px;
                }`,
        onChange: async (e) => {
            await handleDateChange(e.detail)
        }
    })
});

// Implement date changing functionality here. Comm with back will be in this function too
async function handleDateChange(text) {
    if (!JSON.parse(sessionStorage.getItem("listDates")).includes(text)) {
        window.alert('Date unavailable');
        getDateInput().value = JSON.parse(sessionStorage.getItem("game")).date
    }
    else {
        const elementOfTheDayDiv = document.querySelector(".target-element-text")
        const userId = JSON.parse(sessionStorage.getItem("game")).user.id
        const newGame = (await getNewGameFromDate(userId, text)).game;
        if (newGame && newGame.elements) {
            itemInstances.innerHTML = ''
            itemSidebar.innerHTML = ''
            elementOfTheDayDiv.innerText = "This day's element: " + newGame.targetElement.name
            sessionStorage.setItem("game", JSON.stringify(newGame))
            newGame.elements.forEach(item => {
                itemSidebar.appendChild(createElement(item.emoji, item.name))
            });
        }
    }
}

function getDateInput() {
    const shadowHost = document.querySelector('datedreamer-calendar-toggle');
    return shadowHost ? shadowHost.shadowRoot.querySelector("#date-input") : null;
}

async function getNewGameFromDate(userId, date) {
    const url = `/api/change-date?userId=${userId}&date=${date}`;
    try {
        const response = await fetch(url, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (!response.ok) {
            throw new Error('Failed to get new game from change date endpoint');
        }
        return await response.json();
    } catch (error) {
        console.error('Error:', error);
        return null;
    }
}