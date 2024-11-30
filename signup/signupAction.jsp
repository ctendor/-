<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");
    String email = request.getParameter("email");
    String name = request.getParameter("name");
    String department = request.getParameter("department");
    String position = request.getParameter("position");

    if (!password.equals(confirmPassword)) {
        return;
    }

    int departmentId = 0;
    int positionId = 0;

    if ("디자인".equals(department)) {
        departmentId = 1;
    } else if ("경영".equals(department)) {
        departmentId = 2;
    }

    if ("팀장".equals(position)) {
        positionId = 1;
    } else if ("팀원".equals(position)) {
        positionId = 2;
    }

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/daily", "taek", "1234");

        String sql = "INSERT INTO User (id, password, email, name, dept, position) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, password);
        pstmt.setString(3, email);
        pstmt.setString(4, name);
        pstmt.setInt(5, departmentId); 
        pstmt.setInt(6, positionId); 

        int result = pstmt.executeUpdate();
 
        if (result > 0) {
            out.println("<script>alert('회원가입에 성공하였습니다!'); location.href='../login/loginPage.jsp';</script>");
        } else {
            out.println("<script>alert('회원가입에 실패하였습니다.'); history.back();</script>");
        }

        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        String errorMessage = e.getMessage().replace("'", "\\'"); // 이스케이프 처리
        out.println("<script>alert('오류 발생: " + errorMessage + "'); history.back();</script>");
    }
%>
