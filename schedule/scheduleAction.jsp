<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*"%>

<%
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("user_id") == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../login/loginPage.jsp';</script>");
        return;
    }

    int userId = (int) session.getAttribute("user_id");
    String position = (String) session.getAttribute("position");

    if (!"팀장".equals(position)) {
        out.println("<script>alert('팀장만 사용할 수 있는 기능입니다.'); history.back();</script>");
        return;
    }

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connectino conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/daily", "taek", "1234");
        
        // Temporary Table에 팀원 일정 추가
        String sql = "INSERT INTO temp_schedule_count (date, schedule_count) " +
                     "SELECT startDate, COUNT(*) FROM schedule " +
                     "WHERE user_id IN (SELECT idx FROM User WHERE dept = (SELECT dept FROM User WHERE idx = ?)) " +
                      "GROUP BY startDate " +
                     "ON DUPLICATE KEY UPDATE schedule_count = schedule_count + VALUES(schedule_count)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        pstmt.executeUpdate();

        out.println("<script>alert('팀원의 일정이 병합되었습니다.'); location.href='schedulePage.jsp';</script>");

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    }
%>
