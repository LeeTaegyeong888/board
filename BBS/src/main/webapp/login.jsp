<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class ="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class = "navbar-brand"  href="main.jsp">HeeJin No.4</a>
		</div>
		<div class="collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">홈화면</a>
				<li><a href="bbs.jsp">게시판</a>
				<li>
					<a href="http://sports.ibk.co.kr/m/volleyball/main/" target='_blank'>알토스 배구단 바로가기</a>
				</li>
				<li>
					<a href="https://www.instagram.com/geurujam_/" target='_blank'>김희진 인스타그램</a>
				</li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기 
					<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li class="active"><a href="login.jsp">로그인</a></li>
					<li><a href="join.jsp">회원가입</a></li>
				</ul>
			</ul>
		</div>
	</nav>	
	<div class="container">
		<div class = "row">
			<div class="col-lg-4" style="float: none; margin:0 auto;">
				<div class="jumbotron" style = "padding-top: 20px;">
					<form method="post" action="loginAction.jsp">
						<h3 style="text-align: center;">로그인 화면</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						</div>
						<input type="submit" class="btn btn-primary form-control" value="로그인">
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>