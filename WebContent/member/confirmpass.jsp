<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="../css/login.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="./dssets/css/main.css" />
<title>Insert title here</title>
</head>

<%
String pass = request.getParameter("pass"); 
String content = (String)session.getAttribute("content");
%>

<body>

<h3 style="text-align: center; margin-top: 100px;"> 회원님의 비밀번호는
<span id="em-span"><%=pass %></span> 입니다</h3>
  <br><br>

<h5 style="text-align: center;"><a href="login.jsp" style="font-size: 15px; ">로그인 하러가기</a></h5>

</body>
</html>