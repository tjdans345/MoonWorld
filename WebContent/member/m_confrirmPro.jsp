<%@page import="Member.MemberDAO"%>
<%@page import="email.random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	MemberDAO mdao = new MemberDAO();
	
	int check = mdao.confirm(name, email);
	
	if(check==1){
		
		String id = mdao.getID(name, email);
%>
	<script>
		alert("회원임이 인증되었습니다.");
		
		location.href="m_mailsend.jsp?id=<%=id%>";

	</script>
	
	
 
	
<%		
	}else{
%>
	<script>
		alert("잘못입력하셨습니다.");
		location.href="m_confirm.jsp";
	</script>

<%		
	}
%>

 