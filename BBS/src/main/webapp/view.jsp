<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="cmt.Cmt"%>
<%@ page import="cmt.CmtDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0"> 
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/> 
<link rel="stylesheet" type="text/css" href="css/custom.css"/> 
<title>BBS INDEX!</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		int bbsID = 0;
		int cmtID = 0;
		
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (request.getParameter("cmtID") != null) {
			cmtID = Integer.parseInt(request.getParameter("cmtID"));
		}
		
		if (bbsID == 0) {
			System.out.printf("\n ======================no!!!!!!!!!!! \n");
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('없는 글 입니다.');");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		System.out.printf("\n CMT ==> setBbsID  ::  " + bbsID + "\n");
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		Cmt cmt = new CmtDAO().getCmt(bbsID);
		CmtDAO cmtDAO = new CmtDAO();
		Cmt cmt2 = new Cmt();
	%>
	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class ="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class = "navbar-brand"  href="main.jsp">JSP 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a>
				<li class = "active"><a href="bbs.jsp">게시판</a> 
			</ul>
			<%
				if(userID == null) {		
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"
				 role="button" aria-haspopup="true" aria-expanded="false">접속하기 
					<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="join.jsp">회원가입</a></li>
				</ul>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"
				 role="button" aria-haspopup="true" aria-expanded="false">회원관리 
					<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a></li>
				</ul>
			</ul>
			
			<%
				}		
			%>
		</div>
	</nav>	
	<div class = "container">
		<div class = "row">
			<table class="table table-striped" style = "border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="text-align: center; width:20%;">글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td style="text-align: center;">작성자</td>
						<td colspan="2"><%=bbs.getUserID() %></td>
					</tr>
					<tr>
						<td style="text-align: center;">작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시 " + bbs.getBbsDate().substring(14, 16) + "분"%></td>
					</tr>
					<tr>
						<td colspan="2"  style="min-height:200px; text-align:left; height : 500px;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
					</tr>
				</tbody>
			</table>
			<form method="post" action="cmtAction.jsp?bbsID=<%= bbsID%>">
				<table class="table table-striped" style = "border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="4" style="background-color: #eeeeee; text-align: center;">댓글</th>
						</tr>
					</thead>
					<tbody>
					<%
						ArrayList<Cmt> list = cmtDAO.getList(bbsID);
						System.out.printf("\n LIST LENGTH? ::  " + list.size());
						for(int i = 0; i<list.size(); i++) {
							if (list.get(i).getBbsID() == bbs.getBbsID()) {
					%>
						<tr>
							<td style="text-align: center; width:5%;"><%= (i+1) %></td>
							<td style="text-align: center; width:55%;"><%= list.get(i).getCmtContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							<td style="text-align: center; width:20%;"><%= list.get(i).getUserID() %></td>
							<td style="text-align: center; width:20%;"><%= list.get(i).getCmtDate().substring(0, 11) + list.get(i).getCmtDate().substring(11, 13) + "시 " + list.get(i).getCmtDate().substring(14, 16) + "분"%></td>
						</tr>
					<%
							}
						}
					%>
						<tr>
							<td colspan="4"><textarea class="form-control" placeholder="댓글을 입력하세요" name="cmtContent"  maxlength="2048" style = "height : 200px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="댓글 쓰기">
			</form>
			<a href ="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if (userID != null && userID.equals(bbs.getUserID())) {
			%>
			
					<a href ="update.jsp?bbsID=<%= bbsID%>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('삭제하시겠습니까?')" href ="deleteAction.jsp?bbsID=<%= bbsID%>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			
			<% if (userID != null) { %>
			<a href="Write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<% } %>

			
		</div>
	</div>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>