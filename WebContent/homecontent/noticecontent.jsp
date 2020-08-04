<%@page import="Notice.NoticeBean"%>
<%@page import="Notice.NoticeDAO"%>
<%@page import="Comment.CommentBean"%>
<%@page import="Comment.CommentDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<script>
	function login() {
		alert("로그인 후 이용해주세요.")
		location.href="../member/login.jsp";
	}

</script>


<%
request.setCharacterEncoding("UTF-8");

%>
<!--
	Landed by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
	
	<script type="text/javascript">
	
	<%-- 직원데이터 삭제 한번 더 물어보는 함수 --%>
	function fnDel(num, name) {
		// 메시지 박스에 "예", "아니오" 중에서 선택 했을때  true 또는 false 반환
		var result = confirm("데이터를 정말로 삭제하시겠습니까?");
		
		//"예"이면 ? delSawon.jsp삭제 페이지로 이동 ! 이동시 삭제할 직원 번호 넘겨 줌.
		if(result == true) {
			
			
			location.href="delete.jsp?num=" + num +"&name=" + name;
		} 
	}
	
	
	
	</script>
		<title>No Sidebar - Landed by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	
	<%
		/* 글상세보기 페이지 */
		
		//notice.jsp페이지에서 글제목을 클릭해서 전달하여 넘어온 num,pageNum 한글처리
		
			
		//information.jsp페이지에서 글제목을 클릭해서 전달하여 넘엉온 num ,pageNum 가져오기
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		//BoardDAO 객체 생성 bdao
		NoticeDAO dao = new NoticeDAO();
		
		//조회수 1증가
		dao.updateReadCount(num);
		
		//상세내용을 볼 글에 대한 글번호를 넘겨서 DB로 부터 글정보(BoardBean객체) 가져오기
		NoticeBean nBean = dao.getBoard(num);
		
		int DBnum = nBean.getNum();
		int DBReadcount = nBean.getReadcount();
		String DBName = nBean.getId();
		Timestamp DBDate = nBean.getDate(); //작성일
		String DBsuject = nBean.getSubject(); //글제목
		String DBContent = ""; //글내용
		//글내용이 존재 한다면 //내용 엔터 처리
		if(nBean.getContent() != null) {
			DBContent = nBean.getContent().replace("\r\n", "<br/>");
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
								<h4><%=DBName+"님의 글"%></h4>
								<div class="table-wrapper">
									<table class="alt">
										<tr>
											<td>글번호</td>
											<td><%=DBnum%></td>
											<td>조회수</td>
											<td><%=DBReadcount %></td>
										</tr>
										<tr>
											<td>작성자</td>
											<td><%=DBName%></td>
											<td>작성일</td>
											<td><%=DBDate%></td>
										</tr>
										<tr>
											<td>글제목</td>
											<td colspan="3"><%=DBsuject%></td>
										</tr>
										<tr>
											<td>글내용</td>
											<td colspan="3"><%=DBContent%>
											
											<%
											for(int i=0; i<=10; i++) {
											%>
												<br/>
											<%	
											}
											%>
											
											</td>
										</tr>
									</table>
								</div>
							</section>
						

					</div>
					<div class="12u$" align="center">
								<%
									//순서1. 추가--------------
									//각각 페이지에서.. 로그인후 이동해 올때... 세션 id 전닥 받기
									 String id = (String)session.getAttribute("id");
								
									 
								%>
								<%
												String aid = "admin";
												if(aid.equals(id)) {
											%>
							<div id="content">
							<input type="button" value="글수정" class="special" onclick="location.href='noticeupdate.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'" />
							<input type="button" value="글삭제" onclick = "fnDel(<%=DBnum%>, '<%=DBName%>')" />
											
								<%
								   }
									//순서1 추가 끝
								%>
								<input type="button" value="메인으로" onclick = "location.href='information.jsp?'" />
							</div>
					</div>
					<br/>
				
			
			
				
				
					</section>
					
					</div>
					
				</div>

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />
	</body>
</html>