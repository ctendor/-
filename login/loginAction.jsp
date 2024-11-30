<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/daily", "taek", "1234");
        System.out.println("Connection");
          if (conn != null && !conn.isClosed()) {
                out.println("데이터베이스 연결 성공!");
            } else {
                out.println("데이터베이스 연결 실패!");
            }
        String sql = "SELECT idx, name, dept FROM User WHERE id = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("user_id", rs.getInt("idx"));
            session.setAttribute("username", rs.getString("name"));
            session.setAttribute("dept", rs.getString("dept"));

            System.out.println("세션 user_id: " + session.getAttribute("user_id"));
            System.out.println("세션 username: " + session.getAttribute("username"));

            response.sendRedirect("../schedule/schedulePage.jsp");
        } else {
            out.println("<script>alert('아이디 또는 비밀번호가 잘못되었습니다.'); history.back();</script>");
        }
    }catch(SQLException e){
        e.printStackTrace();
        out.println("<script>alert('SQL 에러가 발생했습니다.'); history.back();</script>");
    }
    catch (Exception e) {
         e.printStackTrace();
        out.println("<p>Error: " + e.getMessage()+"</p>");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
