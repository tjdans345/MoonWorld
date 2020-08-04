<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Landed by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>No Sidebar - Landed by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	<body>
		<div id="page-wrapper">

			<!-- Header -->
				<jsp:include page="../inc/top.jsp" />

		<section id="main" class="wrapper">
			<div class="container">

				<header class="major special">
					<h2>To Moon...🌕</h2>
				</header>
				<form action="loginPro.jsp" style="max-width: 400px; margin: 50px auto;">

					<div class="input-container">
						<i class="fa fa-user icon"></i> <input class="input-field"
							type="text" placeholder="Username" name="id">
					</div>

					<div class="input-container">
						<i class="fa fa-key icon"></i> <input class="input-field"
							type="password" placeholder="Password" name="passwd">
					</div>
					<br>
					<div align="center">
					<div class="12u$">
					<ul class="actions">
						<li><input type="submit" value="로그인" class="special" /></li>
						<li><input type="reset" value="다시쓰기" class="btn-log"/></li>
						</ul>
						</div>
					</div>
					
				</form>
				<div align="center">
					Did you lose your ticket? &nbsp;<a href="m_confirm.jsp">ID/비밀번호 찾기</a>
				</div>
				<div align="center">
					Aren't you an astronaut yet? &nbsp; <a href="../member/join.jsp">회원가입 하러가기</a>
				</div>






			</div>
		</section>



	</div>
				</div>

			<!-- Footer -->
			<jsp:include page="../inc/bottom.jsp" />

	</body>
</html>