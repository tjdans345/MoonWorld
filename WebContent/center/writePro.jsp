
<%@page import="Board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>writePro.jsp</h1>
<%
//세션값 가져오는 이유 : 
//로그인 하지 않고 글쓰기 작업시 다시 로그인처리 하기 위해...
//login.jsp 페이지로 이동시킬 목적

//세션값 가져오기
String id = (String)session.getAttribute("id");
//세션값이 없으면 login.jsp로 이동! (로그인 하고 게시판에 글을써라!)
if(id==null) {
	response.sendRedirect("../member/login.jsp");
}
//write.jsp 페이지에서 글쓴내용 전달받아 한글처리
request.setCharacterEncoding("utf-8");

//자바빈 객체 생성 액션태그 BoardBean bBean
//폼 => 자바빈 저장 액션태그
%>

<jsp:useBean id="bBean" class="Board.BoardBean" />
<jsp:setProperty property="*" name="bBean" />

<%
//setDate() : 현재 글쓴 날자, 시간 BoardBean에 추가 저장
// setIp() : 글쓴이 ip주소 BoardBean에 추가 저장
bBean.setDate(new Timestamp(System.currentTimeMillis()));
bBean.setIp(request.getRemoteAddr());
%>

<%
//디비작업 파일 만들기 패키지 board 파일이름 BoardDAO
//객체 생성 BoardDAO bdao
BoardDAO bdao = new BoardDAO();

// insertBoard(bBean)게시판 추가 메소드 호출시..
//글의 정보를 가지고 있는 boardBean객체 전달 하여 DB작업함.
bdao.insertBoard(bBean); //insert

//이동 list.jsp
response.sendRedirect("notice.jsp");
%>

</body>
</html>