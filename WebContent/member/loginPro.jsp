<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

MemberDAO memberdao = new MemberDAO();

int check = memberdao.userCheck(id, passwd);

//5.
/* 
	DB에 있는 아이디, 비밀번호와 입력한 일치할때

*/

if(check == 1 ) {
	//로그인 화면에서 입력한 아이디를 세션영역에 저장
	session.setAttribute("id", id);
	//index.jsp로 이동. 세션영역에 저장한값이네;
	response.sendRedirect("../index.jsp");
	
} else if (check == 0 ) { //check ==0 비밀번호 틀릴시 
%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>	
		
<%		
} else { //check == -1 아이디 없음, 그전페이지 (login.jsp)로 이동
%>    
	<script type="text/javascript">
		alert("아이디 없음");
		history.back();
	</script>

    
    
<%
}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>