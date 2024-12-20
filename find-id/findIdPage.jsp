<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link rel="stylesheet" href="find-styles.css">
    <link rel="stylesheet" href="../common/styles.css">
</head>
<body>
    <h1>아이디 찾기</h1>
    <div id="find-id-page">
        <form id="find-id-form" method="post" action="findIdAction.jsp">
            <div class="input-container">
                <label for="find-id-name">이름</label>
                <input type="text" id="find-id-name" name="find-id-name" placeholder="이름 입력">
                <span id="find-id-name-message"></span>

                <label for="find-id-email">이메일</label>
                <input type="text" id="find-id-email" name="find-id-email" placeholder="이메일 입력">
                <span id="find-id-email-message"></span>
            </div>
            <div class="button-container">
                <button type="submit">아이디 찾기</button>
            </div>
        </form>
    </div>
    <script type="module" src="find-id.js"></script>
</body>
</html>
