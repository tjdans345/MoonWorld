<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Notice.NoticeBean"%>
<%@page import="java.util.List"%>
<%@page import="Notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<%
request.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("id");
%>
<!--
	Landed by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Right Sidebar - Landed by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	
<%

NoticeDAO nDAO = new NoticeDAO();
			
int count = nDAO.getBoardCount();

			//하나의 화면 마다 보여줄 글개수 15
			int pageSize = 5;
			
			//-----------------------------------
			String pageNum = request.getParameter("pageNum");
			//현재보여질(선택한) 페이지번호가 없으면 1페이지 처리
			if(pageNum == null) {
				pageNum = "1";
			}
			/* 현재 보여질(선택한) 페이지 번호 */
			//현재보여질(선택한) 페이지번호 "1"을 -> 기본정수 1로 변경
			int currentPage = Integer.parseInt(pageNum);
			//-----------------------------------------
			
			/* 각 페이지 마다 맨위에 첫번째로 보여질 시작 글번호 구하기 */
			//(현재 보여질 페이지번호 - 1) * 한페이지당 보여줄 글개수 15
			int startRow = (currentPage-1)*pageSize;

List<NoticeBean> list = null;

if(count > 0 ) {
	
	list = nDAO.getBoardList(startRow, pageSize);

}
	//날짜 포맷
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM,dd");
%>



	<body>
		<div id="page-wrapper">

			<!-- Header -->
			<jsp:include page="../inc/top.jsp" />

			<!-- Main -->
				<div id="main" class="wrapper style1">
					<div class="container">
						<header class="major">
							<a href = "../index.jsp"><h2><mark>New Moon 🌕</mark></h2></a>
							<p>#####</p>
						</header>
						<div class="row 150%">
							<div class="8u 12u$(medium)">

								<!-- Content -->
									<section id="content">
										<a href="#" class="image fit"><img src="images/pic06.jpg" alt="" /></a>
										<div class="row">
									<div class="6u 12u(xsmall)">

										<h4> Moon's News </h4>
									<form action="adminwrite.jsp" method= "post">
										<ul class="alt">
										
											<%
												if(count > 0) {
													for(int i=0; i<list.size(); i++) {
														NoticeBean nbean = list.get(i);
											%>
										<a href = "noticecontent.jsp?num=<%=nbean.getNum()%>&pageNum=<%=pageNum%>"><li><b><%=nbean.getSubject()%></b></li></a>
											<%
													}
												}
											
											%>
											<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
											<%
												String aid = "admin";
												if(aid.equals(id)) {
											%>
												<div align="right"><input type="submit" value="글쓰기" class="special" /></div>
													
											<%
												}
											
											%>
											
										</ul>
									</form>	
									
										<%
					if(count>0) {
						
						int pageCount = count/pageSize+(count%pageSize==0?0:1);
						int pageBlock= 5;
						int startPage=((currentPage/pageBlock) - (currentPage%pageBlock==0?1:0))*pageBlock+1;
						int endPage=startPage+pageBlock-1; 
						if(endPage > pageCount) {
							endPage = pageCount;
						}
						
						if (startPage > pageBlock) {
						%>
							<a href="notice.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a>	
						<%
						}
						
						for(int i=startPage; i<=endPage; i++){
						%>
							<a href="information.jsp?pageNum=<%=i%>">&nbsp;[<%=i%>]&nbsp;&nbsp;</a>
						<%
						}
						%>
						<%
						if(endPage < pageCount) {
						%>
							<a href="information.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a>
						<%	
						}
					}
					%>
									</div>
									
									</section>

									
							</div>
							<div class="4u$ 12u$(medium)">

								<!-- Sidebar -->
									<section id="sidebar">
										<section>
											<h3>이 달🌕의 이벤트 </h3>
											<p>Sed tristique purus vitae volutpat commodo suscipit amet sed nibh. Proin a ullamcorper sed blandit. Sed tristique purus vitae volutpat commodo suscipit ullamcorper commodo suscipit amet sed nibh. Proin a ullamcorper sed blandit..</p>
											<footer>
												
											</footer>
										</section>
										<hr />
										<section>
											<a href="#" class="image fit"><img src="images/pic07.jpg" alt="" /></a>
											
											<p>Sed tristique purus vitae volutpat commodo suscipit amet sed nibh. Proin a ullamcorper sed blandit. Sed tristique purus vitae volutpat commodo suscipit ullamcorper sed blandit lorem ipsum dolore.</p>
											<footer>
												
											</footer>
										</section>
									</section>

							</div>
						</div>
						
					
						
					</div>
				</div>

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />

	</body>
</html>