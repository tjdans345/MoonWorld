<%@page import="GalleryBoardBean.GalleryBoardDAO"%>
<%@page import="GalleryBoardBean.GalleryBoardBean"%>
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
		<link rel="stylesheet" href="./assets/css/main.css" />
		
		
	</head>
	
	<%
	//한글처리
	request.setCharacterEncoding("utf-8");
	//search 가져오기
	String search="";
	if(request.getParameter("search") != null ) {
		search=request.getParameter("search");
	}
	
	//DB작업 객체 생성
	GalleryBoardDAO boardDAO = new GalleryBoardDAO();
	
	//게시판 글개수 가져오기 int count = 메서드 호출 getCount()
	int count= boardDAO.getBoardCount(search);
	
	//하나의 화면 마다 보여줄 글개수 10
	int pageSize = 9;
	
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
	
	//게시판 글객체(BoardBean)를 저장하기 위한 용도
	List<GalleryBoardBean> list = null;
	
	//만약 게시판에 글이 있다면..
	if(count > 0 ) {
		
		//글목록 가져오기
		//getBoardList(각페이지 마다 맨위에 첫번쨰로 보여질 시작 글번호, 한페이지당 보여줄 글개수)
		list = boardDAO.getBoardList(startRow,pageSize,search);
	}
	//날짜 포맷
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy,MM,dd");
	
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
								<h4>🌙 리뷰 게시판  [ 총 게시물 수 : <%=count %> ]</h4>
								<div >
									<table >
										
										<tbody>
										
											<%
											//만약 게시판 글개수가 존재하고 (게시판에 글이 있다면)
											for(int i =0; i<list.size(); i++) {
												GalleryBoardBean bean = list.get(i);
											
											%>
													<td class="center">
													
													<%	
														if(bean.getFilename()!=null && bean.getFilename()!="") {
													%>
													<div align="center"><a href = "icontent.jsp?num=<%=bean.getNum()%>&pageNum=<%=pageNum%>"><img src="../image/<%=bean.getFilerealname()%>" width="200px" height="200px"></a></div>
													<%
														} //file 유무  if문 끝
													%>
													
													</td>
													
												<%
													if(i==2 || i==5 ||i==8) {
												%>
														<tr></tr>
												<%
														
														
														for(int j=2; j>=0; j--) {  
 															bean = list.get(i-j);
												%>
														<th><%=bean.getSubject()%></th>
												<%			
															if(j==0 ) {
												%>
														<tr></tr>
												<% 				
												}
														   }
													
														}  //if문 끝 
												} for(int  i=0; i<list.size()%3;i++){
													GalleryBoardBean Bean = list.get(list.size()-(list.size()%3)+i);
											        if(i==0){%>
											    <tr>
											<%}%>
											 <th><%=Bean.getSubject()%></th>
										<%if(i==list.size()-1){%>
													</tr>
											<%}}%>
											
												
										</tbody>
								<tfoot>
									<tr>	
								</tr>
							</tfoot>
									</table>
								</div>
							</section>
					</div>
					<div class="12u$" align="center">
								<%
									//순서1. 추가--------------
									//각각 페이지에서.. 로그인후 이동해 올때... 세션 id 전달 받기
									 String id = (String)session.getAttribute("id");
									if (id != null) { 
								%>
										<div id="table_search">
										<input type="button" value="글쓰기" class="special" onclick="location.href='iWrite.jsp'" />
										</div> <br/>
								<%
								}
									//순서1 추가 끝
								%>
								<div id="table_search">
								<form action="inotice.jsp" method="post">
									<input type="text" name="search" />
									<input type="submit" value="search" class="btn" >
								</form>
									</div>
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
							<a href="inotice.jsp?pageNum=<%=startPage-pageBlock%>&search<%=search%>">[이전]</a>	
						<%
						}
						
						for(int i=startPage; i<=endPage; i++){
						%>
							<a href="inotice.jsp?pageNum=<%=i%>&search=<%=search%>">&nbsp;[<%=i%>]&nbsp;&nbsp;</a>
						<%
						}
						%>
						<%
						if(endPage < pageCount) {
						%>
							<a href="inotice.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">[다음]</a>
						<%	
						}
					}
					%>
					</div>
				</div>

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />
	</body>
</html>