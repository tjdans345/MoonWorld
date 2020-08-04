<%@page import="Board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>rewritePro.jsp</title>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//자바빈 파일 만들기 패키지 board 파일이름 BoardBean date TimeStamp형
//자바빈 객체 생성 액션태그 BoardBean bBean
//폼 => 자바빈 저장 액션태그
%>
<jsp:useBean id="bBean" class="Board.BoardBean" />
<jsp:setProperty property="*" name="bBean" />
<%
//setDate() setIp()
bBean.setDate(new Timestamp(System.currentTimeMillis()));
bBean.setIp(request.getRemoteAddr());
// 디비작업 파일 만들기 패키지 board 파일이름 boardDAO
// 객체 생성 BaordDAO bdao
BoardDAO bdao=new BoardDAO();
// (자식글 답변내용 + 부모글의 그룹번호, 들여쓰기번호, 위치번호)를 지니고 있는 bBean객체 넘기기
bdao.reInsertBoard(bBean);
//이동 list.jsp
response.sendRedirect("notice.jsp");
%>




</head>
<body>

</body>
</html>