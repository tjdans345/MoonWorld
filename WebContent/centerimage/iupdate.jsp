<%@page import="GalleryBoardBean.GalleryBoardBean"%>
<%@page import="GalleryBoardBean.GalleryBoardDAO"%>
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
		<title>iupdate</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	
	<%
		/* 글상세보기 페이지 */
		
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
		String pageNum = request.getParameter("pageNum");
		
		//BoardDAO 객체 생성 bdao
		GalleryBoardDAO dao = new GalleryBoardDAO();
		
		//상세내용을 볼 글에 대한 글번호를 넘겨서 DB로 부터 글정보(BoardBean객체) 가져오기
		GalleryBoardBean boardBean = dao.getBoard(num);
		
		int DBnum = boardBean.getNum();
		String DBId = boardBean.getId();
		String DBsuject = boardBean.getSubject(); //글제목
		String DBContent = ""; //글내용
		//글내용이 존재 한다면 //내용 엔터 처리
		if(boardBean.getContent() != null) {
			DBContent = boardBean.getContent().replace("\r\n", "<br/>");
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
								<h4>게시판</h4>
							  <form action="iupdatePro.jsp?pageNum=<%=pageNum%>" method="post" name="fr">
								<div class="table-wrapper">
								<input type="hidden" name="num" value="<%=num%>">
									<table class="alt" id="notice">
										<tr>
											<td>이름</td>
											<td><input type="text" name="id" value="<%=DBId%>" required></td>
										</tr>
										<tr>
											<td>비밀번호</td>
											<td><input type="password" name="passwd" required></td>
										</tr>
										<tr>
											<td>제목</td>
											<td><input type="text" name="subject" value="<%=DBsuject%>" required></td>
										</tr>
										<tr>
											<td>내용</td>
											<td><textarea name="content" rows="13" cols="40" required><%=DBContent%></textarea></td>
										</tr>
									</table>
								</div>
							</section>
						

					</div>
					<div class="12u$" align="center">
										<div id="content">
										<input type="submit" value="글수정" class="special" />
										<input type="reset" value="다시작성" />
										<input type="button" value="목록보기" onclick = "location.href='notice.jsp?pageNum=<%=pageNum%>'" />
										</div>
					</div>
					
						</form>
				</div>

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />
	</body>
</html>