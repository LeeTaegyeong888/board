<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
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
		if (user.checkJoinNull() == false){
			System.out.printf("result NULL STRING! ");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다. 확인해주십시오.');");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) {
				System.out.printf("result 1 ");
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('해당 아이디가 존재합니다. 아이디를 다시 체크해 주십시오.');");
				script.println("history.back()");
				script.println("</script>");
			} else {
				session.setAttribute("userID", user.getUserID());
				System.out.printf("result 2 ");
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			} 
		}
		
		
		
	%>
</body>
</html>