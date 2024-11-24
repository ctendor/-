<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Stageus App</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>

  <div id="signup-page" style="display: none;">
    <h1>회원가입</h1>
    <form id="signup-form">
      <div>
        <label for="signup-id">아이디</label>
        <input type="text" id="signup-id" placeholder="아이디 (8~20자)" required>
      </div>
      <div>
        <label for="signup-password">비밀번호</label>
        <input type="password" id="signup-password" placeholder="비밀번호 (8~20자)" required>
      </div>
      <div>
        <label for="confirm-password">비밀번호 확인</label>
        <input type="password" id="confirm-password" placeholder="비밀번호 재입력" required>
      </div>
      <div>
        <label for="email">이메일</label>
        <input type="email" id="email" placeholder="이메일 입력" required>
      </div>
      <div>
        <label for="name">이름</label>
        <input type="text" id="name" placeholder="이름 입력" required>
      </div>
      <button type="submit">회원가입</button>
    </form>
  </div>

  

  <script src="scripts.js"></script>
</body>
</html>
