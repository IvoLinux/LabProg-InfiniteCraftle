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
        onChange: (e) => {
            checkIfDateAvailable(e.detail)
        }
    })
});

// Implement date changing functionality here. Comm with back will be in this function too
function checkIfDateAvailable(text) {
    if (!JSON.parse(sessionStorage.getItem("listDates")).dates.includes(text)) {
        window.alert('Date unavailable')
    }
}