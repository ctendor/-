<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, javax.servlet.http.*, javax.servlet.*"%>

<%
    if (session == null || session.getAttribute("user_id") == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../login/loginPage.jsp';</script>");
        return;
    }

    String date = request.getParameter("date");
    if (date == null || date.isEmpty()) {
        out.println("<script>alert('날짜 정보가 없습니다.'); location.href='../schedule/schedulePage.jsp';</script>");
        return;
    }

    String username = (String) session.getAttribute("username");
    String department = (String) session.getAttribute("dept");
    String position = (String) session.getAttribute("position");

    List<Map<String, String>> schedules = new ArrayList<>();
    try {
        int userId = (int) session.getAttribute("user_id");
        if (userId == 0) {
            out.println("<script>alert('세션에 user_id 정보가 없습니다. 로그인을 다시 시도해주세요.'); location.href='../login/loginPage.jsp';</script>");
            return;
        }

        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/daily", "taek", "1234");

        String sql = "SELECT startTime, endTime, detail FROM schedule WHERE user_id = ? AND startDate = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        pstmt.setString(2, date);

        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, String> schedule = new HashMap<>();
            schedule.put("startTime", rs.getString("startTime"));
            schedule.put("endTime", rs.getString("endTime"));
            schedule.put("detail", rs.getString("detail"));
            schedules.add(schedule);
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('데이터를 불러오는 중 오류가 발생했습니다: " + e.getMessage() + "');</script>");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Daily Schedule</title>
    <link rel="stylesheet" href="daily.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <div>접속자: <%= username %> | 부서: <%= department %> | 직급: <%= position %></div>
            <button class="logout-btn" onclick="location.href='../logout/logout.jsp'">로그아웃</button>
        </div>
        <h2 id="date-title"><%= date %> 일정</h2>
        <div class="main">
            <div class="schedule-list">
                <h3>일정 목록</h3>
                <ul>
                    <%
                        if (schedules.isEmpty()) {
                            out.print("<li>일정이 없습니다.</li>");
                        } else {
                            for (Map<String, String> schedule : schedules) {
                                out.print("<li>" + schedule.get("startTime") + " ~ " + schedule.get("endTime") + " : " + schedule.get("detail") + "</li>");
                            }
                        }
                    %>
                </ul>
            </div>

            <div class="schedule-input">
                <h3>일정 추가</h3>
                <form action="dailyAction.jsp" method="post">
                    <input type="hidden" name="type" value="add">
                    <input type="hidden" name="date" value="<%= date %>">

                    <div>
                        <label for="start-time">일정 시작시간</label>
                        <input type="time" id="start-time" name="start_time" required />
                    </div>
                    <div>
                        <label for="end-time">일정 종료시간</label>
                        <input type="time" id="end-time" name="end_time" required />
                    </div>
                    <div>
                        <label for="details">일정 상세</label>
                        <input type="text" id="details" name="details" maxlength="200" placeholder="ex) 미팅, 점심식사" required />
                    </div>
                    <button type="submit">일정 추가</button>
                </form>
            </div>
        </div>

        <button onclick="location.href='../schedule/schedulePage.jsp'">돌아가기</button>
    </div>

    <script src="daily.js"></script>
</body>
</html>
