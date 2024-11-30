document.addEventListener("DOMContentLoaded", () => {
  const loginForm = document.getElementById("login-form");
  const idInput = document.getElementById("username");
  const passwordInput = document.getElementById("password");
  const idMessage = document.getElementById("username-message");
  const passwordMessage = document.getElementById("password-message");

  function updateMessage(element, message) {
    if (element) {
      element.textContent = message;
    }
  }

  if (idInput) {
    idInput.addEventListener("input", () => {
      const validation = {
        isValid: idInput.value.trim().length >= 8,
        message: "아이디는 최소 8자 이상이어야 합니다.",
      };
      updateMessage(idMessage, validation.isValid ? "" : validation.message);
    });
  } else {
    console.error("username 요소를 찾을 수 없습니다.");
  }

  if (passwordInput) {
    passwordInput.addEventListener("input", () => {
      const validation = {
        isValid: passwordInput.value.trim().length >= 8,
        message: "비밀번호는 최소 8자 이상이어야 합니다.",
      };
      updateMessage(
        passwordMessage,
        validation.isValid ? "" : validation.message
      );
    });
  } else {
    console.error("password 요소를 찾을 수 없습니다.");
  }

  if (loginForm) {
    loginForm.addEventListener("submit", (event) => {
      const idValidation = {
        isValid: idInput && idInput.value.trim().length >= 8,
        message: "아이디는 최소 8자 이상이어야 합니다.",
      };
      const passwordValidation = {
        isValid: passwordInput && passwordInput.value.trim().length >= 8,
        message: "비밀번호는 최소 8자 이상이어야 합니다.",
      };

      if (!idValidation.isValid || !passwordValidation.isValid) {
        event.preventDefault();
        alert("아이디와 비밀번호를 확인해주세요.");
      }
    });
  } else {
    console.error("login-form 요소를 찾을 수 없습니다.");
  }
});
