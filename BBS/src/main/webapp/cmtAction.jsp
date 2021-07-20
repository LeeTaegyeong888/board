<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cmt.CmtDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="cmt" class="cmt.Cmt" scope="page"/>
<jsp:setProperty name="cmt" property="cmtContent"/>
<jsp:setProperty name="cmt" property="userID"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BBS INDEX!</title>
</head>
<body>
	<%
		String userID = null;
		int bbsID = 0;
		
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			cmt.setUserID(userID); // bbs java 파일에 userID 전달
		}
		
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		System.out.printf("\n 2. CMT ==> bbsID ::  " + bbsID + " \n");
		
		if (userID == null) {
			System.out.printf("\n logout state ======================");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요');");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			System.out.printf("\n login session ======================");
			if (cmt.getCmtContent() == null || cmt.getCmtContent() == ""){
				System.out.printf("result NULL STRING! ");
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다. 확인해주십시오.');");
				script.println("history.back()");
				script.println("</script>");
			} else {
				CmtDAO cmtDAO = new CmtDAO();
				int result = cmtDAO.write(userID, cmt.getCmtContent(), bbsID);
				if (result == -1) {
					System.out.printf("result 1 ");
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.');");
					script.println("history.back()");
					script.println("</script>");
				} else {
					System.out.printf("result 2 cmt test");
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'view.jsp?bbsID=" + bbsID + "'");
					script.println("</script>");
				} 
			}
		}

		
		
		
	%>
</body>
</html>