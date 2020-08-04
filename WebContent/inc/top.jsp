<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String id = (String)session.getAttribute("id");

if (id == null ) { //세션값이 없는 경우
%>	
	<header id="header">
	<h1 id="logo">
		<a href="<%=request.getContextPath()%>/index.jsp">Moon 0423 ☪️</a>
	</h1>
	<nav id="nav">
		<ul>
			
			<li><a href="<%=request.getContextPath()%>/member/login.jsp">Login</a></li>
			<li><a href="#">목록</a>
				<ul>
					<li><a href="#">게시판</a>
						<ul>
							<li><a href="<%=request.getContextPath()%>/center/notice.jsp">자유 게시판</a></li>
							<li><a href="<%=request.getContextPath()%>/centerimage/inotice.jsp">리뷰 게시판</a></li>
						</ul></li>
					<li><a
						href="<%=request.getContextPath()%>/homecontent/information.jsp">공지사항</a></li>
					<li><a
						href="<%=request.getContextPath()%>/order/product.jsp">메뉴판</a></a></li>
					
					
				</ul></li>
			<li><a href="<%=request.getContextPath()%>/member/join.jsp"
				class="button special">회원 가입</a></li>
				
		</ul>
	</nav>
</header>



<%	
} else { //세션값이 있는 경우 
%>

<header id="header">
	<h1 id="logo">
		<a href="<%=request.getContextPath()%>/index.jsp">Moon 0423 ☪️</a>
	</h1>
	<nav id="nav">
		<ul>
			[ <%=id %>님 환영합니다!⭐ ] &nbsp;
			<li><a href="<%=request.getContextPath()%>/member/mupdate.jsp">회원정보 수정</a></li>
			<li><a href="#">목록</a>
				<ul>
					<li><a href="#">게시판</a>
						<ul>
							<li><a href="<%=request.getContextPath()%>/center/notice.jsp">자유 게시판</a></li>
							<li><a href="<%=request.getContextPath()%>/centerimage/inotice.jsp">리뷰 게시판</a></li>
					</ul></li>
					<li><a
						href="<%=request.getContextPath()%>/homecontent/information.jsp">공지사항</a></li>
					<li><a
						href="<%=request.getContextPath()%>/order/product.jsp">메뉴판</a></li>
					
					
				</ul></li>
				
			<li><a href="<%=request.getContextPath()%>/member/logout.jsp"
				class="button special">로그아웃</a></li>	
		</ul>
	</nav>
</header>

<%
}
%>




