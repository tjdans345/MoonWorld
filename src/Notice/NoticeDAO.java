package Notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Board.BoardBean;


public class NoticeDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//getConnection()
	private Connection getConnectoin() throws Exception {
	Connection con = null;
	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
	con=ds.getConnection();
	return con;
	
	}
	
	private void freeResource() {
		if(rs != null) try {rs.close();} catch (Exception ex) {}
		if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
		if(con != null) try {con.close();} catch (Exception ex) {}
	}

  //게시판 글 작성(주글)
  public void insertBoard(NoticeBean nBean) {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = ""; 
	int num = 0; // 글번호 저장
	
	try {
		//1,2 디비연결 메서드 호출
		con = getConnectoin();
		
		//3 num 구하기
		//글이 없을 경우 : 글번호 1
		//글이 있을 경우 : 최근글번호(번호가 가장큰값) + 1
		//sql 내장함수 MAX(컬럼명)
		sql = "select max(num) from notice"; //가장 큰 글번호 가져오기
		pstmt=con.prepareStatement(sql);
		rs=pstmt.executeQuery();
		if(rs.next()) {
			num=rs.getInt(1)+1; //글이 있을경우 최대값  + 1
		} else {
			num=1; //글이 없을 경우
		}
		//3 insert
		sql = "insert into notice" + "(num,subject,content,date, id, readcount)" + "values(?,?,?,?,?,?)";
		
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.setString(2, nBean.getSubject());
		pstmt.setString(3, nBean.getContent());
		pstmt.setTimestamp(4, nBean.getDate());
		pstmt.setString(5, nBean.getId());
		pstmt.setInt(6, 0);
		
		//4 실행
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("insertBoard 메소드 내부에서 오류 : " + e);
	} finally {
		freeResource();
		if(rs != null) try {rs.close();} catch (Exception ex) {}
		if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
		if(con != null) try {con.close();} catch (Exception ex) {}
		
	}
  }
  
//게시판 전체글개수 반환하는 메소드
	public int getBoardCount() {
		
		String sql = "";
		int count = 0;
		try {
			//1,2 디비연결
			con = getConnectoin();
			//3 sql 전체글개수 가져오기 select count(*)
			sql = "select * from notice ";
			
			pstmt=con.prepareStatement(sql);
			//4 rs 실행 저장
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				count++;
			}
			
		} catch (Exception e) {
			System.out.println("getBoardCount 메소드 내부에서 오류 : " + e);
		} finally {
			freeResource();
			if(rs != null) try {rs.close();} catch (Exception ex) {}
			if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
			if(con != null) try {con.close();} catch (Exception ex) {}
		}
		return count;
	}
	
	public List<NoticeBean> getBoardList(int startRow, int pageSize) {
  		
  		Connection con = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;
  		String sql = "";
  		List<NoticeBean> boardList = new ArrayList<NoticeBean>();
  		
  		try {
			//1,2 디비연결
  			con=getConnectoin();
  			//3 sql에서 전체 데이터 가져오기
  			// 정렬 re_ref 내림차순 re_seq 오름차순
  			// limit 각페이지 마다 맨위에 첫번째로 보여질 시작글번호 , 하뉴ㅔ이지당 보여줄 글 개수
  			sql = "select * from notice order by num desc limit ?,?";
  			
  			pstmt = con.prepareStatement(sql);
  			pstmt.setInt(1, startRow);
  			pstmt.setInt(2, pageSize);
  			// rs 실행 저장
  			rs = pstmt.executeQuery();
  			//5 while 데이터 있으면
  			// rs = > 자바빈 = > boardList 추가
  			while(rs.next()) {
  				//BoardBean객체 생성
  				NoticeBean nbean = new NoticeBean();
  				//rs = > BoardBean객체에 저장
  				nbean.setContent(rs.getString("content"));
  				nbean.setDate(rs.getTimestamp("date"));
  				nbean.setSubject(rs.getString("subject"));
  				nbean.setNum(rs.getInt("num"));
  				nbean.setId(rs.getString("id"));
  				//BoardBean객체 => boardList에 추가
  				boardList.add(nbean);
  			}
  			
		} catch (Exception e) {
			System.out.println("getBoardList 내부에서 오류 : " + e);
		} finally {
			freeResource();
			if(rs != null) try {rs.close();} catch (Exception ex) {}
			if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
			if(con != null) try {con.close();} catch (Exception ex) {}
		}
  			return boardList; 
  	}
	
	public void updateReadCount(int num) {
  		
  		Connection con = null;
  		PreparedStatement pstmt = null;
  		ResultSet rs = null;
  		String sql = "";
  		try {
			//1,2 디비연결
  			con=getConnectoin();
  			//3 sql update 테이블 set readcount=readcount+1 where num=
  			sql = "update notice set readcount=readcount+1 where num=?";
  			pstmt=con.prepareStatement(sql);
  			pstmt.setInt(1, num);
  			//4 실행
  			pstmt.executeUpdate();
  			 
		} catch (Exception e) {
			System.out.println("updateReadCount 메소드 내부에서 오류 : " + e );
		} finally {
			freeResource();
			if(rs != null) try {rs.close();} catch (Exception ex) {}
			if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
			if(con != null) try {con.close();} catch (Exception ex) {}
		}
  		
  	}
	
	//글 상세 내용 뿌려주기 메소드
		public NoticeBean getBoard(int num) {
		
		NoticeBean boardbean = new NoticeBean();
		Connection con = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
		con = getConnectoin();
		sql = "select * from notice where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		//컬럼이름일때는 "", 변수일 때는 "" 안써도 됨
		if(rs.next()) {
			boardbean.setNum(rs.getInt("num"));
			boardbean.setReadcount(rs.getInt("readcount"));
			boardbean.setId(rs.getString("id"));
			boardbean.setDate(rs.getTimestamp("date"));
			boardbean.setSubject(rs.getString("subject"));
			boardbean.setContent(rs.getString("content"));
		}
		
		
	} catch (Exception e) {
		System.out.println("getBoard 메소드 내부에서 오류 : " + e);
	} finally {
		freeResource();
		if(rs != null) try {rs.close();} catch (Exception ex) {}
		if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
		if(con != null) try {con.close();} catch (Exception ex) {}
	}
			return boardbean;
	}
  
		public int delContent(int num) {
	  		
//	  		Connection con = null;
//	  		PreparedStatement pstmt = null;
//	  		ResultSet rs = null;
//	  		String sql = "";
	  		String sql = "";
	  		int check = 0;     //1 -> 삭제 성공
	  						   //0 -> 삭제 실패
	  		
	  		try {
	  			
	  			con = getConnectoin();
	  			sql = "delete from notice where num=? ";
	  			pstmt = con.prepareStatement(sql);
	  			pstmt.setInt(1, num);
	  			
	  			check = pstmt.executeUpdate(); //rs영역에 저장
	  			
	  			

	  			
			} catch (Exception e) {
				System.out.println("delContent 메소드 내부에서 오류 : " + e);
			} finally {
				freeResource();
				if(rs != null) try {rs.close();} catch (Exception ex) {}
				if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
				if(con != null) try {con.close();} catch (Exception ex) {}
			}
	  		
	  		return check;
	  		
	  	}	
		
		public int updateBoard(NoticeBean bBean) {
	  		int check = 0;
	  		Connection con = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null;
	  		String sql = ""; 
	  		
	  		try {
				//1,2 디비연결
	  			con=getConnectoin();
	  			//3 sql num에 해당하는 passwd가져오기
	  			sql = "select id from notice where num=?";
	  			pstmt=con.prepareStatement(sql);
	  			pstmt.setInt(1, bBean.getNum());
	  			//4 rs = 실행 저장
	  			rs = pstmt.executeQuery();
	  			
	  			//5 rs 데이터 있으면 비밀번호비교 맞으면 check=1
	  			// 3 update 테이블 set name, subject, content where num
	  			// 4 실행
	  			//						틀리면 check = 0
	  			if(rs.next()) {
	  				
	  					sql = "update notice set id=?, subject=?, content=? where num=?";
	  					pstmt=con.prepareStatement(sql);
	  					
	  					pstmt.setString(1, bBean.getId());
	  					pstmt.setString(2, bBean.getSubject());
	  					pstmt.setString(3, bBean.getContent());
	  					pstmt.setInt(4, bBean.getNum());
	  					//4
	  					check = pstmt.executeUpdate();
	  					
	  					
	  				} else {
	  					check = 0;
	  				}
	  			
	  			
			} catch (Exception e) {
				System.out.println("updateBoard 메소드 내부에서 오류 :" + e);
			} finally {
				freeResource();
				if(rs != null) try {rs.close();} catch (Exception ex) {}
				if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
				if(con != null) try {con.close();} catch (Exception ex) {}
			}
	  			return check;
	  		
	  	}
		
		
}


