<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="Board.BoardDAO"%>
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
	/* 글수정페이지를 위한 글상세보기 */
		
		//세션값 가져오기
		String id = (String)session.getAttribute("id");
		//세션값이 없으면 login.jsp
		if(id==null) {
			response.sendRedirect("../member/login.jsp");
		}
		
		//content.jsp페이지에서 글수정버튼을 클릭해서 전달하여 넘어온 num,pageNum 한글처리
		request.setCharacterEncoding("utf-8");
		
		//content.jsp 페이지에서 글 수정버튼을 클릭해서 전달하여 넘어온 num,pageNum 한글처리
		int num = Integer.parseInt(request.getParameter("num"));
		int re_ref = Integer.parseInt(request.getParameter("re_ref"));
		int re_lev = Integer.parseInt(request.getParameter("re_lev"));
		int re_seq =Integer.parseInt(request.getParameter("re_seq"));
		
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
								<h4>게시판</h4>
							  <form action="rewritePro.jsp" method="post" name="fr">
							   <input type="hidden" name="num" value="<%=num%>">
							   <input type="hidden" name="re_ref" value="<%=re_ref%>"> 
							   <input type="hidden" name="re_lev" value="<%=re_lev%>"> 
							   <input type="hidden" name="re_seq" value="<%=re_seq%>"> 
							   
								<div class="table-wrapper">
								<input type="hidden" name="num" value="<%=num%>">
									<table class="alt" id="notice">
										<tr>
											<td>이름</td>
											<td><input type="text" name="name" value="<%=id%>" readonly></td>
										</tr>
										<tr>
											<td>비밀번호</td>
											<td><input type="password" name="passwd"></td>
										</tr>
										<tr>
											<td>제목</td>
											<td><input type="text" name="subject" value="[답글]"></td>
										</tr>
										<tr>
											<td>내용</td>
											<td><textarea name="content" rows="13" cols="40"></textarea></td>
										</tr>
									</table>
								</div>
							</section>
						

					 </div>
					<div class="12u$" align="center">
							<div id="content">
							<input type="submit" value="답글작성" class="special" />
							<input type="reset" value="다시작성" />
							<input type="button" value="목록보기" onclick = "location.href='notice.jsp'" />
							</div>
					</div>
					
					</form>
				  </div>

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />
	</body>
</html>