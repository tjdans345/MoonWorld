<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<title>No Sidebar - Landed by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="../assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
	</head>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%

request.setCharacterEncoding("utf-8");

String id= (String)session.getAttribute("id");
%>


<body>

			<!-- Header -->
			<jsp:include page="../inc/top.jsp" />
			

						<div id="main" class="wrapper style1">
					<div class="container">
					<div align="center"><h4>추가하실 공지 사항을 적어주세요!</h4></div>
					<header class="major"></header>
					<!-- Table -->
							<section>
								<div class="table-wrapper">
								 <form action="adminWritePro.jsp" method= "post" name = "br">
								 <input type="hidden" name="id" value="<%=id%>">
								  <table class="alt">
										<tbody>
											<tr>
												<td>제목</td>
												<td><input type="text" name="subject" required></td>	
											</tr>
											<tr>
												<td>내용</td>
												<td><textarea name="content" cols="40" rows="13" required></textarea> </td>	
											</tr>
										</tbody>
									</table>
									<ul class="actions">
									   <div align="right">
												<li><input type="submit" value="글쓰기" class="special" /></li>
												<li><input type="button" value="메인페이지" onclick = "location.href='information.jsp'" /></li>
									   </div>	
									   
									</ul>
								</form>
								</div>
							</section>
					</div>
					<div class="12u$" align="center">
								
					</div>
					
					
				</div>

</body>
</html>