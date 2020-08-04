<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	String content = request.getParameter("content");
 	String con_chk = request.getParameter("con_chk");
%>

</head>

<body>

<%
	if(content.equals("con_chk")){
 		
%>
	<script>
		alert("성공");
	</script>
<% 		
 	}else{
%> 
		<script>
		alert("실패");
	</script>	
 <%		
 	}
%>

</body>
</html>