<%@page import="java.sql.Timestamp"%>
<%@page import="Notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	request.setCharacterEncoding("utf-8");


%>   

<jsp:useBean id="nbean" class="Notice.NoticeBean" />
<jsp:setProperty property="*" name="nbean" />
    
<%

System.out.println(nbean.getId());
nbean.setDate(new Timestamp(System.currentTimeMillis()));

NoticeDAO nDAO = new NoticeDAO();

nDAO.insertBoard(nbean);

response.sendRedirect("information.jsp");


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