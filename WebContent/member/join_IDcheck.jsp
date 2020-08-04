<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
	Landed by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<%
request.setCharacterEncoding("utf-8");
%>
	<head>
	
	<script type="text/javascript">
		//8.
		function result() {
			//join.jsp 창을 open하게 해준페이지 <= join_IDcheck.jsp 창페이지
			opener.document.fr.id.value = document.nfr.userid.value;
			opener.document.fr.idDuplication.value = "idcheck";
			//창닫기
			window.close();
		}
	</script>
	
		<title>No Sidebar - Landed by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
	<body>
		
		
		
		<div id="page-wrapper">
				<!-- Main -->
				<div id="main" class="wrapper style1">
					<div class="container">
				
				<%
					//1.join.jsp의 function winopen()함수에 의해서 전달받은 userid값 가져오기
					//2.밑의 중복확인버튼 <form>태그로 부터 전달받은 userid값 가져오기
					String id = request.getParameter("userid");
					
					//3.디비객체생성 memberdao
					MemberDAO mdao = new MemberDAO();
					
					//4.MemberDAO클래스에...
					//아이디 중복 체크 유무 값 가져오기 DB작업을 위한 idCheck()메소드 추가
					
					//5.전달 받은 id값을 dB작업을 위한 idCheck()메소드로 다시 넘겨주어서...
					//아이디 중복 체크 유무 값 가져오기
					int check = mdao.idCheck(id);
					
					//6.
					//check ==1 "사용중인 ID입니다." //아이디 있음, 중복
					//check ==0 "사용가능한 ID입니다." //아이디없음, 중복아님
					if(check == 1) {
						out.println("사용중인 ID입니다.");
					} else {
						out.println("사용가능한 ID입니다.");
					
				%>
				<%-- 7. 사용가능한 ID이면 사용함 버튼을눌러서..부모창에 사용가능한 ID뿌려주기 --%>
				<input type="button" value="사용함" onclick="result()">
				<%
					}
				%>
					<%-- 먼저 --%>
					<form action="join_IDcheck.jsp" method="post" name="nfr"/>
						아이디:<input type="text" name="userid" value="<%=id%>">
						<input type="submit" value="중복확인">
					</div>
					</form>
				</div>
				
			

		</div>

		<!-- Scripts -->
			<script src="../assets/js/jquery.min.js"></script>
			<script src="../assets/js/jquery.scrolly.min.js"></script>
			<script src="../assets/js/jquery.dropotron.min.js"></script>
			<script src="../assets/js/jquery.scrollex.min.js"></script>
			<script src="../assets/js/skel.min.js"></script>
			<script src="../assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			

	</body>
</html>