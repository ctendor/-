<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String name = request.getParameter("find-id-name");
    String email = request.getParameter("find-id-email");

    String emailRegex = "^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[a-zA-Z]{2,7})+$";
    if (name == null || name.trim().isEmpty()) {
        out.println("<script>alert('이름을 입력해주세요.'); history.back();</script>");
        return;
    }
    if (!email.matches(emailRegex)) {
        out.println("<script>alert('유효한 이메일 주소를 입력해주세요.'); history.back();</script>");
        return;
    }

    String userId = null;
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/daily", "taek", "1234");
        
        String sql = "SELECT id FROM User WHERE name = ? AND email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            userId = rs.getString("user_id");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error: " + e.getMessage()+"</p>");
        return;
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }

    if (userId != null) {
        out.println("<script>alert('아이디: " + userId + "'); location.href='loginPage.jsp';</script>");
    } else {
        out.println("<script>alert('등록된 사용자를 찾을 수 없습니다.'); history.back();</script>");
    }
%>
