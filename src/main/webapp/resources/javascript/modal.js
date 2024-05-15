const modal = document.querySelector(".modal");
const overlay = document.querySelector(".overlay");
const closeModalBtn = document.querySelector(".btn-close");

const openModal = function () {
    overlay.classList.remove("hidden");
};

const closeModal = function () {
    overlay.classList.add("hidden");
};
closeModalBtn.addEventListener("click", closeModal);

document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && !modal.classList.contains("hidden")) closeModal();
});