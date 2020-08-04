<%@page import="email.random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<% 
random r = new random();

String content = r.randomNum();

session.setAttribute("content", content);

%>

</head>
<body>

<form id="main-contact-form" name="contact-form" method="post" action="./../mailSend2">

	<input type="hidden" name="content" value="<%=content%>">

            <div class="col-sm-6">
                <div class="row  wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                  <div class="col-sm-2">
                    <div class="form-group">
                    	<label>*이름 </label>
                    </div>
                  </div>
                   <div class="col-sm-10">
                    <div class="form-group">
                      <input type="text" name="name" class="form-control" placeholder="Name" required="required">
                    </div>
                  </div>
                  
                  
                  <div class="col-sm-2">
                    <div class="form-group">
                    	<label>*E-mail </label>
                    </div>
                  </div>
                  <div class="col-sm-10">
                    <div class="form-group">
                      <input type="hidden" name="sender" class="form-control" placeholder="Email Address" required="required" value="hazelnutmocha890@gmail.com">
                    </div>
                  </div>
                  <div class="col-sm-12">
                    <div class="form-group">
                      <input type="email" name="receiver" class="form-control" placeholder="Email Address" required="required">
                    </div>
                  </div>
                
                 <div class="col-sm-2">
                    <div class="form-group">
                    	<label>*연락처 </label>
                    </div>
                  </div>
                  <div class="col-sm-10">
                    <div class="form-group">
                      <input type="text" name="phone" class="form-control" placeholder="Phone Number" required="required">
                    </div>
                  </div>
                
                </div>                    
                
            </div>
            <div class="col-sm-6">
              <div class="contact-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
			 <div class="col-sm-12">
                    	<label style="font-size: 15px; text-align: center; margin-top: 50px;"> 개인정보 수집 및 이용에 관한 동의 </label>
              </div>             
                
       <div class="form-group">
                  <button type="submit" class="btn-send">Send Now</button>
                </div>
              </div>                            
            </div>
            </form> 


</body>
</html>