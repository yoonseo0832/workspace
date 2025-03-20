package com.kh.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.kh.model.vo.Member;

/*
 * DAO (Database Access Object)
 * : DB에 직접 접근하여 사용자의 요청에 맞는 SQL문 실행 후 결과 반환
 *   --> JDBC 사용
 */
public class MemberDao {
	// * DB 정보 : 서버주소, 사용자명, 비밀번호 
	private final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private final String USER_NAME = "C##JDBC";
	private final String PASSWORD = "JDBC";
	
	public Member searchById(String id) {
		Member m = null;	
		// => controller에서 결과처리를 null로 비교하도록 작성되어 있음!
		
		// JDBC 객체 선언
		Connection conn = null;
		// Statement stat = null;
		PreparedStatement pstat = null;
		ResultSet rset = null;
		
		// 실행할 sql문
		// String sql = "SELECT * FROM MEMBER WHERE MEMBERID = '" + id + "'";
		String sql = "SELECT * FROM MEMBER WHERE MEMBERID = ?";
		// => 미완성된 sql. 변경되는 부분(변수가 사용된 부분)을 ?로 표시.
		
		try {
			// 1) jdbc driver 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2) Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			
			// 3) Statement 객체 생성
			// stat = conn.createStatement();
			// 3') PreparedStatement 객체 생성
			pstat = conn.prepareStatement(sql);
			// => 객체 생성 시 미완성SQL 을 전달하여 생성 (완성된sql도 전달 가능)
			// ? 를 값으로 변경할 때 : setXXX => XXX: 데이터타입
			//					   setXXX(물음표순서, 전달할값)
			pstat.setString(1, id);
			
			// 4) SQL문 실행, 5) 결과 받기
			// rset = stat.executeQuery(sql);
			// 4') SQL문을 전달하지 않고 실행 (=> 객체 생성 시 이미 전달함!)
			rset = pstat.executeQuery();
			
			// 6) 결과 처리 --> 조회된 데이터 추출
			if ( rset.next() ) {
				// => 조회된 결과가 있다면 한 행만 있을 것임! => 아이디에 UNIQUE 제약조건이 있기때문에
				m = new Member(
							rset.getInt("MEMBERNO"), 
							rset.getString("MEMBERID"),
							rset.getString("memberpw"),
							rset.getString("gender") == null ? ' ' : rset.getString("gender").charAt(0),
							rset.getInt("AGE"),
							rset.getString("email"),
							rset.getString("address"),
							rset.getString("PHONE"),
							rset.getString("HOBBY"),
							rset.getDate("enrollDate")
						);
			}
			// * 조건문이 끝난 시점에
			//	 - 조회된 데이터가 없다면 ? m(Member) 변수는 null 값일 것임!
			//   - 조회된 데이터가 있다면 ? m 변수는 새로 생성된 객체 정보를 담고 있을 것임!
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			// 7) 자원 반납
			try {
				rset.close();
				// stat.close();
				pstat.close();
				conn.close();
			} catch (SQLException e) { e.printStackTrace(); }
		}
		
		return m;
	}
	
	/**
	 * 회원 전체 목록을 조회하여 반환하는 메소드
	 * @return 전체 회원 목록
	 */
	public ArrayList<Member> selectAllList() {
		ArrayList<Member> list = new ArrayList<>();	// []
		
		// DQL(SELECT)문 실행 (여러 행 조회) ---> ResultSet 객체 ---> ArrayList에 담기
		
		// * JDBC용 객체 선언
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		
		// * 실행할 sql문
		String sql = "SELECT * FROM MEMBER ORDER BY MEMBERNO";
		/* 
		// 1) 쿼리문으로 해결
		sql = " SELECT MEMBERNO, MEMBERID, MEMBERPW, "
					+ " NVL(GENDER, ' ') GENDER, AGE, EMAIL, ADDRESS, "
					+ " PHONE, HOBBY, ENROLLDATE "
			+ " FROM MEMBER "
			+ " ORDER BY MEMBERNO ";
		
		System.out.println(sql);
		*/
		try {
			// 1) JDBC 드라이버 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2) Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			
			// 3) Statement 객체 생성
			stat = conn.createStatement();
			
			// 4) SQL 실행 , 5) 결과 받기
			rset = stat.executeQuery(sql);
			
			// 6) ResultSet 에 담겨져 있는 데이터를 하나하나 추출
			while(rset.next()) {
				
				
				// [1] 데이터를 추출하여 Member 객체에 담기(생성)
				Member m = new Member(
							rset.getInt("MEMBERNO"),
							rset.getString("MEMBERID"),
							rset.getString("memberpw"),
							// rset.getString("gender").charAt(0),
							// --> DB에 gender 컬럼에 null값이 존재 => 따라서 오류 발생!
							// 2) 추출 시 조건에 따라 분기처리
							rset.getString("gender") == null ? ' ' : rset.getString("gender").charAt(0),
							rset.getInt("AGE"),
							rset.getString("email"),
							rset.getString("address"),
							rset.getString("PHONE"),
							rset.getString("HOBBY"),
							rset.getDate("enrollDate")
						);
				
				// [2] Member 객체를 리스트에 추가
				list.add(m);				
			}
			// * 반복문이 끝난 시점
			//   --> 조회된 데이터가 있다면 ? 리스트에는 최소 한 개 이상의 데이터가 담겨져있을 것임!
			//   --> 조회된 데이터가 없다면 ? 리스트는 비어있을 것임!
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			// 7) 자원 반납
			try {
				rset.close();
				stat.close();
				conn.close();
			} catch(SQLException e) { e.printStackTrace(); }
		}
		
		return list;
	}

	/**
	 * 요청된 회원 정보를 DB에 추가하는 메소드
	 * @param m 사용자가 입력한 정보들이 담겨있는 Member 객체
	 * @return 추가(INSERT) 후 처리된 행 수
	 */
	public int insertMember(Member m) {
		int result = 0;
		// DML(insert)  --->  int (처리된 행 수)  --->  트랜잭션 처리
		/*
		String sql = "INSERT INTO MEMBER"
				+ "        VALUES (SEQ_MNO.NEXTVAL"
				+ "                , '" + m.getMemberId() + "'"
				+ "                , '" + m.getMemberPw() + "'"
				+ "                , '" + m.getGender() + "'"
				+ "                , " + m.getAge()
				+ "                , '" + m.getEmail() + "'"
				+ "                , '" + m.getAddress() + "'"
				+ "                , '" + m.getPhone() + "'"
				+ "                , '" + m.getHobby() + "'"
				+ "                , SYSDATE)";
		*/
		String sql = "INSERT INTO MEMBER "
					+ " VALUES (SEQ_MNO.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE) ";
		System.out.println("--------------------------");
		System.out.println(sql);
		System.out.println("--------------------------");
		
		// * JDBC용 객체 선언
		Connection conn = null;
		PreparedStatement pstat = null;
		
		try {
			// 1) jdbc driver 등록
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2) Connection 객체 생성 (DB 정보로 연결)
			conn = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			conn.setAutoCommit(false); // -> Auto commit 해제
			
			// 3) Statement 객체 생성 (Connection 객체로 생성)
			pstat = conn.prepareStatement(sql);
			
			// 3-2) ? 채우기! -- 8개
			pstat.setString(1, m.getMemberId() );
			pstat.setString(2, m.getMemberPw() );
			pstat.setString(3, m.getGender() + "");
			pstat.setInt(4, m.getAge());
			pstat.setString(5, m.getEmail());
			pstat.setString(6, m.getAddress());
			pstat.setString(7, m.getPhone());
			pstat.setString(8, m.getHobby());
			
			// 4) SQL 실행 5) 결과 받기
			result = pstat.executeUpdate();
			
			// 6) 트랜잭션 처리
			if (result > 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 7) 자원 반납
			try {
				pstat.close();
				conn.close();
			} catch (SQLException e) { e.printStackTrace(); }
		}
		
		
		return result;
	}

	/**
	 * 요청된 회원 정보로 수정
	 * @param m	회원 아이디, 변경할 데이터 (비밀번호, 성별, 주소, 취미)
	 * @return	처리 결과(처리된 행 수)
	 */
	public int updateMember(Member m) {
		int result = 0;
		
		// * JDBC용 객체 선언
		Connection conn = null;
		PreparedStatement pstat = null;
		
		// * 실행할 쿼리문
		/*
		String sql = " UPDATE MEMBER "
				     + " SET MEMBERPW = '" + m.getMemberPw() + "' "
				       + " , GENDER = '" + m.getGender() + "' "
				       + " , ADDRESS = '" + m.getAddress() + "' "
				       + " , HOBBY = '" + m.getHobby() + "' "
				     + " WHERE MEMBERID = '" + m.getMemberId() + "'";
	     */
		String sql = " UPDATE MEMBER "
					+   " SET MEMBERPW = ?, GENDER = ?, ADDRESS = ?, HOBBY = ? "
				    + " WHERE MEMBERID = ?";
		
		// * JDBC 순서에 맞게 코드 작성
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			conn = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			conn.setAutoCommit(false);	
			// -> false로 설정하지 않을 경우 "자동 커밋이 설정된 채 커밋할 수 없습니다." 오류 발생!
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, m.getMemberPw());
			pstat.setString(2, Character.valueOf(m.getGender()).toString() );
			pstat.setString(3, m.getAddress());
			pstat.setString(4, m.getHobby());
			pstat.setString(5, m.getMemberId());
			
			
			
			result = pstat.executeUpdate();
			
			if (result > 0) conn.commit();
			else conn.rollback();
			
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstat.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}

		return result;
	}

	/**
	 * 전달받은 아이디에 해당하는 회원 정보 삭제
	 * @param id	삭제할 회원 아이디
	 * @return		처리 결과
	 */
	public int deleteMember(String id) {
		int result = 0;
		
		// * JDBC용 객체 선언
		Connection conn = null;
		PreparedStatement pstat = null;
		
		// * 실행할 쿼리문
		String sql = "DELETE FROM MEMBER " +
						" WHERE MEMBERID = ?";
		
		// * JDBC 순서에 맞게 코드 작성
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			conn = DriverManager.getConnection(URL, USER_NAME, PASSWORD);
			conn.setAutoCommit(false);
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			
			result = pstat.executeUpdate();
			
			if (result > 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstat.close();
				conn.close();				
			} catch (SQLException e) { e.printStackTrace(); } 
		}
		
		return result;
	}
}









