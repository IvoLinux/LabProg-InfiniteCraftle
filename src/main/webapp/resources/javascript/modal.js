const modal = document.querySelector(".modal");
const overlay = document.querySelector(".overlay");
const openModalBtn = document.querySelector(".clear");
const closeModalBtn = document.querySelector(".btn-close");

const openModal = function () {
    overlay.classList.remove("hidden");
};

const closeModal = function () {
    overlay.classList.add("hidden");
};
closeModalBtn.addEventListener("click", closeModal);
openModalBtn.addEventListener("click", openModal);

document.addEventListener("keydown", function (e) {
    if (e.key === "Escape" && !modal.classList.contains("hidden")) closeModal();
});