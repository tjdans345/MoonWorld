<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>

	<script type="text/javascript">
		function winopen() {
			//id공백이면 아이디 입력하세요. 포커스깜빡
 			if(document.fr.id.value == "") {
 				alert("아이디를 입력하세요.");
 				document.fr.id.focus();
 				return;
		} else { 
			//창열기 join_IDCheck.jsp width=400, height=200
			var fid = document.fr.id.value;
			 window.open("join_IDcheck.jsp?userid="+fid, "", "width=500,height=350");
		 }
		}
		
		
		
	</script>
	
	<head>
		<title>No Sidebar - Landed by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link href="./css/member.css" rel="stylesheet">
		<link rel="stylesheet" href="./bssets/css/main.css" />
	
		<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
		<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
			
			
			$("#id").blur(function() {
						 
				 if(!re.test($("#id").val())){
					 $("#id_sp2").show('fast');
					 $("#id").val("");
					/* alert("id는 4자이상 입력해야 합니다."); */
				 }else{$("#id_sp2").hide('fast');}
			
			});//id
			
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
		
		function inputIdChk() {
			document.fr.idDuplication.value = "idUncheck";
		}
		
		function checkVlaue() {
			
			if(!fr.pass.value){
				alert("비밀번호를 입력해주세요");
				return false;
			}
			
			if(!fr.name.value) {
				alert("이름을 입력해주세요");
				return false;
			}
			
			if(!fr.phone.value) {
				alert("전화번호를 입력해주세요");
				return false;
			}
			
			if(!fr.email.value) {
				alert("이메일을 입력해주세요");
				return false;
			}
			
			if(fr.idDuplication.value != "idcheck") {
				alert("아이디 중복체크를 해주세요");
				return false;
			} else {
				document.fr.submit();
			}
		
		} 
		
			</script>
	<style type="text/css">
	#join fieldset span{
		color: #ff6666;
		font-size: 12px;
	}
	
	</style>
		
		
	</head>
	<body>
		<div id="page-wrapper">

			<!-- Header -->
			<jsp:include page="../inc/top.jsp" />

			<!-- Main -->
	<form action="joinPro.jsp" method="post" id="join" name="fr">
  <div class="container" id="mem_join_con" align="center"> <hr>
    <h1>Sign Up</h1> <hr>

	<fieldset id="mem_join">
	<legend>필수 입력사항</legend>
	<div>
	<ul id="id_sec">
	<label for="id"><b>ID</b>
	<span id="id_sp2"> *아이디는 4~12자의 영문 대소문자와 숫자만 가능합니다</span> &nbsp;&nbsp;&nbsp;
	<input type="text"  placeholder="Enter Id"  onkeydown="inputIdChk()" name="id" id="id" class="id" required> &nbsp;&nbsp;
	<input type="button" value="dup. check" class="dup" onclick="winopen()" />
	<input type="hidden" name="idDuplication" value="idUncheck"> </li>
	</label>
	</ul>

    <label for="psw"><b>Password</b> &nbsp; <span id="pass_sp1"> *비밀번호는 8~15자의 영문 대소문자와 숫자 특수문자만 가능합니다</span>&nbsp;&nbsp;&nbsp;
    <span id="pass_sp2"> *비밀번호에는 하나이상의 문자와 숫자 특수문자가 포함되어야 합니다.</span> &nbsp;&nbsp;&nbsp;
    <input type="password" placeholder="Enter Password" name="passwd" id="pass" required>
 	</label>
    <label for="psw-repeat"><b>Repeat Password</b>&nbsp;
    <span id="pass_sp3"> *비밀번호가 다릅니다.</span>&nbsp;&nbsp;&nbsp;
    <input type="password" placeholder="Repeat Password" name="passre" id="passre" required>
	</label>
	
  	<label for="name"><b>Name</b>&nbsp;
  	<span id="name_sp"> *이름은 2자 이상의 문자만 입력할 수 있습니다.</span>&nbsp;&nbsp;&nbsp;
    <input type="text" placeholder="Enter Name" name="name" id="name" required>
    </label>
    
    <label for="phone"><b>Phone</b>&nbsp;
    <span id="ph_sp"> *전화번호 형식이 잘못되었습니다.</span> &nbsp;&nbsp;&nbsp;
    <input type="text" placeholder="Enter Phone" name="phone" id="phone" required>
    </label>
    
    <label for="email"><b>Email</b>&nbsp;
    <span id="email_sp"> *이메일 형식이 잘못되었습니다.</span> &nbsp;&nbsp;&nbsp;
    <input type="text" placeholder="Enter email" name="email" id="email" required>
    </label>
    </fieldset>
    
    <fieldset>
	<legend>선택 입력사항</legend>
	
    <label for="birth"><b>Birth</b>&nbsp;
    <span id="birth_sp"> *생일은 형식이 올바르지 않습니다.(6자리 숫자만 가능)</span> &nbsp;&nbsp;&nbsp;
    <input type="text" placeholder="Enter birth" name="birth" id="birth">
	</label>
	
    <label for="addr"><b>Address</b> &nbsp;&nbsp;
    <input type="text" id="sample6_postcode" name="postcode" placeholder="우편번호" readonly="readonly" style="width: 50%">
	&nbsp; &nbsp;
	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" id="postcode_btn"> <br/>
	</label>
	<input type="text" id="sample6_address" name="addr1" placeholder="주소" readonly="readonly" style="width: 50%"> <br/><br/>
	<input type="text" id="sample6_address2" name="addr2" placeholder="상세주소" style="width: 50%">
	
	<br/><br/><br/>
    </fieldset> <br/>
    <div class="clearfix">
      <ul class="actions">
      	<li><input type="reset" value="다시입력" onclick = "document.fr.id.focus();"/></li>
		<li><input type="button" value="가입하기" class="special" id="btnSend" onclick="checkVlaue(); return false;"/></li>
	  </ul>
	  </div>
    </div> 
  
  </form>
  </div>
				

			<!-- Footer -->
				<jsp:include page="../inc/bottom.jsp" />



	</body>
</html>