<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		//한글처리
		request.setCharacterEncoding("utf-8");
		//update.jsp에서 전달받은 데이터중... id값 얻기
		String id = request.getParameter("id");
		
		//액션태그 useBean으로  BoardBean객체 생성
		//하는일 : update.jsp에서 요청한 request영역의 값을 꺼내서 BoardBean객체에 저장
	
	%>
	
		<jsp:useBean id="mbean" class="Member.MemberBean" />
		<jsp:setProperty property="*" name="mbean" />
		
	<%
		//DB작업할 BoardDAO객체 생성
		MemberDAO mdao = new MemberDAO();
			
		int check = mdao.updateMember(mbean);
		
		if(check == 1) {
	%>
			<script>
				alert("회원수정이 완료되었습니다!!");
				location.href="../index.jsp";
			</script>	
	<%
		} else {
	%>	
			<script>
				alert("회원수정에 실패하였습니다.");
				location.href = history.back();
			</script>
			
	<%	
		}
	%>
</body>
</html>