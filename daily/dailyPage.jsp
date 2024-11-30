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
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web", "taek", "1234");

        String sql = "SELECT startTime, endTime, detail FROM schedule WHERE user_id = ? AND startDate = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, (int) session.getAttribute("user_id"));
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
    <h1><%= date %> 일정</h1>
    <div>
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
    <button onclick="location.href='../schedule/schedulePage.jsp'">돌아가기</button>
</body>
</html>
