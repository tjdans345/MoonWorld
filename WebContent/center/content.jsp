<%@page import="Comment.CommentBean"%>
<%@page import="Comment.CommentDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Board.BoardBean"%>
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
			
			
			location.href="delcontent.jsp?num=" + num +"&name=" + name;
		} 
	}
	<%-- 댓글삭제 한번 더  물어보는 함수 --%>
	function fnCoDel(conum, num, pageNum) {
		// 메시지 박스에 "예", "아니오" 중에서 선택 했을때  true 또는 false 반환
		var result = confirm("댓글을 정말로 삭제하시겠습니까?");
		
		//"예"이면 ? delSawon.jsp삭제 페이지로 이동 ! 이동시 삭제할 직원 번호 넘겨 줌.
		if(result == true) {
			
			location.href="codelcomment.jsp?conum="+conum+"&num="+num+"&pageNum="+pageNum;
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
		
			
		//notice.jsp페이지에서 글제목을 클릭해서 전달하여 넘엉온 num ,pageNum 가져오기
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		//BoardDAO 객체 생성 bdao
		BoardDAO dao = new BoardDAO();
		
		//조회수 1증가
		dao.updateReadCount(num);
		
		//상세내용을 볼 글에 대한 글번호를 넘겨서 DB로 부터 글정보(BoardBean객체) 가져오기
		BoardBean boardBean = dao.getBoard(num);
		
		int DBnum = boardBean.getNum();
		int DBReadcount = boardBean.getReadcount();
		String DBName = boardBean.getName();
		Timestamp DBDate = boardBean.getDate(); //작성일
		String DBsuject = boardBean.getSubject(); //글제목
		String DBContent = ""; //글내용
		//글내용이 존재 한다면 //내용 엔터 처리
		if(boardBean.getContent() != null) {
			DBContent = boardBean.getContent().replace("\r\n", "<br/>");
		}
		int DBRe_ref = boardBean.getRe_ref(); //답변
		int DBRe_lev = boardBean.getRe_lev();
		int DBRe_seq = boardBean.getRe_seq();
		
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
								
									if (id != null) { 
								%>
							<div id="content">
							<input type="button" value="글수정" class="special" onclick="location.href='update.jsp?pageNum=<%=pageNum%>&num=<%=DBnum%>'" />
							<input type="button" value="글삭제" onclick = "fnDel(<%=DBnum%>, '<%=DBName%>')" />
							<input type="button" value="답글쓰기" onclick = "location.href='reWrite.jsp?num=<%=DBnum%>&re_ref=<%=DBRe_ref%>&re_lev=<%=DBRe_lev%>&re_seq=<%=DBRe_seq%>'"/>
											
								<%
								}
									//순서1 추가 끝
								%>
								<input type="button" value="목록보기" onclick = "location.href='notice.jsp?pageNum=<%=pageNum%>'" />
							</div>
					</div>
					<br/>
				<%	
				if (id != null) { 	
				%>
				
					<div class="container">
					<form action="comment.jsp?num=<%=num%>&pageNum=<%=pageNum%>" method="post" name="cm">
					<input type="hidden" name="id" value="<%=id%>">
					<input type="hidden" name="pnumber" value="<%=DBnum%>">
						<table>
							<tr>
								<td>댓글 달기 <br/> [0 / 100 자]</td>
								<td><textarea name="content" cols="100" rows="7" required></textarea><br/></td>
								<td align="right"><input type="submit" value="글쓰기" class="special" ></td>
							</tr>
						</table>	
					</form>	
				
			<%
				} else {
			%>		
					<div class="container">
						<table>
							<tr>
								<td>댓글 달기 <br/> [0 / 100 자]</td>
								<td><textarea name="content" cols="100" rows="7" placeholder="로그인 후 이용해 주세요." required></textarea><br/></td>
								<td align="right"><input type="button" value="글쓰기" class="special" onclick = "login()" ></td>
							</tr>
						</table>	
			<%
				}
			%>
			
			<%-- 댓글 뿌리기 --%>
			<%
				
				CommentDAO cDAO = new CommentDAO();
			
			//게시판 글개수 가져오기 int count = 메서드 호출 getCount()
			int count= cDAO.getBoardCount(DBnum);
			
			int pageSize = 5;
				
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
			
			//게시판 글객체(BoardBean)를 저장하기 위한 용도
			List<CommentBean> list = null;
			
			//만약 게시판에 글이 있다면..
			if(count > 0 ) {
				
				//글목록 가져오기
				//getBoardList(각페이지 마다 맨위에 첫번쨰로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
				list = cDAO.getBoardList(startRow, pageSize, DBnum);
			}
			//날짜 포맷
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy,MM,dd");
			
			%>
			
			
					<%-- 댓글 뿌리기 --%>
							<section>
								<br/>
								<div class="table-wrapper">
									<table>
										<h5>[ 댓글 &nbsp; &nbsp;<%=count%> ]</h5>
									<%
										if(count > 0 ) {
											for(int i = 0; i<list.size(); i++) {
												CommentBean bean = list.get(i);
									%>			
										<tr>
											<th><%=bean.getId()%> &nbsp;&nbsp;|&nbsp; <%=bean.getDate()%>&nbsp;&nbsp;&nbsp;<br/><br/><%=bean.getContent()%></th>
											<%
											for(int j=0; j<=10; j++) {
											%>	
											  <td>&nbsp;&nbsp;&nbsp; </td>
											<% 
											}
											%>
											<td>&nbsp;&nbsp;&nbsp; </td>
											<td><a href="#">좋아</a></td>
											<%
											if(bean.getId().equals(id)) {
											%>
												<td><a href="#" onclick="fnCoDel(<%=bean.getNum()%>, <%=num%> ,<%=pageNum%>)">삭제</a></td>
											<%
											} else {
											%>
												<td>&nbsp;&nbsp;&nbsp;</td>
											<%	
											}
											%>
											
										</tr>		
										
									<%			
										}
									  }
									%>
									</table>
					<div align="center">		
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
							<a href="content.jsp?num=<%=num%>&pageNum=<%=startPage-pageBlock%>">[이전]</a>	
						<%
						}
						
						for(int i=startPage; i<=endPage; i++){
						%>
							<a href="content.jsp?num=<%=num%>&pageNum=<%=i%>">&nbsp;[<%=i%>]&nbsp;&nbsp;</a>
						<%
						}
						%>
						<%
						if(endPage < pageCount) {
						%>
							<a href="contet.jsp?num=<%=num%>&pageNum=<%=startPage+pageBlock%>">[다음]</a>
						<%	
						}
					}
					%>
					</div>
					</div>
					</section>
					</div>
					</div>
							
				</div>

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />
	</body>
</html>