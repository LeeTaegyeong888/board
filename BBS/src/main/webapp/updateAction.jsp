<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
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
		
		if (userID == null) {
			System.out.printf("\n login session ======================no!!!!!!!!!!! ");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 하세요');");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if (bbsID == 0) {
			System.out.printf("\n login session ======================no!!!!!!!!!!! ");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('없는 글 입니다.');");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.');");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		} else {
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null 
					|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")){
				System.out.printf("result NULL STRING! ");
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다. 확인해주십시오.');");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				if (result == -1) {
					System.out.printf("result 1 ");
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.');");
					script.println("history.back()");
					script.println("</script>");
				} else {
					System.out.printf("result 2 ");
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				} 
			}
		}

		
		
		
	%>
</body>
</html>