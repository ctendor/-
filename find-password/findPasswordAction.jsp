<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String email = request.getParameter("email");

    try {
       Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/daily", "taek", "1234");
        
        String sql = "SELECT password FROM User WHERE id = ? AND name = ? AND email = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, name);
        pstmt.setString(3, email);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            String password = rs.getString("password");
            out.println("<script>alert('비밀번호는 " + password + " 입니다.'); location.href='../login/loginPage.jsp';</script>");
        } else {
            out.println("<script>alert('해당 정보로 등록된 비밀번호가 없습니다.'); history.back();</script>");
        }
 
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    }
%>
