import { validateId, validatePassword } from "../common/regex.js";

const idInput = document.getElementById("login-id");
const passwordInput = document.getElementById("login-password");

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

document
  .getElementById("login-form")
  .addEventListener("submit", function (event) {
    const idValidation = validateId(idInput.value);
    const passwordValidation = validatePassword(passwordInput.value);

    if (!idValidation.isValid || !passwordValidation.isValid) {
      event.preventDefault();
      alert("아이디 또는 비밀번호가 올바르지 않습니다.");
    } else {
      alert("로그인 성공!");
    }
  });

document
  .getElementById("find-id-button")
  .addEventListener("click", function () {
    window.location.href = "../find-id/find-id.html";
  });
document
  .getElementById("find-password-button")
  .addEventListener("click", function () {
    window.location.href = "../find-password/find-password.html";
  });

document.getElementById("signup-button").addEventListener("click", function () {
  window.location.href = "../signup/signup.html";
});
