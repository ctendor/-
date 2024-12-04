<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scheduler Page</title>
    <link rel="stylesheet" href="schedule.css">
    <link rel="stylesheet" href="../common/root.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <div>접속자: <%= session.getAttribute("username") %> | 부서: <%= session.getAttribute("dept") %> | 직급: <%= session.getAttribute("position") %></div>
            <div class="logout-btn" onclick="location.href='../logout/logout.jsp'">로그아웃</div>
        </div>

        <div class="calendar-container">
            <div class="calendar-header">
                <button onclick="prevYear()">&#9664;</button>
                <span id="calendar-year"></span>년
                <button onclick="nextYear()">&#9654;</button>
            </div>

            <div class="month-pagination">
                <span onclick="selectMonth(1)">1월</span>
                <span onclick="selectMonth(2)">2월</span>
                <span onclick="selectMonth(3)">3월</span>
                <span onclick="selectMonth(4)">4월</span>
                <span onclick="selectMonth(5)">5월</span>
                <span onclick="selectMonth(6)">6월</span>
                <span onclick="selectMonth(7)">7월</span>
                <span onclick="selectMonth(8)">8월</span>
                <span onclick="selectMonth(9)">9월</span>
                <span onclick="selectMonth(10)">10월</span>
                <span onclick="selectMonth(11)">11월</span>
                <span onclick="selectMonth(12)">12월</span>
                </div>

            </div>

            <table class="calendar-table">
                <thead>
                    <tr>
                        <th>Sun</th>
                        <th>Mon</th>
                        <th>Tue</th>
                        <th>Wed</th>
                        <th>Thu</th>
                        <th>Fri</th>
                        <th>Sat</th>
                    </tr>
                </thead>
                <tbody id="calendar-body"></tbody>
            </table>
        </div>
    </div>
    <script src="schedule.js"></script>
</body>
</html>
