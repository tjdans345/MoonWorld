<%@page import="Notice.NoticeDAO"%>
<%@page import="Board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
request.setCharacterEncoding("utf-8");
NoticeDAO bDAO = new NoticeDAO();
//세션영역에 저장된 ID정보 가져오기
String id = (String)session.getAttribute("id");
//content.jsp에서 삭제할 직원 번호 받아오기
int num = Integer.parseInt(request.getParameter("num"));
//content.jsp에서 삭제할 직원 ID 받아오기
String name = request.getParameter("name");
%>

<%
if (id.equals(name)) {

	//DB삭제작업
	int check = bDAO.delContent(num);
	
	if (check == 1) {
%>
	<script>
	alert("글이 삭제되었습니다.")
	location.href="information.jsp"
	</script>
		
<%		
	} else {
%>		
	<script>
	alert("글 삭제에 실패하였습니다.")
	</script>
<%		
	}
%>	
<% 	
} else {
%>
	<script>
	alert("본인이 쓴 글이 아닙니다.")
	location.href="information.jsp"
	</script>
<% 	
}
%>

	
	
	

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>