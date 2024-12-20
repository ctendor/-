<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 - Stageus App</title>
    <link rel="stylesheet" href="signup.css">
    <link rel="stylesheet" href="../common/root.css">
</head>
<body>
    <h1>회원가입</h1>
    <div id="signup-page">
        <form id="signup-form" action="signupAction.jsp" method="post">
            <div class="input-container">
                <label for="signup-id">아이디</label>
                <input type="text" id="signup-id" name="id" placeholder="아이디 입력" required />
                <span id="signup-id-message"></span>
            </div>

            <div class="input-container">
                <label for="signup-password">비밀번호</label>
                <input type="password" id="signup-password" name="password" placeholder="비밀번호 입력" required />
                <span id="signup-password-message"></span>
            </div>
 
            <div class="input-container">
                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" name="confirm_password" placeholder="비밀번호 확인" required />
                <span id="confirm-password-message"></span>
            </div>

            <div class="input-container">
                <label for="signup-email">이메일</label>
                <input type="email" id="signup-email" name="email" placeholder="이메일 입력" required />
                <span id="signup-email-message"></span>
            </div>

            <div class="input-container">
                <label for="signup-name">이름</label>
                <input type="text" id="signup-name" name="name" placeholder="이름 입력" required />
                <span id="signup-name-message"></span>
            </div>

            <div class="radio-container">
                <label>부서</label>
                <div class="radio-group">
                    <input type="radio" id="department-management" name="department" value="경영" checked />경영
                    <input type="radio" id="department-design" name="department" value="디자인" />디자인
                </div>
            </div>

            <div class="radio-container">
                <label>직급</label>
                <div class="radio-group">
                    <input type="radio" id="position-leader" name="position" value="팀장" checked />팀장
                    <input type="radio" id="position-member" name="position" value="팀원" />팀원
                </div>
                <span id="signup-position-message"></span>
            </div>

            <div class="button-container">
                <button type="submit">회원가입</button>
            </div>
        </form>
    </div>
    <script type="module" src="signup.js"></script>
</body>
</html>
