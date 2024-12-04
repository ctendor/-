<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session != null) {
        Session.Abandon(); 
    }

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/daily", "taek", "1234");

        Statement stmt = conn.createStatement();
        stmt.execute("DROP TEMPORARY TABLE IF EXISTS temp_schedule_count");
        stmt.close();
        conn.close();

        out.println("<script>alert('로그아웃 되었습니다.'); location.href='../login/loginPage.jsp';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    }
%>
