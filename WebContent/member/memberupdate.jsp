<%@page import="Member.MemberBean"%>
<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>No Sidebar - Landed by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link href="./css/member.css" rel="stylesheet">
		<link rel="stylesheet" href="./bssets/css/main.css" />
	
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		
	
	</head>
	
	<%
		//추가1.
		//세선값 가져오기
		//세션값을 가져오는 이유 : 글쓰기 화면에 이름을 뿌려주기 위한 용도
		String id = (String) session.getAttribute("id");
		//세션값이 없으면 login.jsp
		if(id == null) {
	%>
		<script type="text/javascript">
		alert("로그인이 필요합니다.");
		location.href="login.jsp";
		</script>
	<%
		}
		
		MemberDAO mdao = new MemberDAO();
		
		MemberBean mbean = mdao.getMember(id);
	
	%>
	
	<script type="text/javascript">

		$(document).ready(function() {
			
			var getName= RegExp(/^[A-Za-z가-힣]{2}/);
			var re = /[a-zA-Z0-9]{4,12}$/;
			var pass = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/
			var getPass = RegExp(/[a-zA-Z]{1}[0-9]{1}/);
			var re2 = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
			var getPhone = RegExp(/^(010|011)[-\s]?\d{3,4}[-\s]?\d{4}$/);
			var getEmail = RegExp(/^[\w\.-]{1,64}@[\w\.-]{1,252}\.\w{2,4}$/);	
			var getBirth = RegExp(/^[0-9]{2}[0,1]{1}[0-9]{1}[0-3]{1}[0-9]{1}$/);
			//정규 표현식
			
			$("#id_sp2").hide()
			$("#pass_sp1").hide()
			$("#pass_sp2").hide()
			$("#pass_sp3").hide()
			$("#name_sp").hide()
			$("#ph_sp").hide()
			$("#email_sp").hide()
			$("#birth_sp").hide()
			
			
			$("#pass").blur(function() {
				 if(!pass.test($("#pass").val())){
					 $("#pass_sp1").show('fast');
					 $("#pass").val("");
				 }else{$("#pass_sp1").hide('fast');}
			 
				 if(!getPass.test($("#pass").val())){
					 $("#pass_sp2").show('fast');
					 $("#pass").val("");
				 }else{$("#pass_sp2").hide('fast');}
			
			});//pass
			
			$("#passre").blur(function() {
				var pass1 = $("#pass").val();
				var pass2 = $("#passre").val();
				 if(pass1!=pass2){
					 $("#pass_sp3").show('fast');
					 $("#passre").val("");
				 }else{$("#pass_sp3").hide('fast');}
			
			});//pass

			
			$("#name").blur(function() {		
				 if(!getName.test($("#name").val())){
					 $("#name_sp").show('fast');
					 $("#name").val("");
				 }else{$("#name_sp").hide('fast');} 
			});//name

			$("#phone").blur(function() {	
				 if(!getPhone.test($("#phone").val())){
					 $("#ph_sp").show('fast');
					 $("#phone").val("");
				 }else{$("#ph_sp").hide('fast');} 	 
			});//phone
			
			$("#email").blur(function() {	
				 if(!getEmail.test($("#email").val())){
					 $("#email_sp").show('fast');
					 $("#email").val("");
				 }else{$("#email_sp").hide('fast');} 	 
			});//email
			
			$("#birth").blur(function() {	
				 if(!getBirth.test($("#birth").val())){
					 $("#birth_sp").show('fast');
					 $("#birth").val("");
				 }else{$("#birth_sp").hide('fast');} 	 
			});//birth

		});

		
		function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수

	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;

	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('sample6_address').value = fullAddr;

	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('sample6_address2').focus();
	            }
	        }).open();
	    }
		
		function del() {
			if(confirm("정말 탈퇴하시겠습니까?") == true) {
				location.href="mdelete.jsp"
			} else {
				return;
			}
		}
		
		function checkVlaue() {
			
			if(!fo.pass.value){
				alert("비밀번호를 입력해주세요");
				return false;
			}
			
			if(!fo.name.value) {
				alert("이름을 입력해주세요");
				return false;
			}
			
			if(!fo.phone.value) {
				alert("전화번호를 입력해주세요");
				return false;
			}
			
			if(!fo.email.value) {
				alert("이메일을 입력해주세요");
				return false;
			} else {
				document.fo.submit();
			}
		
		} 
		
			</script>
			
			<style type="text/css">
			#join fieldset span{
				color: #ff6666;
				font-size: 12px;
			}
			
			</style>
	
	<body>
		<div id="page-wrapper">

			<!-- Header -->
			<jsp:include page="../inc/top.jsp" />

			<!-- Main -->
			
	<form action="memberupdatePro.jsp" method="post" id="join" name="fo">
  	<div class="container" id="mem_join_con" align="center"> <hr>
    <h1>회원정보 수정</h1> <hr>

	<fieldset id="mem_join">
	<legend>필수 입력사항</legend>
	<div>
	<br/> 
	<label for="id"><i class="fa fa-user"></i>ID &nbsp;
	<input type="text" id="id" name="id" value="<%=mbean.getId()%>" readonly="readonly"> &nbsp;&nbsp;
	</label>
	
    <label for="psw"><i class="fa fa-lock"></i>Password &nbsp; 
    <span id="pass_sp1"> *비밀번호는 8~15자의 영문 대소문자와 숫자 특수문자만 가능합니다</span>&nbsp;&nbsp;&nbsp;
    <span id="pass_sp2"> *비밀번호에는 하나이상의 문자와 숫자 특수문자가 포함되어야 합니다.</span> &nbsp;&nbsp;&nbsp;
    <input type="password"  name="passwd" id="pass" placeholder="새 비밀번호 "">
 	</label>
 	
    <label for="psw-repeat"><i class="fa fa-lock"></i>Password 확인 &nbsp;
    <span id="pass_sp3"> *비밀번호가 다릅니다.</span>&nbsp;&nbsp;&nbsp;
    <input type="password" placeholder="새 비밀번호 확인" name="passre" id="passre" >
	</label>
	
  	<label for="name"><i class="fa fa-smile-o"></i>Name &nbsp;
  	<span id="name_sp"> *이름은 2자 이상의 문자만 입력할 수 있습니다.</span>&nbsp;&nbsp;&nbsp;
    <input type="text" placeholder="Enter Name" id="name" name="name" value="<%=mbean.getName()%>">
    </label>
    
    <label for="phone"><i class="glyphicon glyphicon-phone"></i> Phone &nbsp;
    <span id="ph_sp"> *전화번호 형식이 잘못되었습니다.</span> &nbsp;&nbsp;&nbsp;
    <input type="text" placeholder="Enter Phone" id="phone" name="phone" value="<%=mbean.getPhone()%>">
    </label>
    
    <label for="email"><i class="fa fa-envelope"></i> Email &nbsp;
    <span id="email_sp"> *이메일 형식이 잘못되었습니다.</span> &nbsp;&nbsp;&nbsp;
    <input type="text" placeholder="Enter email" id="email" name="email" value="<%=mbean.getEmail()%>">
    </label>
    </fieldset>
    <br/><br/> 
    <fieldset>
	<legend>선택 입력사항</legend>
	<br/> 
	
    <label for="birth"><i class="fa fa-birthday-cake"></i> <b>Birth</b>&nbsp;
    <span id="birth_sp"> *생일은 형식이 올바르지 않습니다.(6자리 숫자만 가능)</span> &nbsp;&nbsp;&nbsp;
    <input type="text" placeholder="Enter birth" name="birth" id="birth" value="<%=mbean.getBirth()%>" >
	</label>
	<div align="center">
    <label for="addr"><b>Address</b></label> &nbsp;&nbsp;
    <input type="text" id="sample6_postcode" name="postcode" placeholder="우편번호" readonly="readonly" value="<%=mbean.getPostcode() %>" style="width: 50%">
	&nbsp; &nbsp;
	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" id="postcode_btn"> <br/><br/> 
	</label>
	<input type="text" name = "addr1" id="sample6_address" placeholder="주소" readonly="readonly" value="<%=mbean.getAddr1()%>" style="width: 50%"> <br/><br/>
	<input type="text" name = "addr2" id="sample6_address2" placeholder="상세주소" value="<%=mbean.getAddr2()%>" style="width: 50%">
	</div>
	
	<br/><br/><br/>
    </fieldset> <br/>
    <div class="clearfix">
      <ul class="actions">
      	<li><input type="button" value="탈퇴하기" class="btn" id="btn2" onclick="del(); return false;" ></li>
		<li><input type="button" value="수정완료" class="special" id="btnSend" onclick="checkVlaue(); return false;"/></li>
	  </ul>
	  </div>
    </div> 
  
  </form>
  </div>
				

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />



	</body>
</html>