
<%@page import="GalleryBoardBean.GalleryBoardDAO"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.media.jai.JAI"%>
<%@page import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.image.renderable.ParameterBlock"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="GalleryBoardBean.GalleryBoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	//인코딩 한글 설정
	request.setCharacterEncoding("utf-8");

	
	GalleryBoardBean bBean = new GalleryBoardBean();
	
	//현재 실행중인 웹프로젝트에 대한 정보를 지니고 있는 객체 얻기 (파일전송 통로같은 역할)
	ServletContext ctx = getServletContext();
	
	//업로드할 실제 서버 경로 알아내기
	String realPath = ctx.getRealPath("image");
	
	//업로드할 수 있는 파일의 최대 크기 지정 10MB
	int size = 10*1024*1024;
	
	//실제 파일 이름과 경로상에 저장될 이름 변수설정
	String filename = "";
	String filerealname = "";
	
		//실제 파일업로드 담당 하는 객체 생성시.. 생성자로 업로드할 정보를 전달 하여 업로드 함.
		//매개변수1 : <form>에서 전달받은 값을 얻어오기 위해 request전달
		//매개변수2 : 업로드될 파일의 위치를 전달
		//매개변수3 : 업로드할수 있는 파일 사이즈 전달
		//매개변수4 : 업로드할 파일 명이 한글일경우 업로드시 깨지므로 문자셋 방식 지정
		//매개변수5 : 실제 업로드되는 위치에 같은 이름의 파일 업로드시 파일명이 중복되므로 
		//          업로드할 파일명을 자동으로 변환해주는 객체 전달
		MultipartRequest multi = new MultipartRequest(
										request, //request 영역에 있는 저장된 값들
										realPath, //파일저장시킬 경로
										size, //설정한 파일 크기
										"UTF-8", //한글깨짐 방지
										new DefaultFileRenamePolicy() // 파일명 중복 방지 
									);
		
		//request객체의 getParameter()메소드대신... 
		//MultipartRequest객체의 getParameter()메소드를 사용하여
		//요청한 텍스트 값을 얻는다.
		String id = multi.getParameter("id");
		String subject =multi.getParameter("subject");
		String passwd = multi.getParameter("passwd");
		String content = multi.getParameter("content");
		
		
		Enumeration e = multi.getFileNames();
		
		//Enumeration 반복기 역할을 하는 객체 내부에 값이 저장되어 있는 동안
		while(e.hasMoreElements()) {
			
			//파일업로드시 선택한 <input>태그의 name 속성값 
			String name = (String)e.nextElement();
			
			filename = multi.getOriginalFileName(name);
			
			filerealname = multi.getFilesystemName(name);		
		}
		
		bBean.setId(id);
		bBean.setSubject(subject);
		bBean.setPasswd(passwd);
		bBean.setContent(content);
		bBean.setFilename(filename);
		bBean.setFilerealname(filerealname);
		
		GalleryBoardDAO gboardDAO = new GalleryBoardDAO();
		
		int check = gboardDAO.insertBoard(bBean);
		if ( check == 1 ) {
	%>
			<script type="text/javascript">
				alert("게시글 등록 완료");
	
			</script>
	<% 	
			response.sendRedirect("inotice.jsp");
		} else {
	%>	
			<script type="text/javascript">
				alert("비밀번호가 다릅니다.");
				location.href="inotice.jsp";
			</script>
	<%
		}
	%>			
		
		
		
		
		
		
		
		
		
		
		
		
		
		