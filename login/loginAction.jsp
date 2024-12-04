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

        if (conn != null && !conn.isClosed()) {
            System.out.println("데이터베이스 연결 성공!");
        } else {
            System.out.println("데이터베이스 연결 실패!");
        }

        String sql = "SELECT U.idx AS userId, U.name AS username, D.dept_name AS deptName, P.position_name AS positionName " +
                     "FROM User U " +
                     "JOIN department D ON U.dept = D.idx " +
                     "JOIN position P ON U.position = P.idx " +
                     "WHERE U.id = ? AND U.password = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            session.setAttribute("user_id", rs.getInt("userId"));
            session.setAttribute("username", rs.getString("username"));
            session.setAttribute("dept", rs.getString("deptName"));
            session.setAttribute("position", rs.getString("positionName"));

            System.out.println("세션 user_id: " + session.getAttribute("user_id"));
            System.out.println("세션 username: " + session.getAttribute("username"));
            System.out.println("세션 dept: " + session.getAttribute("dept"));
            System.out.println("세션 position: " + session.getAttribute("position"));

            response.sendRedirect("../schedule/schedulePage.jsp");
        } else {
            out.println("<script>alert('아이디 또는 비밀번호가 잘못되었습니다.'); history.back();</script>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("<script>alert('SQL 에러가 발생했습니다.'); history.back();</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('서버 오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
