import { validateEmail } from "../common/regex.js";

const nameInput = document.getElementById("find-id-name");
const emailInput = document.getElementById("find-id-email");
const nameMessage = document.getElementById("find-id-name-message");
const emailMessage = document.getElementById("find-id-email-message");

function updateMessage(element, message) {
  element.textContent = message;
}

nameInput.addEventListener("change", function () {
  const validation = {
    isValid: nameInput.value.trim().length > 0,
    message: "이름을 입력해주세요.",
  };
  updateMessage(nameMessage, validation.isValid ? "" : validation.message);
});

emailInput.addEventListener("change", function () {
  const validation = validateEmail(emailInput.value);
  updateMessage(emailMessage, validation.isValid ? "" : validation.message);
});

document
  .getElementById("find-id-form")
  .addEventListener("submit", function (event) {
    const nameValidation = {
      isValid: nameInput.value.trim().length > 0,
      message: "이름을 입력해주세요.",
    };
    const emailValidation = validateEmail(emailInput.value);

    if (!nameValidation.isValid || !emailValidation.isValid) {
      event.preventDefault();
      alert("입력한 정보를 확인해주세요.");
    } else {
      alert("아이디 찾기 요청 성공!");
    }
  });
