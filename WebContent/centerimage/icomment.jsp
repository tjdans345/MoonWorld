<%@page import="icomment.iCommentDAO"%>
<%@page import="Comment.CommentDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");
%>    

<jsp:useBean id="bBean" class="icomment.iCommentBean"/> 
<jsp:setProperty property="*" name="bBean"/>    

<%

bBean.setDate(new Timestamp(System.currentTimeMillis()));


iCommentDAO cDAO = new iCommentDAO();

cDAO.insertBoard(bBean);
%>

<script>

location.href="icontent.jsp?num=<%=num%>&pageNum=1";

</script>

    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>