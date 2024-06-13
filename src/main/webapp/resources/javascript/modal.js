const modal = document.querySelector(".modal");
const overlay = document.querySelector(".overlay");
const closeModalBtn = document.querySelector(".btn-close");
const scoreText = document.getElementById("modal-score-text")
const elementText = document.getElementById("modal-element-text")

const openModal = function () {
    const gameInstance = JSON.parse(sessionStorage.getItem("game"))
    overlay.classList.remove("hidden");
    elementText.innerText = "Elemento do dia: " + gameInstance.targetElement.name
    scoreText.innerText = "Pontuação atingida: " + gameInstance.score
};

const closeModal = function () {
    overlay.classList.add("hidden");
};
closeModalBtn.addEventListener("click", closeModal);

document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && !modal.classList.contains("hidden")) closeModal();
});