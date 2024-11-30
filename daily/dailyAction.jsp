<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    String type = request.getParameter("type");
    int userId = (int) session.getAttribute("user_id");

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/daily", "taek", "1234");

        if ("add".equals(type)) {
            String date = request.getParameter("date");
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");
            String details = request.getParameter("details");

            String sql = "INSERT INTO schedule (user_id, startDate, startTime, endDate, endTime, detail) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, date);
            pstmt.setString(3, startTime);
            pstmt.setString(4, date); // 동일한 날짜로 가정
            pstmt.setString(5, endTime);
            pstmt.setString(6, details);

            int result = pstmt.executeUpdate();
            if (result > 0) {
                out.println("<script>alert('일정이 추가되었습니다.'); location.href='dailyPage.jsp?date=" + date + "';</script>");
            } else {
                out.println("<script>alert('일정 추가에 실패했습니다.'); history.back();</script>");
            }
            pstmt.close();

        } else if ("delete".equals(type)) {
            int idx = Integer.parseInt(request.getParameter("idx"));
            String sql = "DELETE FROM schedule WHERE idx = ? AND user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idx);
            pstmt.setInt(2, userId);

            int result = pstmt.executeUpdate();
            if (result > 0) {
                out.println("<script>alert('일정이 삭제되었습니다.'); location.href='dailyPage.jsp';</script>");
            } else {
                out.println("<script>alert('일정 삭제에 실패했습니다.'); history.back();</script>");
            }
            pstmt.close();

        } else if ("edit".equals(type)) {
            int idx = Integer.parseInt(request.getParameter("idx"));
            String startTime = request.getParameter("start_time");
            String endTime = request.getParameter("end_time");
            String details = request.getParameter("details");

            String sql = "UPDATE schedule SET startTime = ?, endTime = ?, detail = ? WHERE idx = ? AND user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, startTime);
            pstmt.setString(2, endTime);
            pstmt.setString(3, details);
            pstmt.setInt(4, idx);
            pstmt.setInt(5, userId);

            int result = pstmt.executeUpdate();
            if (result > 0) {
                out.println("<script>alert('일정이 수정되었습니다.'); location.href='dailyPage.jsp';</script>");
            } else {
                out.println("<script>alert('일정 수정에 실패했습니다.'); history.back();</script>");
            }
            pstmt.close();
        } 

        conn.close(); 
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    }
%>
