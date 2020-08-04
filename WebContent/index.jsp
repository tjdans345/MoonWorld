<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Notice.NoticeBean"%>
<%@page import="java.util.List"%>
<%@page import="Notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Landed by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/main.css" />
	
	</head>
	
	
	
	<body class="landing">
	
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
		<div id="page-wrapper">

			<!-- Header -->
				<jsp:include page="./inc/top.jsp" />
			<!-- Banner -->
				<section id="banner">
					<div class="content">
						<header>
							<h2>Moon's Pub ☪️</h2>
							<p>The day the moon fell into the river<br/>
								The time has come to us..<br />
							Our time will flow like forever..</p>
						</header>
						
						<% 
						String id = (String)session.getAttribute("id");
						if(id == null) {
						%>	
							<span class="image"><img src="images/01.jpg" alt="" /></span>
						<%	
						} else {
						
						%>	
							<span class="image"><img src="images/pic01.jpg" alt="" /></span>
							
					<%	
						}
				
						%> 
						
					</div>
					<a href="#one" class="goto-next scrolly">Next</a>
				</section>

			<!-- One -->
				<section id="one" class="spotlight style1 bottom">
					<span class="image fit main"><img src="images/Moon3.jpg" alt="" /></span>
					<div class="content">
						<div class="container">
							<div class="row">
								<div class="4u 12u$(medium)">
									<header>
										<a href="./homecontent/information.jsp"><h2>New Moon 🌕</h2></a>
										</header>
								</div>
								<div class="6u 12u(xsmall)">

										<h4>공지사항 📢</h4>                                
										<ul>
											<%
												if(count > 0) {
													for(int i=0; i<list.size(); i++) {
														NoticeBean nbean = list.get(i);
											%>
													<li><b> &nbsp;&nbsp;&nbsp;<%=nbean.getSubject()%></b></li>
											<%
													}
												}
											
											%>
										</ul>
								</div>
								
							</div>
						</div>
					</div>
					
					<a href="#two" class="goto-next scrolly">Next</a>
				</section>
				
				

			<!-- Two -->
				<section id="two" class="spotlight style2 right">
					<span class="image fit main"><img src="images/Moon2.jpg" alt="" /></span>
					<div class="content">
						<header>
							<h2>Moon's Planet</h2>
							<div class="row">
									<div class="6u 12u(xsmall)">

										<h4>Menu</h4>
										<ul>
											<li>Motown Menu</li>
											<li>Wait For Me Menu</li>
											<li>Light Me Up Menu</li>
										</ul>
							</div></div>
							
						</header>
						<p></p>
						<ul class="actions">
							<li><a href="./order/product.jsp" class="button">To the Moon's Planet</a></li>
						</ul>
					</div>
					<a href="#three" class="goto-next scrolly">Next</a>
				</section>

			<!-- Three -->
				<section id="three" class="spotlight style3 left">
					<span class="image fit main bottom"><img src="images/map2.PNG" alt="" /></span>
					<div class="content">
						<header>
							<h2>찾아 오시는 길</h2>
							<p>Accumsan integer ultricies aliquam vel massa sapien phasellus</p>
						</header>
						<p>Feugiat accumsan lorem eu ac lorem amet ac arcu phasellus tortor enim mi mi nisi praesent adipiscing. Integer mi sed nascetur cep aliquet augue varius tempus lobortis porttitor lorem et accumsan consequat adipiscing lorem.</p>
						<ul class="actions">
							<li><a href="https://map.naver.com/v5/directions/-/14149754.484538827,4483967.996722167,%EB%AC%B8%EC%8A%A4%ED%8E%8D,36631112,PLACE_POI/-/transit?c=14149521.5904683,4483967.9967222,16,0,0,0,dh" class="button">길 찾기</a></li>
						</ul>
					</div>
					<a href="#four" class="goto-next scrolly">Next</a>
				</section>

			<!-- Four -->
				<section id="four" class="wrapper style1 special fade-up">
					<div class="container">
						<header class="major">
							<h2>About Moon's Pub...</h2>
							<p>우린 마시러 갔을거야 문스 앨리펍</p>
						</header>
						<div class="box alt">
							<div class="row uniform">
								<section class="4u 6u(medium) 12u$(xsmall)">
									<span class="icon alt major fa-area-chart"></span>
									<h3>Passion</h3>
									<p></p>
								</section>
								<section class="4u 6u$(medium) 12u$(xsmall)">
									<span class="icon alt major fa-comment"></span>
									<h3>Comunication</h3>
									<p></p>
								</section>
								<section class="4u$ 6u(medium) 12u$(xsmall)">
									<span class="icon alt major fa-flask"></span>
									<h3>development</h3>
									<p></p>
								</section>
								<section class="4u 6u$(medium) 12u$(xsmall)">
									<span class="icon alt major fa-paper-plane"></span>
									<h3>Freedom</h3>
									<p></p>
								</section>
								<section class="4u 6u(medium) 12u$(xsmall)">
									<span class="icon alt major fa-file"></span>
									<h3>Eternal</h3>
									<p></p>
								</section>
								<section class="4u$ 6u$(medium) 12u$(xsmall)">
									<span class="icon alt major fa-lock"></span>
									<h3>carefree</h3>
									<p></p>
								</section>
							</div>
						</div>
						<footer class="major">
							
						</footer>
					</div>
				</section>

			<!-- Five -->
				<section id="five" class="wrapper style2 special fade">
					<div class="container">
						<header>
							
					</div>
				</section>

			<!-- Footer -->
			<jsp:include page="./inc/bottom.jsp" />

	</body>
</html>