package GalleryBoardBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Board.BoardBean;

public class GalleryBoardDAO {
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	Connection con = null;
	
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
	
	//게시판 전체글개수 반환하는 메소드
	public int getBoardCount(String search) {
		
		String sql = "";
		int count = 0;
		
		try {
			//1,2 DB연결
			con = getConnectoin();
			sql = "select * from gboard where subject like ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			//4 rs 실행 저장
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				count++;
			}
			
		} catch (Exception e) {
			System.out.println("getBoardCount 메소드 내부에서 오류 :" + e);
		} finally {
			freeResource();
		}
			return count;
	}
	
	
	public List<GalleryBoardBean> getBoardList(int startRow, int pageSize, String search) {
		
		List<GalleryBoardBean> boardList = new ArrayList<GalleryBoardBean>();
  		String sql = "";
  		
  		
  		try {
			//1,2 디비연결
  			con=getConnectoin();
  			//3 sql에서 전체 데이터 가져오기
  			// 정렬 re_ref 내림차순 re_seq 오름차순
  			// limit 각페이지 마다 맨위에 첫번째로 보여질 시작글번호 , 한 페이지당 보여줄 글 개수
  			sql = "select * from gboard where subject like ? order by num desc limit ?,?";
  			
  			pstmt = con.prepareStatement(sql);
  			pstmt.setString(1, "%"+search+"%");
  			pstmt.setInt(2, startRow);
  			pstmt.setInt(3, pageSize);
  			// rs 실행 저장
  			rs = pstmt.executeQuery();
  			//5 while 데이터 있으면
  			// rs = > 자바빈 = > boardList 추가
  			while(rs.next()) {
  				//BoardBean객체 생성
  				GalleryBoardBean bBean = new GalleryBoardBean();
  				//rs = > BoardBean객체에 저장
  				bBean.setContent(rs.getString("content"));
  				bBean.setDate(rs.getTimestamp("date"));
  				bBean.setFilerealname(rs.getString("filerealname"));
  				bBean.setFilename(rs.getString("filename"));
  				bBean.setNum(rs.getInt("num"));
  				bBean.setReadcount(rs.getInt("readcount"));
  				bBean.setSubject(rs.getString("subject"));
  				bBean.setId(rs.getString("id"));
  				//BoardBean객체 => boardList에 추가
  				boardList.add(bBean);
  			}
  			
		} catch (Exception e) {
			System.out.println("getBoardList 내부에서 오류 : " + e);
		} finally {
			freeResource();
			if(rs != null) try {rs.close();} catch (Exception ex) {}
			if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
			if(con != null) try {con.close();} catch (Exception ex) {}
		}
  			return boardList; //boardList 리턴
  	}
	
	
	public int insertBoard(GalleryBoardBean bBean) {
		
		String sql = "";
		int check = 0;
		int num = 0;
		
		try {
			con = getConnectoin();
			
			sql = "select pass from cmember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bBean.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(bBean.getPasswd().equals(rs.getString("pass"))) {
					
					check=1;
					
					sql = "select max(num) from gboard";
					pstmt = con.prepareStatement(sql);
					rs=pstmt.executeQuery();
					
					if(rs.next()) {
						num = rs.getInt(1) + 1;
					} else {
						num = 1;
					}
					
					sql = "insert into gboard (num,id,passwd,filename,subject,content,filerealname,"
							+ "readcount,date)"
							+ "values(?,?,?,?,?,?,?,?,now())";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, bBean.getId());
					pstmt.setString(3, bBean.getPasswd());
					pstmt.setString(4, bBean.getFilename());
					pstmt.setString(5, bBean.getSubject());
					pstmt.setString(6, bBean.getContent());
					pstmt.setString(7, bBean.getFilerealname());
					pstmt.setInt(8, 0);
					
					pstmt.executeUpdate();
				} else {
					check = 0;
				}
				
			}
			
		} catch (Exception e) {
			
			System.out.println("insertBoard 내부에서 오류 : " + e);
		} finally {
			freeResource();
			if(rs != null) try {rs.close();} catch (Exception ex) {}
			if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
			if(con != null) try {con.close();} catch (Exception ex) {}
		}
			return check;
	}
	
	
	public void updateReadCount(int num) {
		
		String sql = "";
		try {
			
			con = getConnectoin();
			//3 sql update 테이블 set readcount=readcount+1 where num=?
			sql = "update gboard set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("updateReadCount 메소드 내부에서 오류 :" + e);
		} finally {
			freeResource();
			if(rs != null) try {rs.close();} catch (Exception ex) {}
			if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
			if(con != null) try {con.close();} catch (Exception ex) {}
		}
	}
	
	public GalleryBoardBean getBoard(int num) {
		
		GalleryBoardBean boardbean = new GalleryBoardBean();
		
		String sql = "";
		
		try {
			con = getConnectoin();
			sql = "select * from gboard where num= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			
			rs = pstmt.executeQuery();
			//컬럼이름일때는 "", 변수일때는 ""안써도 됨
			
			if(rs.next()) {
				boardbean.setNum(rs.getInt("num"));
				boardbean.setReadcount(rs.getInt("readcount"));
				boardbean.setId(rs.getString("id"));
				boardbean.setDate(rs.getTimestamp("date"));
				boardbean.setSubject(rs.getString("subject"));
				boardbean.setFilename(rs.getString("filename"));
				boardbean.setFilerealname(rs.getString("filerealname"));
				boardbean.setContent(rs.getString("content"));
			}
			
			
			
			
		} catch (Exception e) {
			System.out.println("getBoard 내부에서 오류 : " + e);
		} finally {
			freeResource();
			if(rs != null) try {rs.close();} catch (Exception ex) {}
			if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
			if(con != null) try {con.close();} catch (Exception ex) {}
		}
		
			return boardbean;
		
	}
	
	//게시물 삭제 메소드
	public int delContent(int num) {
		
		String sql = "";
		int check = 0;
		try {
			
			con = getConnectoin();
			sql = "delete from gboard where num=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			check = pstmt.executeUpdate();
			
			if(check == 1 ) {
  				
  				sql = "delete from comment where pnumber = ? ";
  				pstmt = con.prepareStatement(sql);
  				pstmt.setInt(1, num);
  				
  				pstmt.executeUpdate();
  				
  			}
			
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
	
	public int updateBoard(GalleryBoardBean bBean) {
		
		String sql = "";
		int check = 0;
		String pass = "";
		try {
			con = getConnectoin();
			sql = "select * from cmember where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, bBean.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next() ) {
				if(bBean.getPasswd().equals(rs.getString("pass"))) {
					System.out.println(rs.getString("pass"));
					sql = "update gboard set id=?, subject=?, content=? where num=?";
					
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, bBean.getId());
					pstmt.setString(2, bBean.getSubject());
					pstmt.setString(3, bBean.getContent());
					pstmt.setInt(4, bBean.getNum());
					
					check = pstmt.executeUpdate();
				} else { 
					check = 0;
				}
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
