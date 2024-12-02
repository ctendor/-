<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 페이지</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="../common/root.css">
</head>
<body>
    <h1>stageus</h1>
    <div id="login-page">
        <form id="login-form" action="loginAction.jsp" method="post">
            <div class="input-container">
                <div>
                    <label for="username">아이디</label>
                    <input type="text" id="username" name="username" placeholder="아이디 입력">
                    <span id="username-message"></span>
                </div>

                <div>
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호 입력">
                    <span id="password-message"></span>
                 </div>
            </div>
            <div>
                <button type="submit">로그인</button>
            </div>
            <div class="button-container">
                <button type="button" onclick="location.href='../find-id/findIdPage.jsp'">아이디 찾기</button>
                <button type="button" onclick="location.href='../find-password/findPasswordPage.jsp'">비밀번호 찾기</button>
                <button type="button" onclick="location.href='../signup/signupPage.jsp'">회원가입</button>
            </div> 
        </form>
    </div>
    <script type="module" src="login.js"></script>
</body>
</html>
