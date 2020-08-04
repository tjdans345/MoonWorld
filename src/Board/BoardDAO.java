package Board;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.tomcat.dbcp.dbcp2.SQLExceptionList;

import com.mysql.fabric.xmlrpc.base.Data;
import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

public class BoardDAO {
		
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
	  public void insertBoard(BoardBean bBean) {
		
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
			sql = "select max(num) from board"; //가장 큰 글번호 가져오기
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1)+1; //글이 있을경우 최대값  + 1
			} else {
				num=1; //글이 없을 경우
			}
			//3 insert
			sql = "insert into board" + "(num,name,passwd,subject,content,file,re_ref,re_lev,re_seq,readcount,date,ip)" + "values(?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, bBean.getName());
			pstmt.setString(3, bBean.getPasswd());
			pstmt.setString(4, bBean.getSubject());
			pstmt.setString(5, bBean.getContent());
			pstmt.setString(6, bBean.getFile());
			pstmt.setInt(7, num); // num 주글번호 기준 == re_ref 그룹번호 
			pstmt.setInt(8, 0); // re_lev 들여쓰기
			pstmt.setInt(9, 0); // re_seq 답글순서
			pstmt.setInt(10, 0); //readcount 조회수 0
			pstmt.setTimestamp(11, bBean.getDate());
			pstmt.setString(12, bBean.getIp());
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
	  	public int getBoardCount(String search) {
	  		
	  		String sql = "";
	  		int count = 0;
	  		try {
				//1,2 디비연결
	  			con = getConnectoin();
	  			//3 sql 전체글개수 가져오기 select count(*)
	  			sql = "select * from board where subject like ?";
	  			
	  			pstmt=con.prepareStatement(sql);
	  			pstmt.setString(1, "%"+search+"%");
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
	  	
	  	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {
	  		
	  		Connection con = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null;
	  		String sql = "";
	  		List<BoardBean> boardList = new ArrayList<BoardBean>();
	  		
	  		try {
				//1,2 디비연결
	  			con=getConnectoin();
	  			//3 sql에서 전체 데이터 가져오기
	  			// 정렬 re_ref 내림차순 re_seq 오름차순
	  			// limit 각페이지 마다 맨위에 첫번째로 보여질 시작글번호 , 하뉴ㅔ이지당 보여줄 글 개수
	  			sql = "select * from board where subject like ? order by re_ref desc, re_seq asc limit ?,?";
	  			
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
	  				BoardBean bBean = new BoardBean();
	  				//rs = > BoardBean객체에 저장
	  				bBean.setContent(rs.getString("content"));
	  				bBean.setDate(rs.getTimestamp("date"));
	  				bBean.setFile(rs.getString("file"));
	  				bBean.setIp(rs.getString("ip"));
	  				bBean.setName(rs.getString("name"));
	  				bBean.setNum(rs.getInt("num"));
	  				bBean.setPasswd(rs.getString("passwd"));
	  				bBean.setRe_lev(rs.getInt("re_lev"));
	  				bBean.setRe_ref(rs.getInt("re_ref"));
	  				bBean.setRe_seq(rs.getInt("re_seq"));
	  				bBean.setReadcount(rs.getInt("readcount"));
	  				bBean.setSubject(rs.getString("subject"));
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
	
	  	public void updateReadCount(int num) {
	  		
	  		Connection con = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null;
	  		String sql = "";
	  		try {
				//1,2 디비연결
	  			con=getConnectoin();
	  			//3 sql update 테이블 set readcount=readcount+1 where num=
	  			sql = "update board set readcount=readcount+1 where num=?";
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
	  		public BoardBean getBoard(int num) {
	  		
	  		BoardBean boardbean = new BoardBean();
	  		Connection con = null; 
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null;
	  		String sql = "";
	  		
	  		try {
				con = getConnectoin();
				sql = "select * from board where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				//컬럼이름일때는 "", 변수일 때는 "" 안써도 됨
				if(rs.next()) {
					boardbean.setNum(rs.getInt("num"));
					boardbean.setReadcount(rs.getInt("readcount"));
					boardbean.setName(rs.getString("name"));
					boardbean.setDate(rs.getTimestamp("date"));
					boardbean.setSubject(rs.getString("subject"));
					boardbean.setContent(rs.getString("content"));
					boardbean.setRe_ref(rs.getInt("re_ref"));
					boardbean.setRe_seq(rs.getInt("re_seq"));
					boardbean.setRe_lev(rs.getInt("re_lev"));
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
	  	
	  	public int updateBoard(BoardBean bBean) {
	  		int check = 0;
	  		Connection con = null;
	  		PreparedStatement pstmt = null;
	  		ResultSet rs = null;
	  		String sql = ""; 
	  		
	  		try {
				//1,2 디비연결
	  			con=getConnectoin();
	  			//3 sql num에 해당하는 passwd가져오기
	  			sql = "select passwd from board where num=?";
	  			pstmt=con.prepareStatement(sql);
	  			pstmt.setInt(1, bBean.getNum());
	  			//4 rs = 실행 저장
	  			rs = pstmt.executeQuery();
	  			
	  			//5 rs 데이터 있으면 비밀번호비교 맞으면 check=1
	  			// 3 update 테이블 set name, subject, content where num
	  			// 4 실행
	  			//						틀리면 check = 0
	  			if(rs.next()) {
	  				if(bBean.getPasswd().equals(rs.getString("passwd"))) {
	  					check = 1 ;
	  					//
	  					sql = "update board set name=?, subject=?, content=? where num=?";
	  					pstmt=con.prepareStatement(sql);
	  					
	  					pstmt.setString(1, bBean.getName());
	  					pstmt.setString(2, bBean.getSubject());
	  					pstmt.setString(3, bBean.getContent());
	  					pstmt.setInt(4, bBean.getNum());
	  					//4
	  					pstmt.executeUpdate();
	  					
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
	  	//게시물 삭제 메소드
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
	  			sql = "delete from board where num=? ";
	  			pstmt = con.prepareStatement(sql);
	  			pstmt.setInt(1, num);
	  			
	  			check = pstmt.executeUpdate(); //rs영역에 저장
	  			
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
	  	
	  	/* 
	  	 답변 달기 필드 설명
	  	 group(re_ref) 부모글과 그로부터 파생된 자식글들이 같은 값을 가지기 위한 필드
	  	 seq(re_seq)   같은 group 글들 내에서의 순서
	  	 level(re_lev) 같은 group내에서의 깊이 (들여쓰기)
	  	 
	  	 답변 달기 규칙 설명
	  	 순서 1) group(re_ref)값은 부모글의 그룹번호(re_ref)를 사용한다.
	  	 
	  	 순서 2) seq(re_seq)값을 부모글의 seq(re_seq)에서 + 1 증가한 값을 사용한다.
	  	 		단!! 부모글을 제외한 같은 group내에서 먼저 입력된 글은 seq값을 +1 증가 시킨다.
	  	순서 3) level(re_lev)값은 부모글의 re_lev에서 + 1 증가한 값을 사용한다.
	  	
	  	*/
	  		/* 답변달기 메소드 : 
	  		 *  부모글의 group(re_ref), seq(re_seq), level(re_lev) 값 +
	  		 *  답변글내용 또한 지니고 있는 BoardBean객체 전달받아 처리 */
	  	public void reInsertBoard(BoardBean bBean) {
	  			
	  		
	  		String sql = "";
	  		int num = 0;
	  		
	  		try {
	  			con = getConnectoin();
	  			/*답변글 글번호 구하기*/
	  			//3 기존글 중 num이 가장큰 글번호 가져오기
	  			sql = "select max(num) from board";
	  			pstmt=con.prepareStatement(sql);
	  			//4 rs = 실행 저장
	  			rs = pstmt.executeQuery();
	  			//5 글번호가 있으면...
	  			if(rs.next()) {
	  				//답변글번호 = 그글번호에 + 1
	  				num=rs.getInt(1)+1;
	  			} else { //글번호가 없으면
	  				//답변을 달 답변글번호를 1로 지정
	  				num = 1;
	  			}
	  			
	  			/* re_seq 답글순서 재배치 */
	  			// 부모글 그룹과 같은 그룹이면서... 부모글의 seq값보다 큰 답변글들은? seq값을 1증가 시킨다.
	  			sql="update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
	  			pstmt=con.prepareStatement(sql);
	  			pstmt.setInt(1, bBean.getRe_ref());
	  			pstmt.setInt(2, bBean.getRe_seq());
	  			pstmt.executeUpdate();
	  			
	  			/* 답변글 달기 */
	  			//3 insert //re_seq + 1 re_lev+1 답글달기
	  			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
	  			pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, bBean.getName());
				pstmt.setString(3, bBean.getPasswd());
				pstmt.setString(4, bBean.getSubject());
				pstmt.setString(5, bBean.getContent());
				pstmt.setString(6, bBean.getFile());
				pstmt.setInt(7, bBean.getRe_ref()); // num 주글번호 기준 == re_ref 그룹번호 
				pstmt.setInt(8, bBean.getRe_lev()+1); // 부모글의 re_lev에 + 1을 하여 들여쓰기
				pstmt.setInt(9, bBean.getRe_seq()+1); // 부모글의 re_seq에 + 1을 하여 답글을 단 순서 정하기
				pstmt.setInt(10, 0); //readcount 조회수 
				pstmt.setTimestamp(11, bBean.getDate());
				pstmt.setString(12, bBean.getIp());
				//4 실행
				pstmt.executeUpdate();
	  			
	  			
			} catch (Exception e) {
				System.out.println("reInsertBoard 메소드 내부에서 오류 :" + e);
			} finally {
				freeResource();
				if(rs != null) try {rs.close();} catch (Exception ex) {}
				if(pstmt != null) try {pstmt.close();} catch (Exception ex) {}
				if(con != null) try {con.close();} catch (Exception ex) {}
			}
	  		
	  		
	  	}
	  	
	  	
	  	
	  	
	  	
	  	
}
