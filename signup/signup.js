import {
  validateId,
  validatePassword,
  validateEmail,
} from "../common/regex.js";

const idInput = document.getElementById("signup-id");
const passwordInput = document.getElementById("signup-password");
const confirmPasswordInput = document.getElementById("confirm-password");
const emailInput = document.getElementById("signup-email");

function createErrorMessage(inputElement, validationResult) {
  let errorMessage = inputElement.nextElementSibling;
  if (errorMessage && errorMessage.classList.contains("error-message")) {
    errorMessage.remove();
  }

  if (!validationResult.isValid) {
    const span = document.createElement("span");
    span.textContent = validationResult.message;
    span.classList.add("error-message");
    inputElement.parentNode.insertBefore(span, inputElement.nextSibling);
  }
}

idInput.addEventListener("change", function () {
  const validation = validateId(idInput.value);
  createErrorMessage(idInput, validation);
});

passwordInput.addEventListener("change", function () {
  const validation = validatePassword(passwordInput.value);
  createErrorMessage(passwordInput, validation);
});

confirmPasswordInput.addEventListener("change", function () {
  const validation = {
    isValid: passwordInput.value === confirmPasswordInput.value,
    message:
      passwordInput.value === confirmPasswordInput.value
        ? ""
        : "비밀번호가 일치하지 않습니다.",
  };
  createErrorMessage(confirmPasswordInput, validation);
});

emailInput.addEventListener("change", function () {
  const validation = validateEmail(emailInput.value);
  createErrorMessage(emailInput, validation);
});

document
  .getElementById("signup-form")
  .addEventListener("submit", function (event) {
    const idValidation = validateId(idInput.value);
    const passwordValidation = validatePassword(passwordInput.value);
    const emailValidation = validateEmail(emailInput.value);
    const confirmPasswordValidation = {
      isValid: passwordInput.value === confirmPasswordInput.value,
      message:
        passwordInput.value === confirmPasswordInput.value
          ? ""
          : "비밀번호가 일치하지 않습니다.",
    };

    if (
      !idValidation.isValid ||
      !passwordValidation.isValid ||
      !emailValidation.isValid ||
      !confirmPasswordValidation.isValid
    ) {
      event.preventDefault();
      alert("입력한 정보가 유효하지 않습니다. 다시 확인해주세요.");
    } else {
      alert("회원가입 성공!");
    }
  });
