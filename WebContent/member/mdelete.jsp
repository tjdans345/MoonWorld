<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
String id = (String)session.getAttribute("id");

MemberDAO mdao = new MemberDAO();

mdao.deleteMember(id);

session.invalidate();
%>    

<script>
	alert("탈퇴 되었습니다.");
	
	location.href="../index.jsp"

</script>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>