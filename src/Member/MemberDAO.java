package Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	//디비연결 메서드
	
	private Connection getConnection() throws Exception {
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/jspbeginner");
		con = ds.getConnection();
		return con;
	}
		
	public void freeResource(){
		if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
		if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
		if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
	}
	
	public int userCheck(String id, String passwd) {
		
		int check = -1;   // 1 - >아이디, 비밀번호맞음
						  // 0 -> 아이디 맞음, 비밀번호 틀림
						  // -1 -> 아이디 틀림
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = ""; 
		ResultSet rs = null;
		
		
		
		try {
			//1드라이버 로더 //2 디비 연결
			con = getConnection();
			//3 sql id에 해당하는 passwd 가져오기 위해.. 레코드 가져오기
			sql = "select * from cmember where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4실행 => rs
			rs=pstmt.executeQuery();
			
			//5 rs 첫행으로 이동하여 id에 해당하는 데이터가 있으면..
			// id가 DB에 존재 한다는 뜻과 같음.
			if(rs.next()) {
				//로그인시.. 입력한 pwd와 DB pwd같은지 비교 ?
				if(passwd.equals(rs.getString("pass"))) {
					check = 1 ;
				} else { //비밀번호가 틀리면
					check = 0; //아이디 맞음 비밀번호 틀림
				}
			} else { // 아이디에 해당하는 데이터가 존재 하지 않으면 //아이디가 없다는 뜻과 같음
					check = -1;
			}
			
		} catch (Exception e) {
			System.out.println("uesrCheck 메소드 내부에서 오류 : " + e);
		} finally {
			freeResource();
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return check;
	} //userCheck 메서드
	
	public int insertMember(MemberBean memberbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int result = 0;
		try {
			//DB커넥션풀 객체 얻기
			con = getConnection();
			sql = "insert into cmember (id, pass, reg_date, name, phone, email, gender, birth, postcode, addr1, addr2)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberbean.getId());
			pstmt.setString(2, memberbean.getPasswd());
			pstmt.setTimestamp(3, memberbean.getReg_date());
			pstmt.setString(4, memberbean.getName());
			pstmt.setString(5, memberbean.getPhone());
			pstmt.setString(6, memberbean.getEmail());
			pstmt.setString(7, memberbean.getGender());
			pstmt.setInt(8, memberbean.getBirth());
			pstmt.setString(9, memberbean.getPostcode());
			pstmt.setString(10, memberbean.getAddr1());
			pstmt.setString(11, memberbean.getAddr2());
			//insert 쿼리 실행
			result = pstmt.executeUpdate();		
			
		} catch (Exception e) {
			System.out.println("insertMember 메소드 내부에서 오류 :" + e);
		} finally {
			freeResource();	
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		return result;
		
	} //insertMember 메서드 끝
	
	public int idCheck(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		int check = 0 ;
		try {
			con = getConnection();
			sql = "select * from cmember where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				check=1;
			} else {
				check=0;
			}
		} catch (Exception e) {
			System.out.println("idCheck 메소드 내부에서 오류" + e);
		} finally {
			freeResource();
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
			return check;
	} //idCheck 함수 끝
	
	public int getPass(String id, String pass) {
		
		String sql = "";
		int check = 0;
		try {
			con = getConnection();
			sql = "select pass from cmember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					check = 1;
				}
			}
			
		} catch (Exception e) {
			System.out.println("getPass 메소드 내부에서 오류 : " + e);
		} finally {
			freeResource();
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
			return check;
	}
	
	public MemberBean getMember(String id) {
		
		MemberBean mbean = null;
		String sql = "";
		
		try {
			con = getConnection();
			
			sql = "select * from cmember where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
					
			mbean = new MemberBean();
			mbean.setAddr1(rs.getString("addr1"));
			mbean.setAddr2(rs.getString("addr2"));
			mbean.setPostcode(rs.getString("postcode"));
			mbean.setBirth(rs.getInt("birth"));
			mbean.setEmail(rs.getString("email"));
			mbean.setGender(rs.getString("gender"));
			mbean.setId(rs.getString("id"));
			mbean.setName(rs.getString("name"));
			mbean.setPasswd(rs.getString("pass"));
			mbean.setPhone(rs.getString("phone"));
			
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			freeResource();
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
			return mbean;
	} //getMember 메소드 끝
	
	public int updateMember(MemberBean mbean) {
		
		String sql = "";
		int check = 0 ;
		
		try {
			con = getConnection();
				
				sql = "update cmember set pass=?, name=?, phone=?, email=?, gender=?, birth=?, postcode=?, addr1=?, addr2=? where id=?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, mbean.getPasswd());
				pstmt.setString(2, mbean.getName());
				pstmt.setString(3, mbean.getPhone());
				pstmt.setString(4, mbean.getEmail());
				pstmt.setString(5, mbean.getGender());
				pstmt.setInt(6, mbean.getBirth());
				pstmt.setString(7, mbean.getPostcode());
				pstmt.setString(8, mbean.getAddr1());
				pstmt.setString(9, mbean.getAddr2());
				pstmt.setString(10, mbean.getId());
				//UPDATE
				check = pstmt.executeUpdate();
				
				
		} catch (Exception e) {
			System.out.println("updateMember 메소드 내부에서 오류 :" + e);
		} finally {
			freeResource();
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
			return check;
		
	}
	
	public void deleteMember(String id) {
		
			String sql = "";
		
		try {
			con = getConnection();
			sql = "delete from cmember Where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			System.out.println("deleteMember 메소드 내부에서 오류 : "+ e);
		} finally {
			freeResource();
			if(con != null){try {con.close();} catch (SQLException e) {e.printStackTrace();}}
			if(rs != null){try {rs.close();} catch (SQLException e) {e.printStackTrace();}}
			if(pstmt != null){try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}}
		}
		
		
		
		
		
		
	}
	
	
	
	public int confirm(String name, String email) {
		
		int check = 0;
		String sql = "";
		try {
			con = getConnection();
			
			sql = "select * from cmember where name=? and email=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				check = 1;
			}
			
		} catch (Exception e) {
			System.out.println("insert 실패 : "+e);
		}finally {
			freeResource();
		}
		
		return check;
	}
	

	public String getID(String name, String email) {
	
		String id="";
		String sql = "";
		try {
			con = getConnection();
			
			sql = "select id from cmember where name=? and email=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			id=rs.getString(1);
			
		} catch (Exception e) {
			System.out.println("insert 실패 : "+e);
		}finally {
			freeResource();
		}
		
		return id;
	}
	
	
	
	
	
	
	
	
	}

