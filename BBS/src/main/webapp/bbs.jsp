<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0"> 
<link rel="stylesheet" type="text/css" href="css/bootstrap.css"/> 
<link rel="stylesheet" type="text/css" href="css/custom.css"/> 
<title>BBS INDEX!</title>
<style type="text/css">
	a, a:hover {
		color: black;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; //초기값
		int pageTotalNum = 0;
		BbsDAO bbsDAO = new BbsDAO();
		pageTotalNum = bbsDAO.pageTotalNumber();
		
		if (request.getParameter("pageNumber") != null)  { 
			pageNumber = Integer.parseInt(request.getParameter("pageNumber")); // 현재 ArrayList 순서
		}
		System.out.printf("\n ********************************* totalNumber :: " + pageTotalNum);
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
			<table class="table table-striped table-hover" style = "text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(int i = 0; i<list.size(); i++) {
				%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시 " + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<div class="text-center">
				<ul class="pagination justify-content-center">
				<%
					if (pageNumber != 1) {
				%>
					<li class="page-item">
						<a href ="bbs.jsp?pageNumber=<%=pageNumber -1 %>" class="page-link"> 이전</a>
					</li>
				<%
					} else {
				%>	
					<li class="page-item disabled">
						<a aria-disabled="true" href ="#" class="page-link"> 이전</a>
					</li>
				<%
					}
				%>
				<% 
					for (int i = 0 ; i < pageTotalNum; i++) {
						int count = i+1;
						if (pageNumber == count) {
	 			%>
		 			<li class="page-item active" aria-current="page">
		 				<a href ="bbs.jsp?pageNumber=<%=count%>"class="page-link"><%=count%></a>
		 			</li>
	 			<%
						} else {
	 			%>				
	 				<li class="page-item">
	 					<a href ="bbs.jsp?pageNumber=<%=count%>"class="page-link"><%=count%></a>
	 				</li>	
	 			<%
						}
					}
	 			%>
	 			<%
					if (bbsDAO.nextPage(pageNumber + 1)) {
				%>
					<li class="page-item">
						<a href ="bbs.jsp?pageNumber=<%=pageNumber + 1 %>" class="page-link"> 다음</a>
					</li>
				<%
					} else {
				%>	
					<li class="page-item disabled">
						<a aria-disabled="true" href ="#" class="page-link"> 다음</a>
					</li>
				<%
					}
				%>						
				</ul>
			</div>
			<a href="Write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>