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
<% 
	//추가1.
	//세션값 가져오기 
	//세션값을 가져오는 이유 : 글쓰기 화면에 이름을 뿌려주기 위한 용도
		String id = (String) session.getAttribute("id");

	//세션값이 없으면 login.jsp
	if (id == null) {
		response.sendRedirect("../member/login.jsp");
	}
	
%>	
	<body>
		<div id="page-wrapper">
	
			<!-- Header -->
			<jsp:include page="../inc/top.jsp" />
		
			<!-- Main -->
				<div id="main" class="wrapper style1">
					<div class="container">
					<header class="major"></header>
					<!-- Table -->
							<section>
								<div align="center"><h4>글쓰기</h4></div>
								<div class="table-wrapper">
								 <form action="writePro.jsp" method= "post" name = "br">
								  <table class="alt">
										<tbody>
											<tr>
												<td>이름</td>
												<td><input type="text" name="name" value="<%=id%>" readonly required></td>
											</tr>
											<tr>
												<td>비밀번호</td> 
												<td><input type="password" name="passwd" required></td>	
											</tr>
											<tr>
												<td>제목</td>
												<td><input type="text" name="subject" required></td>	
											</tr>
											<tr>
												<td>내용</td>
												<td><textarea name="content" cols="40" rows="13" required></textarea> </td>	
											</tr>
										</tbody>
									</table>
									<ul class="actions">
									   <div align="right">
												<li><input type="submit" value="글쓰기" class="special" /></li>
												<li><input type="reset" value="다시쓰기" onclick = "document.br.name.focus();"/></li>
												<li><input type="button" value="글목록" onclick="location.href='notice.jsp'"/></li>
									   </div>	
									</ul>
								</form>
								</div>
							</section>
					</div>
					<div class="12u$" align="center">
								
					</div>
					
					
				</div>

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />
	</body>
</html>