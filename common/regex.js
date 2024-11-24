export function validateId(id) {
  const idRegex = /^[a-zA-Z0-9]{8,20}$/;
  if (idRegex.test(id)) {
    return {
      isValid: true,
    };
  } else {
    return {
      isValid: false,
      message: "아이디는 8~20자 영문/숫자로 입력하세요.",
    };
  }
}

export function validatePassword(password) {
  const pwRegex = /^(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,20}$/;
  if (pwRegex.test(password)) {
    return {
      isValid: true,
    };
  } else {
    return {
      isValid: false,
      message: "비밀번호는 8~20자, 영숫자와 특수문자를 포함해야 합니다.",
    };
  }
}

export function validateEmail(email) {
  const emailRegex = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$/;
  if (emailRegex.test(email)) {
    return {
      isValid: true,
    };
  } else {
    return {
      isValid: false,
      message: "올바른 이메일 주소를 입력하세요.",
    };
  }
}
