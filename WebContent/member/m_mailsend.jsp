<%@page import="Member.MemberBean"%>
<%@page import="Member.MemberDAO"%>
<%@page import="email.random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="../assets/css/main.css" />	

<title>Insert title here</title>
</head>

<%
random r = new random();

String content = r.randomNum();

session.setAttribute("content", content);

String id = request.getParameter("id");

MemberDAO mdao = new MemberDAO();

MemberBean mdto = mdao.getMember(id);

%>

<body>
	
	<form id="main-contact-form" name="contact-form" method="post" action="./../mailSend2" style="max-width:400px; margin:50px auto;">
	<br/><br/><br/>
	<div align="center">
	<a href="../index.jsp" calss="no"><h2>🌕</h2></a>
	<br/><br/><br/>
	
	<h3>회원님의 ID는 <span id="em-span"><%=id %></span> 입니다.</h3>
	
	<br/>
	
	비밀번호 찾기 
	<br>
	
	<div class="input-container">
	<span class="log-span">email</span> 
	<input type="email" class="input-field" name="receiver" value="<%=mdto.getEmail()%>">
	</div>
	<br>
	<input type="submit" class="special" style="height: 50px;" value="인증번호 받기">
	<input type="hidden" name="content" value="<%=content%>">
	<input type="hidden" name="name" value="<%=mdto.getName()%>">
	<input type="hidden" name="sender" class="form-control" placeholder="Email Address" required="required" value="wkdghk789@gmail.com">
	<input type="hidden" name="id" value="<%=id%>">
	</div>
      </form>
      


</body>
</html>