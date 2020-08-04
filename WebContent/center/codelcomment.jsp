<%@page import="Comment.CommentDAO"%>
<%@page import="icomment.iCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
request.setCharacterEncoding("utf-8");
CommentDAO cDAO = new CommentDAO();

int conum = Integer.parseInt(request.getParameter("conum"));
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

int check = cDAO.delComment(conum);

if (check == 1) {
%>
	<script>
	alert("글이 삭제되었습니다.")
	location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>
		
<%		
	} else {
%>		
	<script>
	alert("글 삭제에 실패하였습니다.")
	</script>
<%		
	}
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