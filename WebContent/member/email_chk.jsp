<%@page import="Member.MemberBean"%>
<%@page import="Member.MemberDAO"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="../assets/css/main.css" />	

<%
	String content = (String)session.getAttribute("content");
	String id= request.getParameter("id");
	
	MemberDAO mdao = new MemberDAO();
	MemberBean mbean = mdao.getMember(id);
	
	String pass = mbean.getPasswd();

	
%>

<title>Insert title here</title>

<script type="text/javascript">
function check() {
	var code = document.fr.con_chk.value;
	var authNum = <%=content %>;
	
	if(!code) {
		alert("인증번호를 입력해주세요");
		return false;
	}
	
	if(authNum == code) {
		
		alert("인증 성공!");
		
	<%
		session.removeAttribute("content");
	%>
		document.fr.submit();
		
	} else {
		alert("인증번호가 틀립니다. 다시 입력해 주세요.");
		return false;
	}
}
</script>

</head>
<body>
	
	<br/><br/><br/><br/><br/><br/>
	<div align="center">
	<a href="../index.jsp" calss="no"><h2>🌕</h2></a>
	</div>
	<h3 style="text-align: center; margin-top: 100px;"> <span id="em-span"><%=id %></span>님 인증번호를 입력해주세요</h3>
	
	<form name="fr" method="post" action="confirmpass.jsp" style="max-width:400px; margin:50px auto;">

	
	<div class="input-container">
	<span class="log-span2">인증번호</span> 
	<input type="text" class="input-field" name="con_chk">
	<input type="hidden" name="pass" value="<%=pass%>"> 
	</div>
	<br>
	<input type="button" onclick="check(); return false;" style="height: 50px;" value="입력" class="special">
     </form>

</body>
</html>