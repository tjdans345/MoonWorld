<%@page import="GalleryBoardBean.GalleryBoardDAO"%>
<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>iupdatePro.jsp</h1>
<%
//한글처리
request.setCharacterEncoding("utf-8");
//pageNum 파라미터 가져오기
String pageNum=request.getParameter("pageNum");
//액션태그 객체생성 BoardBean bBean
// 액션태그 폼 => 자바빈
%>
<jsp:useBean id="bBean" class="GalleryBoardBean.GalleryBoardBean" />
<jsp:setProperty property="*" name="bBean" />
<%
//디비객체생성 BoardDAO bdao
GalleryBoardDAO bdao = new GalleryBoardDAO(); 
//int check = 메서드호출 updateBoard(bBean)
int check=bdao.updateBoard(bBean);
//check == 1 "수정성공" notice.jsp
//check == 0 "비밀번호틀림" 뒤로이동
if(check==1) {
%>
	<script type="text/javascript">
		alert("수정성공");
		location.href="inotice.jsp?pageNum=<%=pageNum%>";
	</script>
<%
} else {
%>
	<script type="text/javascript">
		alert("비밀번호틀림");
		history.back();
	</script>
<%
}
%>
</body>
</html>