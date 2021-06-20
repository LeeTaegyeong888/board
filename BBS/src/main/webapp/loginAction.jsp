<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBS INDEX!</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다');");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if (result == 1) {
			session.setAttribute("userID", user.getUserID());
			System.out.printf("result 1 ");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		} else if (result == 0 ){
			System.out.printf("result 2 ");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀렸습니다. 다시 시도해주세요');");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == 2) {
			System.out.printf("result 3 ");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB에 오류');");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -1) {
			System.out.printf("result 4 ");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디가 없습니다. 다시 확인하여주십시오');");
			script.println("history.back()");
			script.println("</script>");
		}
		
		
	%>
</body>
</html>