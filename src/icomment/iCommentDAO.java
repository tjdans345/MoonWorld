package icomment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Comment.CommentBean;

public class iCommentDAO {

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
	
	 public void insertBoard(iCommentBean bBean) {
			
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
				sql = "select max(num) from icomment"; //가장 큰 글번호 가져오기
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					num=rs.getInt(1)+1; //글이 있을경우 최대값  + 1
				} else {
					num=1; //글이 없을 경우
				}
				//3 insert
				sql = "insert into icomment" + "(id, content, num, date, pnumber)" + "values(?,?,?,?,?)";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,  bBean.getId());
				pstmt.setString(2, bBean.getContent());
				pstmt.setInt(3, num);
				pstmt.setTimestamp(4, bBean.getDate());
				pstmt.setInt(5, bBean.getPnumber());
				
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
	
	 public int getBoardCount(int DBnum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql="";
			int count=0;
			try {
				//1,2 디비연결
				con=getConnectoin();
				//3 sql 전체글개수 가져오기 select count(*)
				sql="select * from icomment where pnumber=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, DBnum);
				//4 rs 실행 저장
				rs=pstmt.executeQuery();
				while(rs.next()) {
					count++;
				}
			} catch (Exception e) {
				System.out.println();
			} finally {
				freeResource();
				if(rs != null) try {rs.close();} catch (Exception ex) {}
				if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
				if(con != null) try {con.close();} catch (Exception ex) {}
			}
				return count;
		}	
	
	
	 public List<iCommentBean> getBoardList(int startRow, int pageSize, int DBnum) {
		 	
			String sql = "";
			List<iCommentBean> boardList = new ArrayList<iCommentBean>();
			
			try {
				//1,2 디비연결
				con=getConnectoin();
				//3 sql 전체 데이터 가져오기
				// 정렬 re_ref 내림차순 re_seq 오름차순
				// limit 각페이지 마다 맨위에 첫번째로 보여질 시작글 번호, 한페이지당 보여줄 글개수
				sql = "select * from icomment where pnumber like ? order by num desc limit ?,?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, DBnum);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, pageSize);
				
				//4 rs 실행 저장
				rs=pstmt.executeQuery();
				//5 while
				// rs => 자바빈 => boardList추가
				while(rs.next()) {
					//BoardBean객체 생성
				iCommentBean cBean = new iCommentBean();
				//rs => BoardBean객체에 저장
				 cBean.setContent(rs.getString("content"));
				 cBean.setDate(rs.getTimestamp("date"));
				 cBean.setId(rs.getString("id"));
				 cBean.setNum(rs.getInt("num"));
				 //BoardBean객체 => boardList에 추가
				 boardList.add(cBean);
				}
			}catch (Exception e) {
				System.out.println("getBoardList 메서드 내부 오류 "+e);
			}finally {
				freeResource();
				if(rs != null) try {rs.close();} catch (Exception ex) {}
				if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
				if(con != null) try {con.close();} catch (Exception ex) {}
			}
			return boardList; //boardList 리턴
		}
	
	 public int delComment(int num) {
		 
		 String sql = "";
		 int check = 0;
		 
		 try {
	  			
	  			con = getConnectoin();
	  			sql = "delete from icomment where num=? ";
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
	
	
	
	
	
	
}
