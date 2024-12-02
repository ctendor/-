<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="../common/root.css">
    <link rel="stylesheet" href="find-styles.css">

</head>
<body>
    <h1>비밀번호 찾기</h1>
    <form action="findPasswordAction.jsp" method="post">
        <div class="input-container">
            <label for="id">아이디</label>
            <input type="text" id="id" name="id" placeholder="아이디 입력">
        </div>
        <div class="input-container">
            <label for="name">이름</label>
            <input type="text" id="name" name="name" placeholder="이름 입력">
        </div>
        <div class="input-container">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="이메일 입력">
        </div>
        <button type="submit">비밀번호 찾기</button>
    </form>
</body>
</html>
 