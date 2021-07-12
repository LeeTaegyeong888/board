<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
				<li class = "active"><a href="main.jsp">메인</a>
				<li><a href="bbs.jsp">게시판</a>
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
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>심심해서 부트스트랩으로 만들어본 웹사이트</p>
				<a class="btn btn-primary btn-pull" href="bbs.jsp" role="button">게시판 바로가기</a>
			</div>
		</div>
	</div>
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<div>
				<div data-target="#myCarousel" data-slide-to="0" class="active"></div>
				<div data-target="#myCarousel" data-slide-to="1" ></div>
				<div data-target="#myCarousel" data-slide-to="2" ></div>
			</div>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/8.jpg">
				</div>
				<div class="item">
					<img src="images/9.jpg">
				</div>
				<div class="item">
					<img src="images/10.jpg">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>