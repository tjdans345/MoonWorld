<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<!-- Website template by freewebsitetemplates.com -->
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="../assets/css/main.css" />	
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
 	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
		<!-- Header -->
				<jsp:include page="../inc/top.jsp" />
				
				
		<div id="body" class="contact">
			<div class="header">
			<br/><br/><br/>
			</div>
			<div class="body">
				
			
			</div>
			<div class="footer">
				
				<header class="major special">
					<h2>Find Moon🌕</h2>
				</header>
				
				
  <h3 style="text-align: center; margin-top: 100px;">본인인증을 위해 이름과 email주소를 입력해주세요</h3>

<form action="m_confrirmPro.jsp" style="max-width:400px; margin:50px auto;">
  <div class="input-container">
    <span class="log-span">이름</span> 
    <input class="input-field" type="text" placeholder="Username" name="name">
  </div>
   <div class="input-container">
    <span class="log-span">email</span>
    <input class="input-field" type="text" placeholder="가입하신 Email을 입력해주세요" name="email">
  </div>
  <br/>
  <div align="center">
  <ul class="actions">
 <li><input type="submit" value="입력" class="special" /></li>
 </ul>
 </div>
</form>
		
					
					
					
	
				</div>
			</div>
	
		<!-- Footer -->
			<jsp:include page="../inc/bottom.jsp" />
	
</body>
</html>
