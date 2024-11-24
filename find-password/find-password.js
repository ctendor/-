import { validateId, validateEmail } from "../common/regex.js";

const idInput = document.getElementById("find-password-id");
const nameInput = document.getElementById("find-password-name");
const emailInput = document.getElementById("find-password-email");
const idMessage = document.getElementById("find-password-id-message");
const nameMessage = document.getElementById("find-password-name-message");
const emailMessage = document.getElementById("find-password-email-message");

function updateMessage(element, message) {
  element.textContent = message;
}

idInput.addEventListener("change", function () {
  const validation = validateId(idInput.value);
  updateMessage(idMessage, validation.isValid ? "" : validation.message);
});

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
  .getElementById("find-password-form")
  .addEventListener("submit", function (event) {
    const idValidation = validateId(idInput.value);
    const nameValidation = {
      isValid: nameInput.value.trim().length > 0,
      message: "이름을 입력해주세요.",
    };
    const emailValidation = validateEmail(emailInput.value);

    if (
      !idValidation.isValid ||
      !nameValidation.isValid ||
      !emailValidation.isValid
    ) {
      event.preventDefault();
      alert("입력한 정보를 확인해주세요.");
    } else {
      alert("비밀번호 찾기 요청 성공!");
    }
  });
