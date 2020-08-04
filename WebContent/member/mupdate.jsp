<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>회원 정보 수정</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="./cssets/css/main.css" />
	</head>
	<% 
	//추가1.
	//세션값 가져오기 
	//세션값을 가져오는 이유 : 글쓰기 화면에 이름을 뿌려주기 위한 용도
		String id = (String) session.getAttribute("id");
	//세션값이 없으면 login.jsp
	
	if (id == null) {
	%>
		<script type="text/javascript">
		alert("로그인이 필요합니다.");
		location.href="login.jsp";
		</script>
	<%
	}
%>	
	<body>
		<div id="page-wrapper">
		
			<!-- Header -->
			<jsp:include page="../inc/top.jsp" />

			<!-- Main -->
				<div id="main" class="wrapper style1">
					<div class="container">
						<header class="major">
							<h2>회원정보 수정을 위해 비밀번호를 입력해주세요</h2>
						</header>
					<div align="center">
					<form action="mupdatePro.jsp" id="mup_form">
					<input type="password" name="pass" id="mUp_pass"><br>
					<input type="submit" value="확인" class="special" id="btnSend"/>
					</form>
					</div>
					</div>
				</div>

		</div>

		<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />
	</body>
</html>