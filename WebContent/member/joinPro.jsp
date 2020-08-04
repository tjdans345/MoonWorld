<%@page import="Member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
    
<jsp:useBean id="memberbean" class="Member.MemberBean" />    

<jsp:setProperty property="*" name="memberbean"/>
 
   
<%

//reg_date 호출 후 현재회원가입한 날짜를 자바빈 memberbean 객체에 넣는다.

memberbean.setReg_date(new Timestamp(System.currentTimeMillis()));

MemberDAO memberdao = new MemberDAO();

int result = memberdao.insertMember(memberbean);

// 내가 추가한 부분 회원정보 성공 여부 알려주고 페이지 지정
if(result == 0) {
%>
	
	<script type="text/javascript">
		alert("회원정보 추가에 실패하였습니다. 다시 시도해주십시오.");
		history.back();
	</script>	
<%
} else {
%>
<script type="text/javascript">
		alert("회원정보 추가에 성공하였습니다.");
		location.href="login.jsp"
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